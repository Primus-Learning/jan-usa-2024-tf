output "pub-subnet_id" {
  value = aws_subnet.primus-public-subnet.id
}

output "vpc_id" {
  value = aws_vpc.primus-vpc.id
}

output "pvt-subnet_id" {
  
  value = aws_subnet.primus-private-subnet.id
}