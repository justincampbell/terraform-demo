output "dns_name" { value = "${aws_instance.web.public_dns}" }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-1ecae776"
  instance_type = "m3.large"
  key_name = "justincampbell"
  security_groups = ["${aws_security_group.ssh.name}", "${aws_security_group.web.name}"]

  user_data = "${file("../setup-httpd.sh")}"
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Allow SSH from anywhere"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web" {
  name = "web"
  description = "Allow HTTP and HTTPS from anywhere"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
