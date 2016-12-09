resource "google_dns_managed_zone" "appcloud_info" {
  name        = "appcloud-info"
  dns_name    = "appcloud.info."
  description = "appcloud.info zone"
}

resource "google_dns_record_set" "cname_jk_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "jk.${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "ww24.github.io."
  ]
}

resource "google_dns_record_set" "cname_wp_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "wp.${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "wp-mizuno2-1123190130.ap-northeast-1.elb.amazonaws.com."
  ]
}

resource "null_resource" "nameservers_appcloud_info" {
  triggers {
    name_servers = "${join("\n", google_dns_managed_zone.appcloud_info.name_servers)}"
  }

  provisioner "local-exec" {
    command = <<EOF
echo "nameservers: ${google_dns_managed_zone.appcloud_info.dns_name}"
echo "${self.triggers.name_servers}"
EOF
  }
}
