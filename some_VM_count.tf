terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.92.0"
}

provider "yandex" {
 token     = "<>"
 cloud_id  = "<>"
 folder_id = "<>"
 zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
    count = 2
    name = "vm${count.index}"
    resources {
        cores  = 2
        memory = 6
    }

    boot_disk {
        initialize_params {
            image_id = "fd80jfslq61mssea4ejn"
        }
    }

    network_interface {
        subnet_id = "<>"
        nat       = true
    }

    metadata = {
        user-data = file(var.new_user)
    }
  }

output "instance_output" {
  value = [
    for instance in yandex_compute_instance.vm-1[*] :
    join(": ", [instance.name, instance.hostname, instance.network_interface.0.ip_address, instance.network_interface.0.nat_ip_address])
  ]
}
