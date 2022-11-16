resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"

#to determine the subnet which will be allowed to Nat
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  #below step will use when we need to specific dubnet range
   /* subnetwork {
     name = google_compute_subnetwork.private-mangment-subnet.id
     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]

   } */
#allocate an ip address for the NAT
   nat_ips = [google_compute_address.nat.self_link]

}
#allocate an ip address for the NAT
resource "google_compute_address" "nat" {
    name = "nat"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"

    depends_on = [google_project_service.compute]
  
}