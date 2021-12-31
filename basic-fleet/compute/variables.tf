variable name {
  type        = string
  description = "Instance name"
}

variable group {
  type        = object({name = string, location = string})
  description = "Azure Resource Group"
}

variable subnet {
  type        = string
  description = "Azure subnet ID to which to attach the instance"
}

variable public-ip {
  type        = string
  description = "Azure public IP ID to which to assign the instance"
}

variable security-group {
  type        = string
  description = "Azure Network Security Group ID to which to assign the instance"
}

variable public-key {
  type        = string
  description = "Path to SSH RSA public key"
}

variable size {
  type        = string
  description = "Azure instance size"
}
