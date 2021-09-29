variable "key_name"{
    description = "provide key pair to connect to the new noodes"
    type = string
    default = "Ansiblekey"
}

variable "region"{
    description = "region where nodes to be provisioned"
    type = string
    default = "us-east-1"
}

variable "ami" {
    description = "ami id"
    type = string
    default = "ami-0dc2d3e4c0f9ebd18"
}

variable "instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
}
variable "private_instance_count" {
    description = "Instance type"
    default = 1
}