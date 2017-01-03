variable "region" {
  default = "asia-northeast1"
}
variable "project" {}
variable "remote_state_bucket" {}
variable "remote_state_path" {
  default = "terraform.tfstate"
}
