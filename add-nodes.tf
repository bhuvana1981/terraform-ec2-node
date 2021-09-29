terraform {
    required_version = "~>1.0.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.51.0"
        } 
    }
    # Adding Backend as S3 for Remote State Storage
   # backend "s3" {} 

}

provider "aws" {
    region = var.region
}

resource "aws_security_group" "nodes_sg"{
    description = "security group to allow http and ssh"

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = "0"
        to_port   = "0"
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "nodes"{
    count = var.private_instance_count
    instance_type = var.instance_type
    ami = var.ami
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.nodes_sg.id]
    tags = {
        Name = "Test-Node-${count.index}"
    }
    user_data = "${file("app1-install.sh")}"
   /* connection {
           type     = "ssh"
           user     = "ec2-user"
           password = ""
           private_key = file("ssh/Ansiblekey.pem")
           host = aws_instance.nodes[0].public_ip
        }

    provisioner "file" {
        source = "ssh/key.txt"
        destination = "/home/ec2-user/key1.txt"
    }*/
}

output "ins_ip"{
    value = aws_instance.nodes[0].public_ip
}
