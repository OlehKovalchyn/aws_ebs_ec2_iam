provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

//////////EC2/////////////

resource "aws_instance" "instance" {
  ami                    = "ami-0233214e13e500f77"  ///////instance ami NEED TO CHANGE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  user_data              = file("script.sh")
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

////////////EBS////////////////

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-west-2"
  size              = 10
  /// type = find free !!!!!!!!!!!!!!!!!

  tags = {
    Name = "EBS 10G FOR EC2"
  }
}

///////Maybe EBS Connection with EC2////////////

resource "aws_volume_attachment" "ebs_connection" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebs.id}"
  instance_id = "${aws_instance.instance.id}"
}
