terraform {
  backend "gcs" {
    bucket = "terraform-codimite"
    prefix = "terraform/state"
    credentials = "D:/codimite-assignment-444413-3d9f0845961e.json"
    
  }
}
