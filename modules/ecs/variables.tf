variable "cluster_name" {
  description = "Nome do ECS Cluster"
  type        = string
}

variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "task_family" {
  description = "Família da Task Definition"
  type        = string
}

variable "execution_role_arn" {
  description = "Role de execução do ECS"
  type        = string
}

# variable "task_role_arn" {
#   description = "Role da task do ECS"
#   type        = string
# }

variable "container_name" {
  description = "Nome do container"
  type        = string
}

variable "container_image" {
  description = "Imagem do container"
  type        = string
}

variable "cpu" {
  description = "CPU para a task"
  type        = string
}

variable "memory" {
  description = "Memória para a task"
  type        = string
}

variable "service_name" {
  description = "Nome do ECS Service"
  type        = string
}

variable "subnets" {
  description = "Subnets para o ECS"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups para o ECS"
  type        = list(string)
}

variable "desired_count" {
  description = "Número desejado de tarefas"
  type        = number
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

variable "target_group_arn" {
  description = "ARN of the target group for the ECS service"
  type        = string
}
