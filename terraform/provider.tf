provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  version = "~> v1.6.0"
}

provider "null" {
  version = "~> v1.0.0"
}
