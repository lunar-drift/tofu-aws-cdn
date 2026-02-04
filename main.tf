# --- tofu-aws-cdn.main ---

resource "aws_s3_bucket" "b" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_versioning" "b" {
  bucket = aws_s3_bucket.b.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.bucket
  policy = data.aws_iam_policy_document.origin_bucket_policy.json
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = var.s3_origin_id
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  # depends_on          = [aws_acm_certificate_validation.www_certificate_validation]
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "ldh compliant"
  default_root_object = "index.html"
  aliases             = var.cf_aliases
  price_class         = "PriceClass_All"
  # web_acl_id          = var.cdn_web_acl_id

  origin {
    domain_name              = aws_s3_bucket.b.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = var.s3_origin_id
  }

  default_cache_behavior {
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_origin_id
  }

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = var.cf_restricted_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = 84600
    error_code            = 404
    response_code         = 200
    response_page_path    = "/error.html"
  }
}
