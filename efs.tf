# efs.tf

resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  tags = {
    Name = "EFS"
  }
}

resource "aws_efs_mount_target" "efs-mt-1" {
  count            = 1
  file_system_id   = aws_efs_file_system.efs.id
  subnet_id        = aws_subnet.subnet_1.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs-mt-2" {
  count            = 1
  file_system_id   = aws_efs_file_system.efs.id
  subnet_id        = aws_subnet.subnet_2.id
  security_groups = [aws_security_group.efs.id]
}
