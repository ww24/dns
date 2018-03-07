terraform {
  backend "gcs" {
    credentials = "${file("account.json")}"
    project = "${var.project}"
    bucket = "${var.remote_state_bucket}"
    prefix = "${var.remote_state_prefix}"
  }
}
