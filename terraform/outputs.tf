output "master_ip" {
  description = "Indirizzo IP del nodo Master"
  value       = multipass_instance.master.ipv4
}

output "worker_ips" {
  description = "Indirizzi IP dei nodi Worker"
  value       = [for w in multipass_instance.worker : w.ipv4]
}