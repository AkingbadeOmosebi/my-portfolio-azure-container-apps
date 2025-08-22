#My variables block, containing my AWS ECR secrets token password

variable "ecr_token" {
  description = "ECR authentication token"
  type        = string
  sensitive   = true
}

variable "image_tag" {
  description = "Docker image tag for the portfolio app"
  type        = string
  default     = "latest"
}