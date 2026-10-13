variable "vpc_cidr" {
  type = string

  description = "The cidr block for the VPC"
}
variable "subnet_cidr" {
  type        = string
  description = "The CIDR block the subnet"
}
variable "environment" {
  type        = string
  default     = ""
  description = "The environment name, used to tag and name resources e.g dev, staging prod"
}
