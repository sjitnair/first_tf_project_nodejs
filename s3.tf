resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = var.s3_bucket_name

  tags = merge(
    local.common_tags,
    {
      Name        = "Nodejs terraform bucket"
    }
  )
}

resource "aws_s3_object" "tf_s3_object" {
  bucket   = aws_s3_bucket.tf_s3_bucket.bucket
  for_each = fileset(var.s3_source_path, "**")

  key    = "image/${each.key}"
  source = "${var.s3_source_path}/${each.key}"
}

