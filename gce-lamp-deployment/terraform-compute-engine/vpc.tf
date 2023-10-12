
module "vpc" {
  source = "./modules/network"

  project_id                             = var.project
  network_name                           = var.shared_vpc
  shared_vpc_host                        = true
  delete_default_internet_gateway_routes = true
  auto_create_subnetworks                = false
  routing_mode                           = "REGIONAL"

  subnets = [
    {
      subnet_name           = "${var.subnet_share}-somaz-a"
      subnet_ip             = "10.77.101.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "${var.subnet_share}-somaz-b"
      subnet_ip             = "10.77.102.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    }
  ]

  routes = [
    {
      name              = "${var.shared_vpc}-rt"
      description       = "Routing Table to access the internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    }
  ]
}

resource "google_compute_shared_vpc_host_project" "host_project" {
  project = var.project # Replace this with your host project ID in quotes
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  for_each        = toset(var.service_project)
  host_project    = var.project
  service_project = each.key

  depends_on = [google_compute_shared_vpc_host_project.host_project]
}
