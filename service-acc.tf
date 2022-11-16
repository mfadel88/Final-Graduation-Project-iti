resource "google_service_account" "final-service-acc" {
  account_id   = "final-service-acc"
  display_name = "Service-Account"
  project      = "final-proj-fadel"
}

resource "google_project_iam_binding" "project" {
  project = "final-proj-fadel"
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.final-service-acc.email}",
  ]
}