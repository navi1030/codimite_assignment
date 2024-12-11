variable "gcp_project_id" {
  description = "The GCP project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be deployed"
  type        = string
  default     = "asia-southeast1-a"
}

variable "vpc_name" {
  description = "Name of the VPC to be created"
  type        = string
  default     = "my-vpc"
}

variable "subnet_cidr_range" {
  description = "Base CIDR range for subnets"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_pools" {
  description = "Node pools configuration for the GKE cluster"
  type = list(object({
    name          = string
    machine_type  = string
    disk_size_gb  = number
    initial_count = number
  }))

  default = [
    {
      name          = "default-pool"
      machine_type  = "e2-medium"
      disk_size_gb  = 50
      initial_count = 2
    },
    {
      name          = "custom-pool"
      machine_type  = "n2-standard-2"
      disk_size_gb  = 100
      initial_count = 3
    }
  ]
}
