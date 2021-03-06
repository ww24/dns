resource "google_dns_managed_zone" "ww24_jp" {
  name        = "ww24-jp"
  dns_name    = "ww24.jp."
  description = "ww24.jp zone"
}

# Firebase Hosting
resource "google_dns_record_set" "txt_firebase_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "TXT"
  ttl          = 300
  rrdatas      = [
     "google-site-verification=CzHYWVVMLrEsgc9ZuASLD-pU7LEmDer1_HNXBiVOAwA"
  ]
}

resource "google_dns_record_set" "a_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [
    "151.101.1.195",
    "151.101.65.195"
  ]
}

# Mail
resource "google_dns_record_set" "mx_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "MX"
  ttl          = 3600
  rrdatas      = [
    "10 ww24.jp."
  ]
}

resource "google_dns_record_set" "spf_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "SPF"
  ttl          = 3600
  rrdatas      = [
    "\"v=spf1\" \"mx\" \"include:aspmx.googlemail.com\" \"-all\""
  ]
}

resource "google_dns_record_set" "txt_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "2015._domainkey.${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "TXT"
  ttl          = 3600
  rrdatas      = [
     "\"v=DKIM1;\" \"k=rsa;\" \"p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+jIuLyZofGXW2IDtb+6EG2utpd9yooZzLterDb8kVSQGmnXZL7kQDn5zYMgI+yXxr2dUeK9CUUueFVeKkhRTsuWDa7t/ktxhLbuS3Y/UVAIBJleMewdE5X8nNI7tljufX0AA2KtzY1lyjICWMIH5K0T2YdQafZRrsibQNfs+x9QIDAQAB\""
  ]
}

resource "null_resource" "nameservers_ww24_jp" {
  triggers {
    name_servers = "${join("\n", google_dns_managed_zone.ww24_jp.name_servers)}"
  }

  provisioner "local-exec" {
    command = <<EOF
echo "nameservers: ${google_dns_managed_zone.ww24_jp.dns_name}"
echo "${self.triggers.name_servers}"
EOF
  }
}
