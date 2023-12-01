variable "use_case" {
  default = "tf-aws-rds"
}

# create rg, list created resources
resource "aws_resourcegroups_group" "example" {
  name        = "tf-rg-example"
  description = "Resource group for example resources"

  resource_query {
    query = <<JSON
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "Owner",
          "Values": ["John Ajera"]
        },
        {
          "Key": "UseCase",
          "Values": ["${var.use_case}"]
        }
      ]
    }
    JSON
  }

  tags = {
    Name    = "tf-rg-example"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "null_resource" "config" {
  # triggers = {
  #   always_run = timestamp()
  # }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir ${path.module}/external
      echo "AURORA_DB_PASSWD: ${random_password.aurora.result}" > ${path.module}/external/config
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
      rm -rf ${path.module}/external/config
    EOT
  }
}

output "config" {
  value = {
    aurora = aws_rds_cluster.aurora.endpoint
  }
}
