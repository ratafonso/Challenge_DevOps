resource "aws_db_subnet_group" "db-snet-g" {
  name = "db-subnet-g"
  subnet_ids = [module.vpc.db_subnets[0], module.vpc.db_subnets[1], module.vpc.db_subnets[2]]
}

# Generate a random password for DB instance
resource "random_password" "db-password" {
  length  = 32
  upper   = true
  numeric  = true
  special = false
}

resource "aws_security_group" "db_sg" {


  lifecycle {
    create_before_destroy = true
  }

  description = "MySQL Security Group"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress = [
    {
      description      = "MySQL"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 3306
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/16"]
      to_port          = 3306
    }
  ]

  name   = "sg_${var.project_name}-${local.namespace}-db"
  vpc_id = var.vpc_id
}

resource "aws_db_instance" "db-rds" {
  backup_retention_period     = 15
  identifier                  = "db-prod"
  allocated_storage           = 10
  max_allocated_storage       = 50
  db_name                     = "db_app_ada"
  engine                      = "mysql"
  engine_version              = "8.0.40"
  auto_minor_version_upgrade  = true
  publicly_accessible         = false
  instance_class              = "db.t4g.small"
  multi_az                    = true
  storage_encrypted           = true
  storage_type                = "gp3"
  db_subnet_group_name        = aws_db_subnet_group.db-snet-g.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  username                    = "appada"
  password                    = random_password.db-password.result
  skip_final_snapshot         = true
  copy_tags_to_snapshot       = true

  lifecycle {
    ignore_changes = [
      engine_version,
      password
    ]
  }
}