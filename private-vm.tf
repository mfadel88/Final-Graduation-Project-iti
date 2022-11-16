resource "google_compute_instance" "private-vm" {
  name         = "vm-private"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.main-vpc.id
    subnetwork = google_compute_subnetwork.restricted-subnet.id
  }
  service_account {
    email  = google_service_account.final-service-acc.email
    scopes = ["cloud-platform"]
  }
}