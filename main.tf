resource "aws_launch_template" "main" {
  name = "${aws_iam_instance_profile.main.name}"
  ebs_optimized = true
  image_id = "${var.ami}"
  instance_type = "${var.instance_type_on_demand}"
  key_name = "${var.ssh_key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  user_data = "${base64encode(var.user_data)}"
  ebs_optimized = true
  iam_instance_profile {
    name = "${aws_iam_instance_profile.main.name}"
  }
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = "${var.root_volume_size}"
      volume_type = "io1"
      iops = "${var.root_volume_iops}"
  }
}


resource "aws_autoscaling_group" "main" {
  vpc_zone_identifier = ["${var.subnets}"]
  name = "${var.name}"
  max_size = "${var.max}"
  min_size = "${var.min}"
  desired_capacity = "${var.desired}"
  min_elb_capacity = "${var.min}"
  wait_for_elb_capacity = true
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"
  force_delete = "${var.force_delete}"
  target_group_arns = ["${var.target_group_arns}"]
  wait_for_capacity_timeout = "${var.wait_timeout}s"
  tags = ["${var.tags}"]
  mixed_instances_policy = {
    instances_distribution = {
      on_demand_base_capacity = "${var.on_demand_base_capacity}"
      on_demand_percentage_above_base_capacity = "${var.on_demand_percentage_above_base_capacity}"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.main.id}"
        version = "$$Latest"
      }
      
      override {
        instance_type = "${var.instance_type_spot}"
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}  
