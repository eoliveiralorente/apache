provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/eduardo/.aws/credentials"
  profile = "eduardo.oliveira@olitec.com.br"
}

resource "aws_instance" "webserver01" {
  ami = "ami-0ac80df6eff0e70b5"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.terraform.key_name}"
  security_groups = ["${aws_security_group.webserver_ssh.name}"]
  user_data = "${file("/home/eduardo/Documentos/estudo/terraform/install.sh")}"

  tags= {
    name = "webserver01"
  }
}

resource "aws_instance" "webserver02" {
  ami = "ami-0ac80df6eff0e70b5"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.terraform.key_name}"
  security_groups = ["${aws_security_group.webserver_ssh.name}"]
  user_data = "${file("/home/eduardo/Documentos/estudo/terraform/install.sh")}"

  tags = {
    name = "webserver02"
  }
}

resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "${file("/home/eduardo/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "webserver_ssh" {
  name = "webserver_ssh"
  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = - 1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "webserver_public_dns"{
  value = ["${aws_instance.webserver01.public_dns}", "${aws_instance.webserver02.public_dns}"]
}
