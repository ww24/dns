resource "google_dns_managed_zone" "ww24_jp" {
  name        = "ww24-jp"
  dns_name    = "ww24.jp."
  description = "ww24.jp zone"
}

# cocoa VPS
resource "google_dns_record_set" "a_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "A"
  ttl          = 3600
  rrdatas      = [
    "160.16.52.211"
  ]
}

resource "google_dns_record_set" "aaaa_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "AAAA"
  ttl          = 3600
  rrdatas      = [
    "2001:e42:102:1502:160:16:52:211"
  ]
}

resource "google_dns_record_set" "cname_cocoa_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "cocoa.${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "CNAME"
  ttl          = 3600
  rrdatas      = [
    "ww24.jp."
  ]
}

# 二〇一七.ww24.jp
resource "google_dns_record_set" "cname_xn--w6j351gja95c_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "xn--w6j351gja95c.${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "CNAME"
  ttl          = 3600
  rrdatas      = [
    "ww24.jp."
  ]
}
# 二千十七.ww24.jp
resource "google_dns_record_set" "cname_xn--7gqvmp4jha_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "xn--7gqvmp4jha.${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "CNAME"
  ttl          = 3600
  rrdatas      = [
    "ww24.jp."
  ]
}

# TV
resource "google_dns_record_set" "a_tv_ww24_jp" {
  managed_zone = "${google_dns_managed_zone.ww24_jp.name}"
  name         = "tv.${google_dns_managed_zone.ww24_jp.dns_name}"
  type         = "A"
  ttl          = 3600
  rrdatas      = [
    "172.24.24.240"
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
