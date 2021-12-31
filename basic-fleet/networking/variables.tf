variable name {
  type        = string
  description = "Network name"
}

variable group {
  type        = object({name = string, location = string})
  description = "Azure Resource Group"
}

variable ip-count {
  type        = number
  description = "Number of public IPs"
  default     = 1
}
