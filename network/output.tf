output "pub-subnet-id" {
  value = aws_subnet.primus-public-subnet.id
}

output "vpc_id" {
    value = aws_vpc.primus-vpc.id
  
}