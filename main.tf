resource "aws_launch_configuration" "lc" {
  name = "${var.lc_name}"
  image_id = "${var.lc_image_id}"
  instance_type = "${var.lc_instance_type}"
  security_groups = ["${var.lc_security_groups}"]
  associate_public_ip_address = false
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${split(",", var.asg_availability_zones)}"]
  vpc_zone_identifier = ["${split(",", var.asg_subnets)}"]
  name = "${var.asg_name}"
  max_size = "${var.asg_max_size}"
  min_size = "${var.asg_min_size}"
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 2
  force_delete = true
  load_balancers = ["${var.asg_load_balancers}"]
  launch_configuration = "${aws_launch_configuration.lc.name}"

  tag {
    key = "Name"
    value = "${var.asg_name}"
	propagate_at_launch = true 
  }
  
  tag {
    key = "Owner"
    value = "${var.asg_owner}"
	propagate_at_launch = true 
  }
  
  lifecycle {
    create_before_destroy = true
  }
}