data "terraform_remote_state" "tfstate" {
    backend = "gcs"
    config {
        credentials = "${file("account.json")}"
        bucket = "${var.remote_state_bucket}"
        path = "${var.remote_state_path}"
        project = "${var.project}"
    }
}
