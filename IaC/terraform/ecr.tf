resource "aws_ecr_repository" "frontend" {
  name = "frontend"
  image_scanning_configuration {
    scan_on_push = true 
  }
}

resource "aws_ecr_repository" "backend" {
  name = "backend"
  image_scanning_configuration {
    scan_on_push = true 
  }
}

data "aws_iam_policy_document" "ecr" {
  statement {
    sid = "Allow account admin of ecr"
    actions = [
      "ecr:*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
 
  statement {
    sid = "AllowPullFromDevToolsProd"
    effect = "Allow" 
    actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer"   
    ]
    principals {
      type = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:PrincipalOrgPaths"

      values = [
        "/o-eskdibb0aq/*",
      ]
    }
  }

  statement {
    sid = "Allow all service accounts access"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:ListTagsForResource"    
    ]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_ecr_repository_policy" "policy_frontend" {
  repository = aws_ecr_repository.frontend.name
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_ecr_repository_policy" "policy_backend" {
  repository = aws_ecr_repository.backend.name
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_ecr_lifecycle_policy" "microservices-lifecycle-fe" {
  repository = aws_ecr_repository.frontend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        { 
            "rulePriority": 2,
            "description": "Keep last 100 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 100
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "microservices-lifecycle-be" {
  repository = aws_ecr_repository.backend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        { 
            "rulePriority": 2,
            "description": "Keep last 100 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 100
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}