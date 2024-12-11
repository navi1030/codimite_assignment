output "vpc_name" {
  description = "The name of the VPC created"
  value       = google_compute_network.vpc.name
}

output "subnet_names" {
  description = "Names of the subnets created"
  value       = [for subnet in google_compute_subnetwork.subnet : subnet.name]
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "node_pool_names" {
  description = "The names of the node pools created"
  value       = [for np in google_container_node_pool.node_pools : np.name]
}
