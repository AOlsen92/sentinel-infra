output "data_lake_bucket" {
  value = module.storage.data_lake_bucket
}

output "firehose_stream_name" {
  value = module.ingestion.stream_name
}

output "ecr_repository_url" {
  value = module.compute.ecr_repository_url
}

output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

output "github_actions_role_arn" {
  value = module.iam.github_actions_role_arn
}
