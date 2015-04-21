output "dns_name" { value = "${heroku_app.default.web_url}" }

resource "dnsimple_record" "web" {
  name = "terraform-heroku"
  domain = "justincampbell.me"
  ttl = 60
  type = "CNAME"
  value = "${heroku_app.default.name}.herokuapp.com"
}

resource "heroku_domain" "default" {
  app = "${heroku_app.default.name}"
  hostname = "${dnsimple_record.web.hostname}"
}

resource "heroku_app" "default" {
  name = "justincampbell-terraform"
  region = "us"
}

resource "heroku_addon" "database" {
  app = "${heroku_app.default.name}"
  plan = "heroku-postgresql"
}

resource "heroku_addon" "memcached" {
  app = "${heroku_app.default.name}"
  plan = "memcachier"
}
