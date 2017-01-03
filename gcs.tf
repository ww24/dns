resource "google_storage_bucket" "mocha_cloud_dns_tfstate" {
  name          = "${var.remote_state_bucket}"
  location      = "${var.region}"
  storage_class = "REGIONAL"

  provisioner "local-exec" {
    # Enable versioning (not supported by terraform)
    # https://cloud.google.com/storage/docs/object-versioning
    command = <<EOF
gcloud auth activate-service-account --key-file account.json
gsutil versioning set on "${var.remote_state_bucket}"
gsutil versioning get "${var.remote_state_bucket}"
EOF
  }
}
