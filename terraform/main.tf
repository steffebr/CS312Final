# Version 1.1

provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

# Find default subnet for AZ us-west-2a
data "aws_subnet" "available_subnets" {
    vpc_id = data.aws_vpc.default.id
    availability_zone = "us-west-2a"
}

# Get default VPC
data "aws_vpc" "default" {
    default = true
}

# Create new security group for server with rules accepting connections 
# from ports 22 and 25565 for SSH and Minecraft, respectively
resource "aws_security_group" "minecraft_server_sg" {
    name = "sg_minecraft_server"
    description = "Security group for the Minecraft server"

    # Minecraft server connections
    ingress {
        from_port = 25565
        to_port = 25565
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTPS to download server file
    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow all outbound traffic
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create AWS EC2 instance using security group and subnet
resource "aws_instance" "minecraft_server" {
  ami           = "ami-03f65b8614a860c29" 
  instance_type = "t2.medium"

  # Define other instance settings, such as key_name, security_groups, and subnet_id
  key_name = "MCServer"
  vpc_security_group_ids = [aws_security_group.minecraft_server_sg.id]
  subnet_id = data.aws_subnet.available_subnets.id

  tags = {
    Name = "minecraft-server"
  }

  provisioner "file" {
    connection {
      host = "${self.public_ip}"
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("../secrets/MCServer.pem")}"
    }
    source = "../setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "remote-exec" {
    connection {
      host = "${self.public_ip}"
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("../secrets/MCServer.pem")}"
    }

    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "sudo /home/ubuntu/setup.sh"
    ]
  }
}
