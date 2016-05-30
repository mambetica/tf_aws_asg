resource "aws_launch_configuration" "lc" {
    name = "${var.lc_name}"
    image_id = "${var.lc_image_id}"
    instance_type = "${var.lc_instance_type}"
    security_groups = ["${var.lc_security_groups}"]
	
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${split(",", var.asg_availability_zones)}"]
  name = "${var.asg_name}"
  max_size = "${var.asg_max_size}"
  min_size = "${var.asg_min_size}"
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 4
  force_delete = true
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