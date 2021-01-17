
variable "config" {
  description = "list of vms config"
  default = {
    "1-ubuntu-18.04" = { instance_type = "t2.micro" }
    "2-ubuntu-18.04" = { instance_type = "t2.micro" }
  }

}
