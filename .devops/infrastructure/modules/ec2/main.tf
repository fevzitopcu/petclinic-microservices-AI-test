# Default VPC'yi ve ilk subnetini al
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "default_subnet" {
  id = data.aws_subnet_ids.default_subnets.ids[0]
}

# EC2 instance
resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.default_subnet.id
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = (var.user_data != null ? var.user_data : null)
  iam_instance_profile        = aws_iam_instance_profile.this.name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.name}-ec2"
  }
}

# IAM Role & Profile
resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.ec2_instance_role.name
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name   = "${var.name}-sg"
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "${var.name}-sg"
  }

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
