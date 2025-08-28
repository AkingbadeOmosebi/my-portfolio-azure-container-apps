#My variables block, containing my AWS ECR secrets token password

variable "image_tag" {
  description = "Tag of the Docker image to deploy"
  type        = string
}

variable "ecr_token" {
  description = "AWS ECR authentication token"
  type        = string
  sensitive   = true
}
