package main

deny[msg] {
  input.resource_type == "google_storage_bucket"
  not input.resource.encryption.default_kms_key_name
  msg := sprintf("GCS bucket '%s' must have encryption enabled with a KMS key.", [input.resource.name])
}

deny[msg] {
  input.resource_type == "google_storage_bucket"
  not input.resource.project
  msg := sprintf("GCS bucket '%s' must specify a project.", [input.resource.name])
}

deny[msg] {
  input.resource_type == "google_storage_bucket"
  input.resource.project != "allowed-project-id"
  msg := sprintf("GCS bucket '%s' must belong to the project 'allowed-project-id'.", [input.resource.name])
}
