module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = "10.0.0.0/16"
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  environment          = "sandbox"
}

locals {
  private_subnet_ids    = [for i in module.vpc.private_subnets : i.id]
  public_subnet_ids     = [for i in module.vpc.public_subnets : i.id]
}

module "rds" {
  source                  = "./modules/rds"
  identifier              = "my-database"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.39"
  instance_class          = "db.c6gd.medium"
  username                = "admin"
  password                = "securepassword"
  parameter_group_name    = "default.mysql8.0"
  subnet_ids              = local.private_subnet_ids
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
  vpc_security_group_ids  = [module.db_sg.sg.id]
  apply_immediately       = true

  tags = {
    Environment = "production"
  }
}

module "alb_sg" {
  source = "./modules/security_group"

  name        = "ALB SG"
  description = "SG for RDS"
  vpc_id      = module.vpc.vpc_id
  ingress = {
    "rule1" = {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0", "10.0.0.0/16"]
      ipv6_cidr_blocks = []
    }
    "rule2" = {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  }
  egress = {
    "rule1" = {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  tags = {}
}

module "web_sg" {
  source = "./modules/security_group"

  name        = "WEB SG"
  description = "SG for RDS"
  vpc_id      = module.vpc.vpc_id
  ingress = {
    "rule1" = {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0", "10.0.0.0/16"]
      ipv6_cidr_blocks = []
    }
    "rule2" = {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  }
  egress = {
    "rule1" = {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  tags = {}
}

module "db_sg" {
  source = "./modules/security_group"

  name        = "DB SG"
  description = "SG for RDS"
  vpc_id      = module.vpc.vpc_id
  ingress = {
    "rule1" = {
      description      = "DB from VPC"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0", "10.0.0.0/16"]
      ipv6_cidr_blocks = []
    }
  }
  egress = {
    "rule1" = {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  tags = {}
}

# Launch Template

module "launch_template" {
  source             = "./modules/launch_template"
  name_prefix        = "web-template"
  ami_id             = "ami-063d43db0594b521b"
  instance_type      = "t2.micro"
  key_name           = "devops"
  security_group_ids = [module.web_sg.sg.id]
  #iam_instance_profile       = "your-iam-instance-profile"
  associate_public_ip_address = true
  subnet_id                   = local.public_subnet_ids[0]
  user_data                   = file("templates/user_data.sh")
  root_volume_device_name     = "/dev/xvda"
  root_volume_size            = 10
  root_volume_type            = "gp2"
  instance_tags = {
    Name = "web-instance"
    Env  = "production"
  }
}

# Example Target Group Module Usage
module "target_group" {
  source                = "./modules/target_group"
  target_group_name     = "web-target-group"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  vpc_id                = module.vpc.vpc_id
  health_check_path     = "/"
  stickiness_enabled    = true
  tags = {
    Environment = "production"
  }
}

# Auto Scaling Group Module Usage
module "autoscaling" {
  source                  = "./modules/auto_scaling_group"
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = "$Latest"
  subnet_ids              = local.public_subnet_ids
  desired_capacity        = 1
  min_size                = 1
  max_size                = 5
  target_group_arns       = [module.target_group.target_group_arn]
  instance_name_tag       = "web-asg-instance"
}

# Example ALB Module Usage
module "alb" {
  source                     = "./modules/alb"
  alb_name                   = "web-alb"
  security_group_ids         = [module.web_sg.sg.id]
  subnet_ids                 = local.public_subnet_ids
  enable_deletion_protection = false
  idle_timeout               = 60
  target_group_arn           = module.target_group.target_group_arn
}