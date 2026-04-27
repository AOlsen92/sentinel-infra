module "storage" {
  source      = "./modules/storage"
  account_id  = var.account_id
  environment = var.environment
}

module "iam" {
  source        = "./modules/iam"
  account_id    = var.account_id
  github_org    = var.github_org
  data_lake_arn = module.storage.data_lake_arn
  ecr_repo_arn  = module.compute.ecr_repo_arn
}

module "ingestion" {
  source            = "./modules/ingestion"
  data_lake_bucket  = module.storage.data_lake_bucket
  data_lake_arn     = module.storage.data_lake_arn
  firehose_role_arn = module.iam.firehose_role_arn
}

module "compute" {
  source                 = "./modules/compute"
  account_id             = var.account_id
  aws_region             = var.aws_region
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
}
