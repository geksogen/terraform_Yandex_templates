variable "new_user" {
  type    = string
  default = "meta.txt"
}

variable "vm_names" {
  description = "Create VM's with these names"
  type    = list(string)
  default = ["Node-1","Node-2"]
}
