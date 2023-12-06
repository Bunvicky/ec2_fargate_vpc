variable "region" {
  default = "us-east-1"
}
variable "profile" {
  default = ""
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}
variable "public_subnet_cidr_tag" {
  default = "dev"
}
variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}
variable "environment" {
  default = "production"
}
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "container_port" {
  default = 8080
}
variable "main.name" {
  default = name
}
variable "container_environment" {
  default = "pro"
}
variable "container_image" {
  default = "latest"
}
variable "vpc_id" {
  default = ""
}
variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnets" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "main.name" {
  description = "Name for the ECR repository"
  type        = string
  # You can set a default value if needed:
  default     = "my-ecr-repo"
}

variable "environment" {
  description = "Environment for the ECR repository"
  type        = string
  # You can set a default value if needed:
  default     = "dev"
}
variable "main" {
  description = "Main configuration variables"
  type        = object({
    name = string
    // Other attributes related to 'main'
  })
  # You can set default values if needed:
  default = {
    name = "my-main-name"
    // Other default attributes related to 'main'
  }
}

variable "environment" {
  description = "Environment for resources"
  type        = string
  # You can set a default value if needed:
  default     = "dev"
}
variable "main" {
  default = "main"
}