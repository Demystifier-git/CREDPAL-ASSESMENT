resource "aws_security_group" "web" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  

  ingress {
    description = "HTTP from Load Balancer"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.lb_security_group_id]
  }

  ingress {
  from_port       = 3000
  to_port         = 3000
  protocol        = "tcp"
  security_groups = [var.lb_security_group_id]
}

  ingress {
    description = "HTTPS from Load Balancer"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [var.lb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}
