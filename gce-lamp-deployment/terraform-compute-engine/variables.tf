## common ##
variable "project" {
  default = "somaz-project"   # project id
}

variable "region" {
  default = "asia-northeast3" # region
}

## test machine ##
variable "test_server" {
  default = "test-server"
}

variable "test_server_ip" {
  default = "test-server-ip"
}

## vpc & firewall ##
variable "shared_vpc" {
  default = "somaz-project"   # project id
}

variable "subnet_share" {
  default = "asia-northeast3" # region
}

variable "shared_vpc" {
  default = "somaz-share-vpc" # vpc   
}

variable "subnet_share" {
  default = "somaz-share-sub" # subnet
}

variable "public_ip" {
  default = "11.11.11.11"     # public ip
}

variable "shared_vpc_internal_rules" {
  description = "The internal firewall rules"
  type = map(object({
    protocol = string
    ports    = list(string)
  }))
  default = {
    tcp_all  = { protocol = "tcp", ports = ["0-65535"] },
    udp_all  = { protocol = "udp", ports = ["0-65535"] },
    icmp_all = { protocol = "icmp", ports = [] }
  }
}

variable "service_project" {
  type    = list(string)
  default = ["somaz-service-project"]
}