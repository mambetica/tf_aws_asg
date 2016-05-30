#### REQUIRED ####

variable "lc_image_id" {
  description = "The EC2 image ID to launch"
}
variable "lc_instance_type" {
  description = "The size of instance to launch"
}
variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
}
variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
}

#### OPTIONAL ####

variable "lc_name" {
  description = "The name of the launch configuration. If you leave this blank, Terraform will auto-generate a unique name"
}
variable "lc_security_groups" {
  description = "A list of associated security group Ids"
  default = ""
}
variable "asg_name" {
  description = "The name of the auto scale group.  By default generated by terraform."
}
variable "asg_availability_zones" {
  description = "A list of AZs to launch resources in. Required only if you do not specify any vpc_zone_identifier"
}