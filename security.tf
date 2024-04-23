# Generate random password for aurora db
resource "random_password" "aurora" {
  length      = 16
  min_lower   = 2
  min_numeric = 2
  min_upper   = 2
  special     = false
}
