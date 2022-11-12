terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.token
}

resource "digitalocean_vpc" "lab4640" {
  name   = "lab4640"
  region = var.region
}

data "digitalocean_project" "confy" {
  name = "confy"
}

data "digitalocean_ssh_key" "lab4640" {
  name = "4640"
}

resource "digitalocean_tag" "lab4640" {
  name = "lab4640"
}

resource "digitalocean_droplet" "lab4640" {
  image    = "rockylinux-9-x64"
  count    = 2
  name     = "lab4640-${count.index}"
  tags     = [digitalocean_tag.lab4640.id]
  region   = var.region
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.lab4640.id]
  vpc_uuid = digitalocean_vpc.lab4640.id
  lifecycle {
    create_before_destroy = true
  }
}


resource "digitalocean_loadbalancer" "lb" {
  name   = "lab4640-lb"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_tag = "lab4640"
  vpc_uuid    = digitalocean_vpc.lab4640.id
}
