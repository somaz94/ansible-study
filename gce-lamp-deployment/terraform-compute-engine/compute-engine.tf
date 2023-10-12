# test compute engine

resource "google_compute_address" "test_server_ip" {
  name = var.test_server_ip
}

resource "google_compute_instance" "test_server" {
  name                      = var.test_server
  machine_type              = "n2-standard-2"
  zone                      = "${var.region}-a"
  allow_stopping_for_update = true

  tags = [var.test_server]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 100
    }
  }

  metadata = {
    ssh-keys = "somaz:${file("/home/somaz/.ssh/id_rsa_somaz94.pub")}"
  }

  network_interface {
    network    = var.shared_vpc
    subnetwork = "${var.subnet_share}-mgmt-a"

    access_config {
      ## Include this section to give the VM an external ip ##
      nat_ip = google_compute_address.test_server_ip.address
    }
  }

  depends_on = [google_compute_address.test_server_ip]

}
