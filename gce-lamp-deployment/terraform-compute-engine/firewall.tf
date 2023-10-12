## Firewall ##
resource "google_compute_firewall" "nfs_server_ssh" {
  name    = "allow-ssh-nfs-server"
  network = var.shared_vpc

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.public_ip}/32"]
  target_tags   = [var.test_server]

  depends_on = [module.vpc]
}


resource "google_compute_firewall" "shared_vpc_internal" {
  name    = "allow-shared-vpc-internal"
  network = var.shared_vpc

  dynamic "allow" {
    for_each = var.shared_vpc_internal_rules
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = ["10.0.0.0/8"]

  depends_on = [module.vpc]
}
