variable prefix {
  type        = string
  description = "Namespace"
  default     = "playground"
}

variable location {
  type        = string
  description = "Azure location"
  default     = "uksouth"
}

variable instances {
  type        = number
  description = "Number of instances"
  default     = 1
}

variable public-key {
  type        = string
  description = "Path to SSH RSA public key"
  default     = "~/.ssh/id_rsa.pub"
}
