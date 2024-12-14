terraform {
  backend "gcs" {
    bucket = "terraform-codimite"
    prefix = "terraform/state"
    credentials = secrets.GCP_SERVICE_ACCOUNT_KEY
    
  }
}
