resource "aws_launch_configuration" "web-mediawiki" {
  name_prefix = "web-wiki"

  image_id = "ami-04d29b6f966df1537" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  key_name = "rajni-us-east"

  security_groups = [ aws_security_group.web-sg.id ]
  associate_public_ip_address = true

  user_data = "${file("script1.sh")}"

  lifecycle {
          create_before_destroy = true
  }
}

resource "aws_security_group" "elb-sg" {
  name        = "elb-http"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id = aws_vpc.vpc-demo.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB Security Group"
  }
}

resource "aws_elb" "elb-mediawiki" {
  name = "elb-mediawiki"
  security_groups = [
    aws_security_group.elb-sg.id
  ]
  subnets = [
    aws_subnet.public-subnet-1a.id,
    aws_subnet.public-subnet-1b.id
  ]

  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }

}
