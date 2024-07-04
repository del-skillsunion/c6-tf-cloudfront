provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "sctp-staticwebsite-files.s3.ap-southeast-1.amazonaws.com"
    origin_id   = "S3-sctp-staticwebsite-files"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "TF - Cloudfront - Delfrinando"
  default_root_object = "home.html"

  default_cache_behavior {
    target_origin_id       = "S3-sctp-staticwebsite-files"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
