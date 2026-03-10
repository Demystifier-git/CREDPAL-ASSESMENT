output "lb_dns_name" { value = aws_lb.app.dns_name }
output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "lb_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.app.zone_id
}