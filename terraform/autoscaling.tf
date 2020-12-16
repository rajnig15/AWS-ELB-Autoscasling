resource "aws_autoscaling_group" "web-scaling" {
  name = "web-scaling"

  min_size         = 1
  desired_capacity = 1
  max_size         = 3

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.elb-mediawiki.id
  ]

  launch_configuration = aws_launch_configuration.web-mediawiki.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    aws_subnet.public-subnet-1a.id,
    aws_subnet.public-subnet-1b.id
  ]


  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }

}