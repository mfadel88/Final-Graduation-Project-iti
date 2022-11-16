resource "google_project_service" "compute"{
    service = "compute.googleapis.com"
}
  
resource "google_project_service" "container"{
    service = "container.googleapis.com"
}

resource "google_compute_network" "main-vpc" {
  project                 = "final-proj-fadel"
  name                    = "final-proj-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}