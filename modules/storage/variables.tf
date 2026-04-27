variable "account_id" {
  description = "AWS account ID — used for globally unique bucket name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}
