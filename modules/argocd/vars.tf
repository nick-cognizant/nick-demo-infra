variable "host" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "token" {
  type = string
  sensitive = true
}

variable "url"{
  type = string
}