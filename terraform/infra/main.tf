# Evgeny Pushkin
# kofe54@gmail.com
# github.com/0054

provider "aws" {}
# export AWS_ACESS_KEY_ID="acesskeyid"
# export AWS_SECRET_ACCESS_KEY="acesskey"
# export AWS_DEFAULT_REGION="us-west-2"

terraform {
  backend "s3" {
    bucket = "terrafrom-bucket"
    key    = "terraform-demo-infra/terraform.tfstate"
    # region = "us-east-1"
  }
}


data "aws_ami" "ubuntu_ami" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_security_group" "allow_ssh" {
#   name        = "allow_ssh"
#   description = "open ssh port"
#   # vpc_id      = data.aws_vpc.default.id
#   # входящий трафик
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # исходящий трафик
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "allow_ssh"
#   }
# }

data "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
}


# resource "aws_key_pair" "aws_key" {
#   key_name   = "aws_key"
#   public_key = file("~/.ssh/aws_key.pub")
# }


resource "aws_instance" "ubuntu" {
  for_each = var.config
  # аттачим ami
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = each.value["instance_type"]
  # аттачим ключ
  key_name = "aws_key"
  # аттачим сеьюрити группы
  vpc_security_group_ids = [data.aws_security_group.allow_ssh.id]

  # скрипт который выполняется при разворачивании сервера
  user_data = file("./user_data/docker.sh")

  tags = {
    Name = each.key
  }
}


