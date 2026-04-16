resource "aws_instance" "audio_service" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t3.micro"

  tags = {
    Name    = "audio-service"
    Project = "platform"
  }

  lifecycle {
    ignore_changes = [ami, user_data, vpc_security_group_ids, key_name]
  }
}

resource "aws_eip" "audio_service" {
  instance = aws_instance.audio_service.id
  domain   = "vpc"

  tags = {
    Name    = "audio-service-eip"
    Project = "platform"
  }
}

output "audio_service_ip" {
  value = aws_eip.audio_service.public_ip
}
