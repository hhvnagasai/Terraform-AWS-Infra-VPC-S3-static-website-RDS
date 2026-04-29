variable "bucket_name" {
  description = "Unique S3 bucket name"
  type        = string
}

variable "index_document" {
  default = "index.html"
}

variable "error_document" {
  default = "error.html"
}

variable "website_dir" {
  description = "Folder containing website files"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
