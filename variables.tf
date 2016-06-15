variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-1"
}

variable "aws_account_id" {}

variable "availability_zones" {
  description = "The availability zones"
  default     = "eu-west-1a,eu-west-1b,eu-west-1c"
}

variable "dns_root" {
  description = "The domain or subdomain to create names in"
  default     = "aws.example.com"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "default"
}

variable "ssh_key_name" {
  description = "Existing ec2 SSH key to launch instances with."
}

/* ECS optimized AMIs per region */
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

variable "key_name" {
  description = "The aws ssh key name."
  default     = ""
}

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default     = ""
}

variable "s3_jenkins_backup" {
  description = "bucket/path to use to populate jenkins_home"
}

variable "webapp_tag" {
  description = "Docker tag on the image (default 'latest')"
  default     = "latest"
}

variable "webapp_name" {
  default = "webapp"
}

variable "webapp_db_user" {
  description = "Name of the user that will connect, also name of DB"
  default     = "webapp"
}

variable "webapp_db_password" {
  default = "Chang3Th1s"
}

variable "webapp_db_engine" {
  default = "mysql"
}

variable "webapp_db_engine_version" {
  default = "5.6.27"
}

variable "webapp_db_instance_class" {
  default = "db.t2.micro"
}

variable "webapp_db_size" {
  description = "Database size in gigs (mysql minimum is 5gb)"
  default     = 5
}

variable "web_server_container_name" {
  default = "web_server"
}
