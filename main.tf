resource "aws_security_group" "myinstance" {
  vpc_id      = var.aws_vpc_id
  #name        = "${var.app_name}-security-group-${var.app_color}"
  name        = "${var.app_name}-security-group"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

  tags = {
    #Name ="${var.app_name}-security-group-${var.app_color}" 
    Name ="${var.app_name}-security-group" 
    environment  = var.app_env
    appname = var.app_name
    csiappid = var.app_csi
    #appcolor = var.app_color
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id      = var.aws_vpc_id
  #name        = "${var.app_name}-elb-security-group-${var.app_color}"
  name        =  var.aws_sg_name
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    #Name = "${var.app_name}-elb-security-group-${var.app_color}"
    Name = "${var.app_name}-elb-security-group"
    environment  = var.app_env
    appname = var.app_name
    csiappid = var.app_csi
    #appcolor = var.app_color
  }
}
