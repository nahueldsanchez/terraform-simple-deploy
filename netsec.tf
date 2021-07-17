resource "aws_security_group" "allow_ssh_http" {
  name = "Allow SSH and HTTP"
  description = "Allows SSH access on port 22 and HTTP access on port 80 and all outgoing traffic"
  vpc_id = aws_vpc.python-tdd-vpc.id

  ingress {
    description = "Allow traffic from 0.0.0.0/0 to port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.administrator_ip_address]
  }

  ingress {
    description = "Allow traffic from 0.0.0.0/0 to port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffic from VPC to 0.0.0.0/0"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}