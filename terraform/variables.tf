variable "ubuntu_image" {
  description = "Immagine Ubuntu per Multipass"
  type        = string
  default     = "24.04"
}

variable "worker_count" {
  description = "Numero di nodi worker"
  type        = number
  default     = 2
}

variable "master_cpus" {
  type        = number
  default     = 1
}

variable "master_memory" {
  description = "RAM del nodo Master"
  type        = string
  default     = "1G" 
}

variable "master_disk" {
  type        = string
  default     = "5G"
}

variable "worker_cpus" {
  type        = number
  default     = 1
}

variable "worker_memory" {
  description = "RAM dei nodi Worker"
  type        = string
  default     = "768M"
}

variable "worker_disk" {
  type        = string
  default     = "5G"
}

variable "ssh_private_key_path" {
  description = "Percorso della chiave privata per Ansible"
  type        = string
  default     = "./id_ed25519"
}