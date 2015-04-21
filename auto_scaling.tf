output "dns_name" { value = "${aws_elb.web.dns_name}" }

resource "dnsimple_record" "web" {
  name = "${var.subdomain}"
  domain = "${var.domain_name}"
  ttl = 60
  type = "CNAME"
  value = "${aws_elb.web.dns_name}"
}

resource "aws_autoscaling_group" "web" {
  name = "${var.app_name}"
  availability_zones = ["${var.aws_az_1}", "${var.aws_az_2}"]
  force_delete = true
  health_check_grace_period = 300
  health_check_type = "ELB"
  launch_configuration = "${aws_launch_configuration.web.name}"
  load_balancers = ["${aws_elb.web.name}"]

  min_size = 2
  max_size = 10
}

resource "aws_launch_configuration" "web" {
  image_id = "ami-1ecae776"
  instance_type = "${var.aws_instance_type}"
  key_name = "${var.aws_key_name}"
  name = "${var.app_name}"
  security_groups = ["${aws_security_group.web.name}"]
  user_data = "${file("setup-httpd.sh")}"
}

resource "aws_elb" "web" {
  availability_zones = ["${var.aws_az_1}", "${var.aws_az_2}"]
  cross_zone_load_balancing = true
  name = "${var.app_name}"

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}
