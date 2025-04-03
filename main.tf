provider "google" {
    //credentials = key.json
    project = "devops-study-25"
    region  = "europe-west3"
  
}

resource "google_compute_network" "vpc_network" {
    name = "cure1-vpc"
    project = "devops-study-25"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name = "cure1-subnetwork"
  ip_cidr_range = "10.156.0.0/20"
  region = "europe-west3"
  network = google_compute_network.vpc_network.id
}