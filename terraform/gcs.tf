resource "google_storage_bucket" "mocha_cloud_dns_tfstate" {
  name          = "${var.remote_state_bucket}"
  location      = "asia-northeast1"
  storage_class = "REGIONAL"
}
