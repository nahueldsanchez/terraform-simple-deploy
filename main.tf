terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

resource "aws_key_pair" "python-tdd-keypair" {
    key_name = "python-tdd-keypair"
    public_key = file("./python-tdd-keypair.pub")
}


# https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html
resource "aws_instance" "python-tdd-ec2instance" {
  ami = var.amis_ids_us_regions[var.aws_region]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.python-tdd-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  key_name = aws_key_pair.python-tdd-keypair.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install nginx -y",
      "sudo service nginx start"
    ]
  }

  connection {
    host = aws_instance.python-tdd-ec2instance.public_dns
    user = "ubuntu"
    private_key = file("./python-tdd-keypair")
  }

  tags = {
    Environment = var.environment
  }
}

output "Public_IP" {
  value = aws_instance.python-tdd-ec2instance.public_ip
}

