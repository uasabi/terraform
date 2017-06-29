# The website placeholder website is hosted in S3
resource "aws_s3_bucket" "website_static" {
  bucket = "${var.my_domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags {
    Name = "${var.my_domain_label} Static"
    App  = "${var.my_domain_label}"
  }
}

# Bucket to redirect www.example.com to example.com
#there is a way to avoid the second bucket and set manually on cloudflare the following rules
# Redirect all traffic coming to http://www.yourdomain.com to https://yourdomain.com
# Redirect all traffic coming to https://www.yourdomain.com/* to https://yourdomain.com/$1
# http://yourdomain.com should always use https
resource "aws_s3_bucket" "website_www_static" {
  bucket = "www.${var.my_domain}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.my_domain}"
  }

  tags {
    Name = "${var.my_domain_label} redirect"
    App  = "${var.my_domain_label}"
  }
}
