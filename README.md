# terraform-ecs-jenkins
Bootstrap AWS account with an ECS cluster running jenkins

This repo contains a [Terraform](https://www.terraform.io) plan to run an [Amazon ECS](https://aws.amazon.com/ecs/) cluster with a private [Amazon ECR](https://aws.amazon.com/ecr/) Docker registry. And [Jenkins 2.0](https://jenkins.io/2.0/) running from a container with ability to build and run more Docker images.

This project is based on material in [Capgemini/terraform-amazon-ecs.git](https://github.com/Capgemini/terraform-amazon-ecs) but has deviated to a point where a fork no longer makes sense.

Includes -

  * ECS cluster, launch configuration and autoscaling group
  * ECR repository for one Docker application
  * Jenkins container service with an ELB
  * CloudFormation log group

### Prerequisites

* Terraform installed, recommended (>= 0.6.16). Head on over to [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) to grab the latest version.
* An AWS account [http://aws.amazon.com/](http://aws.amazon.com/)
* Install and configure the [AWS CLI tools](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files)

### Usage

1. Clone the repo
2. cp terraform.tfvars.example terraform.tfvars
3. edit terraform.tfvars with your details
4. Run the plan -

```
terraform apply
```

For a full list of overridable variables see ```variables.tf```

### Jenkins backup

You can preserve your Jenkins settings by copying your /var/jenkins_home to the s3 bucket path defined by the variable s3_jenkins_backup
eg: aws s3 sync /var/jenkins_home/ $s3_jenkins_backup
