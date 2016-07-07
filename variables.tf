variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
}

variable "aws_account_id" {}

variable "availability_zones" {
  description = "The availability zones"
  default     = "us-east-1b,us-east-1c,us-east-1d"
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
  default     = "default"
}

variable "ssh_key_name" {
  description = "Existing ec2 SSH key to launch instances with."
}

/* ECS optimized AMIs per region - TODO, find the updated IDs for other regions */
variable "amis" {
  default = {
    ap-northeast-1 = "ami-8aa61c8a"
    ap-southeast-2 = "ami-5ddc9f67"
    eu-west-1      = "ami-2aaef35d"
    us-east-1      = "ami-8f7687e2" /* Updated to 2016.03c */
    us-west-1      = "ami-5721df13"
    us-west-2      = "ami-cb584dfb"
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

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default     = ""
}

/* TODO: This should go away, or be optional. */
variable "s3_jenkins_backup" {
  description = "bucket/path to use to populate jenkins_home"
}

variable "webapp_names" {
  description = "comma delimited list of the ECR repos to create"
  default     = "webapp"
}
