terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.3"
    }
  }
}

provider "multipass" {}

resource "local_file" "cloud_init" {
  filename = "${path.module}/cloud-init.rendered.yml"
  content  = templatefile("${path.module}/cloud-init.tpl", {
    ssh_public_key = trimspace(file("${path.module}/id_ed25519.pub"))
  })
}

resource "multipass_instance" "master" {
  name           = "k3s-master"
  image          = var.ubuntu_image
  cpus           = var.master_cpus
  memory         = var.master_memory
  disk           = var.master_disk
  cloudinit_file = local_file.cloud_init.filename
  depends_on     = [local_file.cloud_init]
}

resource "multipass_instance" "worker" {
  count = var.worker_count

  name           = "k3s-worker-${count.index + 1}"
  image          = var.ubuntu_image
  cpus           = var.worker_cpus
  memory         = var.worker_memory
  disk           = var.worker_disk
  cloudinit_file = local_file.cloud_init.filename
  depends_on     = [local_file.cloud_init]
}

resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/hosts.ini"

  content = templatefile("${path.module}/inventory.tpl", {
    master_ip        = multipass_instance.master.ipv4
    worker_ips       = [for w in multipass_instance.worker : w.ipv4]
    ssh_private_key  = var.ssh_private_key_path
  })
}