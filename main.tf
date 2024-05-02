provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

// Générer une clé privée
resource "tls_private_key" "my_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Extraire la clé publique à partir de la clé privée
data "tls_public_key" "my_keypair" {
  private_key_pem = tls_private_key.my_keypair.private_key_pem
}

// Créer la paire de clés SSH dans AWS
resource "aws_key_pair" "my_keypair" {
  key_name   = var.keypair_name
  public_key = data.tls_public_key.my_keypair.public_key_openssh
}

// Créer l'instance EC2
resource "aws_instance" "server" {
  ami           = var.aws_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.my_keypair.key_name

  tags = {
    Name = var.instance_name
  }

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

// Se connecter à la VM et installer Docker
resource "null_resource" "example" {
  connection {
    type        = "ssh"
    user        = var.vm_user
    private_key = tls_private_key.my_keypair.private_key_pem
    host        = aws_instance.server.public_ip
  }

  // Installation de Docker
  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "mv /tmp/script.sh ./script.sh",
      "chmod +x ./script.sh",
      "./script.sh"
    ]
  }

}
