variable name {
  type        = string
  description = "Security Group name"
}

variable group {
  type        = object({name = string, location = string})
  description = "Azure Resource Group"
}
