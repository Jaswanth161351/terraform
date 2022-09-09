resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = local.pub_sub_ids[0]
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web.id]
  key_name                    = "gitnewkey"
  user_data                   = file("./scripts/apache.sh")
  tags = {
    Name = "myweb-tf-demo"
  }
}

resource "aws_security_group" "web" {
  name        = "for apache"
  description = "allow ssh and http"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_sg"
  }
}