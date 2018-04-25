resource "google_dns_managed_zone" "appcloud_info" {
  name        = "appcloud-info"
  dns_name    = "appcloud.info."
  description = "appcloud.info zone"
}

resource "google_dns_record_set" "txt_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "TXT"
  ttl          = 3600
  rrdatas      = [
    "google-site-verification=l4s_gwXWg7ZmPPDaR3uknE1wqh5T73D-0mNg2E0HNYs"
  ]
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

resource "google_dns_record_set" "cname_maquia_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "maquia.${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "stoic-pasteur-a46fa6.netlify.com."
  ]
}

# Firebase
resource "google_dns_record_set" "txt_auth_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "auth.${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "TXT"
  ttl          = 3600
  rrdatas      = [
    "v=spf1 include:_spf.firebasemail.com ~all",
    "firebase=coconut-ed350",
    "google-site-verification=2gOsQ2_RiBj1ZariaFbJdAWoPhdE72oOv8MW1fbInak"
  ]
}

resource "google_dns_record_set" "txt_smtpapi_domainkey_appcloud_info" {
  managed_zone = "${google_dns_managed_zone.appcloud_info.name}"
  name         = "smtpapi._domainkey.auth.${google_dns_managed_zone.appcloud_info.dns_name}"
  type         = "TXT"
  ttl          = 3600
  rrdatas      = [
     "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
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
