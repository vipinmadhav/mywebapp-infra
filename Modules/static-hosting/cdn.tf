
resource "aws_cloudfront_origin_access_identity" "cdn-s3-origin-access-identity" {
  comment = "Origin access identify Used for CDN S3 Buckets"
}

resource "aws_cloudfront_distribution" "cdn-cf" {
  aliases = ["${var.domain_name}", "www.${var.domain_name}"]
  origin {
    domain_name = aws_s3_bucket.cdn-s3.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.cdn-s3.id
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.cdn-s3-origin-access-identity.id}"
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.cdn-s3.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    max_ttl                = 31536000
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_ssl_arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }
}
