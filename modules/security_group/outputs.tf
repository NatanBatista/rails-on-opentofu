output "security_groups" {
  value = aws_security_group.this
}
output "security_group_ids" {
  value = [for sg in aws_security_group.this : sg.id]
}
