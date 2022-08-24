#Create security group with firewall rules
resource "aws_security_group" "security_port" {
  name        = "security_port"
  description = "security group for Test Network"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security__port"
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = "ami-05fa00d4c63e32376"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "security_port"]
  tags= {
    Name = "test_instance"
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "test_elstic_ip"
  }
}