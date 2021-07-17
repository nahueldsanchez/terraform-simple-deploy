variable "aws_region" {
    description = "Amazon region used to launch the EC2 instance"
    type = string
    default = "us-west-2"
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type = string
    default = "192.168.0.0/16"
}

variable "subnet_cidr_block" {
    description = "CIDR block for the subnet"
    type = string
    default = "192.168.2.0/24"
}

variable "environment" {
    description = "Environment used: dev / qa / prod. Will be used to tag resources"
    type = string
    default = "dev"
}

variable "administrator_ip_address" {
    description = "CIDR block for administration tasks, it will be used to allow SSH access"
    type = string
    default = "0.0.0.0/0"
}

variable "amis_ids_us_regions" {
    description = "map containing Ubuntu 18.04 AMI IDs per (US) regions"
    type = map
    default = {
        # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type 64-bit x86
        "us-east-1" = "ami-0747bdcabd34c712a"
        "us-east-2" = "ami-0b9064170e32bde34"
        "us-west-1" = "ami-07b068f843ec78e72"
        "us-west-2" = "ami-090717c950a5c34d3"
    }
}