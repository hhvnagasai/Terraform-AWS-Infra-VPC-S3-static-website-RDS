data "aws_region" "current" {}
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(var.tags, {
    Name = var.bucket_name
  })
}
resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
data "aws_iam_policy_document" "public_read" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.public_read.json
}
locals {
  website_files = fileset("${path.root}/${var.website_dir}", "**")

  website_map = {
    for f in local.website_files :
    f => f
    if !startswith(f, ".git") && !startswith(f, ".harness")
  }
}
resource "aws_s3_object" "site_files" {
  for_each = local.website_map

  bucket = aws_s3_bucket.this.id
  key    = each.value

  source = "${path.root}/${var.website_dir}/${each.value}"
  etag   = filemd5("${path.root}/${var.website_dir}/${each.value}")

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      png  = "image/png"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      gif  = "image/gif"
      svg  = "image/svg+xml"
    },
    element(split(".", each.value), length(split(".", each.value)) - 1),
    "binary/octet-stream"
  )
}
