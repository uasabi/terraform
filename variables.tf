#Enforce the use of the AWS variables
variable "aws_access_key" {
  description = "Your AWS access key"
}

variable "aws_secret_key" {
  description = "Your AWS secret key"
}

variable "aws_region" {
  description = "AWS Region (defaults to N.Virginia)"
  default     = "us-east-1"
}

variable "my_domain" {
  description = "The domain name of my website"
  default     = "example.com"
}

variable "my_domain_label" {
  description = "The label name of my website"
  default     = "Example website"
}

variable "cloudflare_email" {
  default = "YOUR_CLOUDFLARE_EMAIL"
}

variable "cloudflare_token" {
  default = "YOUR_CLOUDFLARE_TOKEN"
}
