# create aurora cluster
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "aurora"
  engine                  = "aurora-mysql"
  master_username         = "dbadmin"
  master_password         = random_password.aurora.result
  backup_retention_period = 1
  database_name           = "inventory"
  engine_version          = "5.7.mysql_aurora.2.11.4"
  skip_final_snapshot     = true
  deletion_protection     = false
  db_subnet_group_name    = aws_db_subnet_group.db.name

  vpc_security_group_ids = [
    aws_security_group.http_alb.id
  ]

  availability_zones = [
    aws_subnet.private1.availability_zone,
    aws_subnet.private2.availability_zone,
    aws_subnet.private3.availability_zone,
  ]

  lifecycle {
    ignore_changes = [
      availability_zones
    ]
  }

  tags = {
    Name  = "tf-rds-cluster-example-aurora"
    Owner = "John Ajera"
      UseCase = var.use_case
  }
}

resource "aws_rds_cluster_instance" "aurora" {
  count                      = 3
  identifier                 = "aurora-${count.index}"
  cluster_identifier         = aws_rds_cluster.aurora.id
  instance_class             = "db.t3.small"
  engine                     = aws_rds_cluster.aurora.engine
  engine_version             = aws_rds_cluster.aurora.engine_version
  publicly_accessible        = false
  auto_minor_version_upgrade = false
}
