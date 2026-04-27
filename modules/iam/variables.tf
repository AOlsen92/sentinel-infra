variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "github_org" {
  description = "GitHub username or org — used to scope the OIDC trust policy"
  type        = string
}

variable "data_lake_arn" {
  description = "ARN of the S3 data lake bucket"
  type        = string
}

variable "ecr_repo_arn" {
  description = "ARN of the ECR repository"
  type        = string
}
