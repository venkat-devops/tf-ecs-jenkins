/* Registry ECR - only works in some Zones */ 
resource "aws_ecr_repository" "registry" {
  name = "registry"
}
