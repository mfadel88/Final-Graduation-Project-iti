#this is the private subnet which any vm will be exist through it will be able to connect to clutser
resource "google_compute_subnetwork" "private-mangment-subnet" {
  name          = "private-mangment-subnet"
  ip_cidr_range = "10.0.0.0/18"
  region        = "us-central1"
  network       = google_compute_network.main-vpc.id
  private_ip_google_access = true
 #pods will take it's IPs from this secodry range

  secondary_ip_range {
    range_name = "k8s-pod-range"
    ip_cidr_range =  "10.48.0.0/14"
  }
#this second secondry ip address range will assigne IPs to the k8s cluster and services will be create

  secondary_ip_range {
    range_name = "k8s-service-range"
    ip_cidr_range =  "10.52.0.0/20"
    }
}



resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnetwork"
  ip_cidr_range = "10.3.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.main-vpc.id

}
