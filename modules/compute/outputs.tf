output "ecr_repository_url" {
  description = "ECR repository URL for pushing Docker images"
  value       = aws_ecr_repository.app.repository_url
}

output "ecr_repo_arn" {
  description = "ARN of the ECR repository — used by IAM module"
  value       = aws_ecr_repository.app.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer — open this in your browser"
  value       = aws_lb.main.dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}
