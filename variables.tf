variable "aws_vpc_id" {
}

variable "app_env" {
}

variable "app_name" {
}

variable "app_id" {
}

variable "aws_sg_name" {
}

variable "aws_sg_description" {
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}