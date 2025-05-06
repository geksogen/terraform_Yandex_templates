terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
 token     = "<>"
 cloud_id  = "<>"
 folder_id = "ll"
 zone      = "ru-central1-a"
}

locals {
  vm_names = ["std-00-test-vm-1"]
}

resource "yandex_compute_instance" "vm" {
    count = length(local.vm_names)
    name = local.vm_names[count.index]

    network_interface {
        subnet_id = "<>"
        nat       = true
    }

    scheduling_policy {
        preemptible = true
    }

    metadata = {
        user-data = file(var.new_user)
    }
  }

output "instance_output" {
  value = [
    for instance in yandex_compute_instance.vm[*] :
    join(": ", [instance.name, instance.hostname, instance.network_interface.0.ip_address, instance.network_interface.0.nat_ip_address])
  ]
}
