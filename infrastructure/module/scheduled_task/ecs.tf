resource "aws_ecr_repository" "ecr" {
  name = "${var.service}_${var.module}_ecr"
}