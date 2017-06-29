resource "cloudflare_record" "website" {
  domain = "${var.my_domain}"
  name   = "${var.my_domain_label}"
  value  = "${aws_s3_bucket.website_static.website_endpoint}"
  type   = "CNAME"
}

resource "cloudflare_record" "www_website" {
  domain = "${var.my_domain}"
  name   = "www"
  value  = "${var.my_domain}"
  type   = "CNAME"
}
