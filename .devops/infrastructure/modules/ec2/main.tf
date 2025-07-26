
resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = (var.user_data) != null ? var.user_data : null
  iam_instance_profile        = aws_iam_instance_profile.this.name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size = 100         # Örneğin 30 GiB
    volume_type = "gp3"      # gp2, gp3, io1, vs.
    delete_on_termination = true
  }




  tags = {
    Name = "${var.name}-ec2"
  }
}


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
  #policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" # veya ihtiyacına göre AmazonSSMFullAccess, AmazonS3ReadOnlyAccess
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.ec2_instance_role.name
}


resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
  name   = "${var.name}-sg"
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
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}
