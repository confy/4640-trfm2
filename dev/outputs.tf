output "vm_ip" {
  value = digitalocean_droplet.lab4640.*.ipv4_address
}

output "lb_ip" {
  value = digitalocean_loadbalancer.lb.*.ip
}
