variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "EcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default = "EcsAutoScaleRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9292
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "project_name" {
  description = "Name of the project (used to name resources descriptively)"
}

# might be the same as dns_hosted_zone if you want to use an apex domain
variable "dns_hosted_zone" {
  description = "Specific to your setup, pick a domain you have in route53"
}

# if you want to use a subdomain, specify it here
variable "dns_name" {
  description = "Name of the hosted zone to use (typically a domain name)"
}

variable "aws_profile_name" {
  description = "Name of the AWS credentials profile to use"
}