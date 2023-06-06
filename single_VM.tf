/*
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
restart VM
https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
yc init
yc config list
*/

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
    name ="test"
    resources {
        cores  = 2
        memory = 2
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

output "ip_address" {
    value = [yandex_compute_instance.vm-1.network_interface.0.nat_ip_address, yandex_compute_instance.vm-1.network_interface.0.ip_address, yandex_compute_instance.vm-1.name]
}
