terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.3.3"
    }
  }
}

provider "vultr" {
  api_key = ""
  rate_limit = 700
  retry_limit = 3
}
