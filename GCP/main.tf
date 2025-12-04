provider "google" {
  project     = var.project_id
  region      = "europe-west9"
  credentials = file("./serious-unison-334521-ef79fa28b8b0.json") 
}

resource "google_compute_address" "static" {
  name   = "ocp6exo2gcp-ip"
  region = "europe-west9"
}

resource "google_compute_instance" "ocp6exo2gcp" {
  name         = "ocp6exo2gcp"
  machine_type = "e2-custom-2-4096" # 2 vCPU, 4 Go RAM
  zone         = "europe-west9-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2404-lts-amd64"
      size  = 15
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }

  tags = ["http-server", "https-server", "ssh"]
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

output "vm_public_ip" {
  description = "Adresse IP publique de la VM ocp6exo2gcp"
  value       = google_compute_address.static.address
}

output "ssh_command" {
  description = "Commande SSH pour se connecter à la VM ocp6exo2gcp"
  value       = "ssh -i ~/.ssh/id_ocp6exo2gcp ${var.ssh_user}@${google_compute_address.static.address}"
}

