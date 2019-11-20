variable "name" {
  default = "asg"
}

variable "name_prefix" {
  default = ""
}
variable "min" {
  default = "1"
}

variable "max" {
  default = "5"
}

variable "desired" {
  default = "1"
}
variable "iam_role_name" {}

variable "instance_type_on_demand" {
  default = "c4.xlarge"
}

variable "on_demand_base_capacity" {
  default = "1"
}

variable "on_demand_percentage_above_base_capacity" {
  default = "90"
}


variable "instance_type_spot" {
  default = ["c4.xlarge","m4.xlarge","m4.2xlarge","c4.2xlarge"]
}

variable "user_data" {
  default = ""
}

variable "ami" {}


variable "target_group_arns" {
  type = "list"
}

variable "subnets" {
    type = "list"
}

variable  "health_check_grace_period" {
  default = "300"
}

variable  "health_check_type"  {
  default = "ELB"
}

variable "force_delete" {
  default = "true"
}

variable "wait_timeout" {
  default = "700"
}

variable "ssh_key_name" {}


variable "security_groups" {
  type = "list"
}

variable "instance_profile_policy" {}

variable "tags" {
  type = "list"
}

variable "block_device_mappings" {
 default = {
      device_name           = "/dev/xvda1"
      volume_type           = "io1"
      volume_size           = "30"
      iops                  = "600"
    }
}
variable "min_elb_capacity" {
  default = "1"
}