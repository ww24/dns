resource "google_dns_managed_zone" "ww24_info" {
  name        = "ww24-info"
  dns_name    = "ww24.info."
  description = "ww24.info zone"
}

# GitHub Pages
resource "google_dns_record_set" "a_ww24_info" {
  managed_zone = "${google_dns_managed_zone.ww24_info.name}"
  name         = "${google_dns_managed_zone.ww24_info.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [
    "192.30.252.153",
    "192.30.252.154"
  ]
}

# Gmail
resource "google_dns_record_set" "cname_mail_ww24_info" {
  managed_zone = "${google_dns_managed_zone.ww24_info.name}"
  name         = "mail.${google_dns_managed_zone.ww24_info.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "ghs.google.com."
  ]
}

resource "google_dns_record_set" "mx_ww24_info" {
  managed_zone = "${google_dns_managed_zone.ww24_info.name}"
  name         = "${google_dns_managed_zone.ww24_info.dns_name}"
  type         = "MX"
  ttl          = 300
  rrdatas      = [
    "10 aspmx.l.google.com.",
    "20 alt1.aspmx.l.google.com.",
    "20 alt2.aspmx.l.google.com.",
    "30 aspmx2.googlemail.com.",
    "30 aspmx3.googlemail.com.",
    "30 aspmx4.googlemail.com.",
    "30 aspmx5.googlemail.com."
  ]
}

resource "google_dns_record_set" "spf_ww24_info" {
  managed_zone = "${google_dns_managed_zone.ww24_info.name}"
  name         = "${google_dns_managed_zone.ww24_info.dns_name}"
  type         = "SPF"
  ttl          = 300
  rrdatas      = [
    "v=spf1 include:aspmx.googlemail.com ~all"
  ]
}

resource "google_dns_record_set" "txt_ww24_info" {
  managed_zone = "${google_dns_managed_zone.ww24_info.name}"
  name         = "${google_dns_managed_zone.ww24_info.dns_name}"
  type         = "TXT"
  ttl          = 300
  rrdatas      = [
    "google-site-verification=fj9pUiGr9xpc89EE6klRSbBq-LP2y1B-mL_dvV3ot8E"
  ]
}

resource "null_resource" "nameservers_ww24_info" {
  triggers {
    name_servers = "${join("\n", google_dns_managed_zone.ww24_info.name_servers)}"
  }

  provisioner "local-exec" {
    command = <<EOF
echo "nameservers: ${google_dns_managed_zone.ww24_info.dns_name}"
echo "${self.triggers.name_servers}"
EOF
  }
}
