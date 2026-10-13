output "vcp_id" {
  value       = aws_vpc.main.id
  sensitive   = false
  description = "the id of the VPC"

}
output "sunet_id" {
  value = aws_subnet.main.id
  #   sensitive   = true
  description = "the id of the subnet"
  #   depends_on  = []
}

