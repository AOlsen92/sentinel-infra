variable "data_lake_bucket" {
  description = "Name of the S3 data lake bucket"
  type        = string
}

variable "data_lake_arn" {
  description = "ARN of the S3 data lake bucket"
  type        = string
}

variable "firehose_role_arn" {
  description = "ARN of the IAM role for Kinesis Firehose"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
