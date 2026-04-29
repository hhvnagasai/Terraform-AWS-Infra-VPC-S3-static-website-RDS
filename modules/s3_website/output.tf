output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "website_url" {
  value = "http://${aws_s3_bucket.this.bucket}.s3-website.${data.aws_region.current.region}.amazonaws.com"
}
