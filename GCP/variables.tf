variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "serious-unison-334521"
}

variable "ssh_user" {
  description = "The SSH user"
  type        = string
  default     = "daniel"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_ocp6exo2gcp.pub"
}

