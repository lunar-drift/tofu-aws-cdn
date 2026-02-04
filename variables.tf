# --- tofu-aws-cdn.variables ---

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "acm_certificate_arn" { type = string }

variable "s3_origin_id" { type = string }
variable "s3_bucket_name" { type = string }

variable "cf_aliases" { type = list(string) }
variable "cf_restricted_locations" { type = list(string) }
