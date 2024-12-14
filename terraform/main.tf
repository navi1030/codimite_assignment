provider "google" {
  project = var.gcp_project_id
  region  = var.region
  credentials = secrets.GCP_SERVICE_ACCOUNT_KEY
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  count                  = 2
  name                   = "subnet-${count.index + 1}"
  ip_cidr_range          = cidrsubnet(var.subnet_cidr_range, 4, count.index)
  region                 = var.region
  network                = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet[0].self_link

  initial_node_count = 1  # Needed to create the cluster, but will use node pools for scaling

  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_container_node_pool" "node_pools" {
  count    = length(var.node_pools)
  cluster  = google_container_cluster.gke_cluster.name
  location = google_container_cluster.gke_cluster.location

  name = var.node_pools[count.index].name

  node_config {
    machine_type = var.node_pools[count.index].machine_type
    disk_size_gb = var.node_pools[count.index].disk_size_gb
  }

  initial_node_count = var.node_pools[count.index].initial_count
}
