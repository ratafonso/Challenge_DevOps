variable "environment" {
    description = "Value of the environment"
    type = string
}

variable "sg_server_access" {
    description = "Security Group Server Access"
    default = "sg-0ae47a517a6b64b7a"
}

variable "project_name" {
  description = "Name of the workload. Used to compose some resource names"
  type        = string
  default     = "letscodebyada"
}

variable "region" {
  description = "AWs Region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  default = "eks-cluster-ada"
}

variable "node_group_name" {
  default = "node-group-ada"
}

variable "instance_type" {
  default = "m6i.large"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "ami_type" {
  default = "AL2_x86_64"
}
