variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Choose CIDR block for VPC"
}
variable "subnet1_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Choose CIDR block for VPC"
}
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Choose region for your stack"
}

variable "pub_sunets" {
  type = map(any)
  default = {
    "ap-south-1a" : "10.0.0.0/24",
    "ap-south-1b" : "10.0.1.0/24",
  }
}

variable "pri_sunets" {
  type = map(any)
  default = {
    "ap-south-1a" : "10.0.2.0/24",
    "ap-south-1b" : "10.0.3.0/24",
  }
}

variable "ami_id" {
  type    = string
  default = "ami-06489866022e12a14"
}