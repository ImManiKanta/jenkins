resource "aws_instance" "jenkins" {
  ami = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-07d17be865ead02f3"]
  user_data = file("jenkins.sh")

  root_block_device {
    volume_size = 40
    volume_type = "gp3"
    # EBS volume tags
    tags = {
          Name = "jenkins"
      }
  }

  tags = {
    Name = "jenkins"
  }
}

resource "aws_route53_record" "jenkins" {
  zone_id = var.zone_id
  name    = "jenkins.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.jenkins.private_ip]
  allow_overwrite = true
}

resource "aws_instance" "jenkins-agent" {
  ami = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-07d17be865ead02f3"]
  user_data = file("jenkins-agent.sh")

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    # EBS volume tags
    tags = {
          Name = "jenkins-agent"
      }
  }

  tags = {
    Name = "jenkins-agent"
  }
}

resource "aws_route53_record" "jenkins-agent" {
  zone_id = var.zone_id
  name    = "jenkins-agent.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.jenkins.private_ip]
  allow_overwrite = true
}
