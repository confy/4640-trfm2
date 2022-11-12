# 4640-trfrm2

This repository shows how to use ansible and terraform to create simple infrastructure on digital ocean.

First install terraform on your pc -

https://www.terraform.io/downloads.html

Then install ansible -

https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Install digital ocean ansible plugin - 

`ansible-galaxy collection install community.digitalocean`


Create an API key on digital ocean and export it as an environment variable - DO_API_TOKEN

Also create an ssh key on your local system called "4640" and add the public key to digital ocean.

`ssh-keygen`

add the private key as `mgmt/4640.pem`

In the dev folder, create a real `terraform.tfvars` from the `example.tfvars` with your own token and region

Then run the following commands -

```bash 
terraform init
terraform plan
terraform apply
```

This will create a droplet on digital ocean, along with a vpc and load balancer.

It will output the lb ip and droplet ips for later -
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

lb_ip = [
  "146.190.15.127",
]
vm_ip = [
  "164.92.77.39",
  "137.184.11.208",
]

```


Then run the ansible playbook to install nginx on the droplets -    

`ansible-playbook nginx_setup.yml`

This will install nginx on the droplets.

Then you can go to the lb ip and see the nginx welcome page.


To destroy the infrastructure, run -

`terraform destroy`
