[master]
k3s-master ansible_host=${master_ip} ansible_user=ubuntu

[workers]
%{ for i, ip in worker_ips ~}
k3s-worker-${i + 1} ansible_host=${ip} ansible_user=ubuntu
%{ endfor ~}

[k3s_cluster:children]
master
workers

[all:vars]
ansible_ssh_private_key_file=${ssh_private_key}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'