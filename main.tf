resource "aws_placement_group" "pg" {
  name = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${split(",", var.availability_zones)}"]
  name = "${var.name}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 4
  force_delete = true
  placement_group = "${aws_placement_group.pg.id}"
  launch_configuration = "${var.launch_configuration}"

  tags {
    Name = "${var.name}"
    Owner = "${var.owner}"
  }
}