variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-2"
}

variable "aws_profile" {
  description = "Profile to use from ~/.aws/credentials"
  default     = "default"
}

variable "aws_account_id" {}

variable "availability_zones" {
  description = "The availability zones"
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  type        = "list"
}

variable "dns_root" {
  description = "The domain or subdomain to create names in"
  default     = "aws.example.com"
}

variable "dns_zone_id" {
  description = "The AWS identifier for the hosted zone to add names to"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "ecs"
}

variable "ssh_key_name" {
  description = "Existing ec2 SSH key to launch instances with."
}

/* 2016.09.f per http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html */
/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    us-east-1      = "ami-b2df2ca4"
    us-east-2      = "ami-832b0ee6"
    us-west-1      = "ami-dd104dbd"
    us-west-2      = "ami-022b9262"
    eu-west-1      = "ami-a7f2acc1"
    eu-west-2      = "ami-3fb6bc5b"
    eu-central-1   = "ami-ec2be583"
    ap-northeast-1 = "ami-c393d6a4"
    ap-southeast-1 = "ami-a88530cb"
    ap-southeast-2 = "ami-8af8ffe9"
    ca-central-1   = "ami-ead5688e"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

/* TODO: go back to creating a key */
variable "key_name" {
  description = "The name of an aws ssh key that already exists."
  default     = ""
}

# variable "key_file" {
#   description = "The ssh public key for using with the cloud provider."
#   default     = ""
# }

/* TODO: This should go away, or be optional. */
variable "s3_jenkins_backup" {
  description = "bucket/path to use to populate jenkins_home"
}

variable "s3_bucket_base_key" {
  description = "namespace like aws.example.com to prevent bucket name collisions. Specific keys will be prepended"
}

variable "webapp_names" {
  description = "comma delimited list of the ECR repos to create"
  default     = ["webapp"]
  type        = "list"
}

variable "stack_prefix" {
  description = "This prefix will be attached to all named resources to prevent collision"
}
