#will be use with the NAT gatway to allow VMs which not has public ip to access internet
resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.private-mangment-subnet.region
  network = google_compute_network.main-vpc.id
  }
