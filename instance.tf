/* output "dns_name" { */
  /* value = "${aws_instance.web.public_dns}" */
/* } */

/* resource "aws_instance" "web" { */
  /* ami = "ami-1ecae776" */
  /* instance_type = "${var.aws_instance_type}" */
  /* key_name = "${var.aws_key_name}" */
  /* security_groups = ["${aws_security_group.ssh.name}", "${aws_security_group.web.name}"] */

  /* user_data = "${file("setup-httpd.sh")}" */
/* } */
