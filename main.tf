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

resource "google_compute_instance" "cure1_rabbitmq" {
    name         = "cure1-rabbitmq"
    machine_type = "e2-micro"
    zone         = "europe-west3-b"
    
    boot_disk {
        initialize_params {
        image = "ubuntu-minimal-2404-lts-amd64"
        }
    }
    
    network_interface {
        network = google_compute_network.vpc_network.id
        subnetwork = google_compute_subnetwork.subnetwork.id
    
        access_config {}
    }
    
    metadata = {
        ssh-keys = "cure1:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource "google_compute_instance" "cure1_app" {
    name         = "cure1-app"
    machine_type = "e2-micro"
    zone         = "europe-west3-b"
    
    boot_disk {
        initialize_params {
        image = "ubuntu-minimal-2404-lts-amd64"
        }
    }
    
    network_interface {
        network = google_compute_network.vpc_network.id
        subnetwork = google_compute_subnetwork.subnetwork.id
    
        access_config {}
    }
    
    metadata = {
        ssh-keys = "cure1:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource "google_compute_instance" "mc_db" {
    name         = "mc-db"
    machine_type = "e2-micro"
    zone         = "europe-west3-b"
    
    boot_disk {
        initialize_params {
        image = "ubuntu-minimal-2404-lts-amd64"
        }
    }
    
    network_interface {
        network = google_compute_network.vpc_network.id
        subnetwork = google_compute_subnetwork.subnetwork.id
    
        access_config {}
    }
    
    metadata = {
        ssh-keys = "cure1:${file("~/.ssh/id_rsa.pub")}"
    }
}