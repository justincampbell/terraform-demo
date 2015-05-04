resource "digitalocean_droplet" "web" {
  name = "tf-web"
  size = "512mb"
  image = "centos-5-8-x32"
  region = "sfo1"
}

resource "dnsimple_record" "tf-test" {
  domain = "justincampbell.me"
  name = "tf-test"
  value = "${digitalocean_droplet.web.ipv4_address}"
  type = "A"
}
