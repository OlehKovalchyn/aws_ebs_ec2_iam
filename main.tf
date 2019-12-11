provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

//////////EC2/////////////

resource "aws_instance" "web" {
  ami                    = "ami-0233214e13e500f77"  ///////instance ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  user_data              = <<EOF

EOF
}



//////////Security Group////////////////////

resource "aws_security_group" "sec_group" {
  name        = "Security Group"
  description = "For instans wher will be nginx with name"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0"]            
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

