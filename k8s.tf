#Cluster name
resource "google_container_cluster" "private-k8s-cluster"{
  name                     = "private-k8s-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  #my VPC
  network                  = google_compute_network.main-vpc.self_link
  #my private SN
  subnetwork               = google_compute_subnetwork.private-mangment-subnet.self_link
  # service to enale K8s to login for apps
  logging_service          = "logging.googleapis.com/kubernetes"
  /* monitoring_service       = "monitoring.googleapis.com/kubernetes" */
  /* networking_mode          = "VPC_NATIVE" */

  # Optional, if you want multi-zonal cluster
  /* node_locations = [
    "us-central1-b"
  ] */

master_authorized_networks_config {
    cidr_blocks {
    cidr_block   = google_compute_subnetwork.restricted-subnet.ip_cidr_range
    display_name = "managment"
}
}
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  #to manage K8s cluster upgrads
    release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    #for VPN or Bastion host
    enable_private_endpoint = true  
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

}