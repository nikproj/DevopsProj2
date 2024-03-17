resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Allow SSH from all-inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "jenkinmaster_sg" {
  name        = "jenkinmaster_sg"
  description = "Allow HTTP and HTTPS from all-inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "http from public to load balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http from public to load balancer"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http from public to load balancer"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "https from public to load balancer"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "kube_sg" {
  name        = "kube_sg"
  description = "Allow SSH from all-inbound traffic"
  vpc_id      = aws_vpc.main2.id

  ingress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  }
}