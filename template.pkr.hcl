packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "liveswitch-packer-linux-aws"
  instance_type = "t2.micro"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-*-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  access_key   = var.aws_access_key_id
  secret_key   = var.aws_secret_access_key
  
  region       = "us-east-1"
  ssh_username = "ubuntu"
}

source "azure-arm" "ubuntu" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }
  client_id                         = "${var.azure_client_id}"
  client_secret                     = "${var.azure_client_secret}"
  image_offer                       = "UbuntuServer"
  image_publisher                   = "Canonical"
  image_sku                         = "20.04-LTS"
  location                          = "East US"
  managed_image_name                = "PackerLiveSwitchImage"
  managed_image_resource_group_name = "PackerLiveSwitchGroup"
  os_type                           = "linux"
  subscription_id                   = "${var.azure_subscription_id}"
  tenant_id                         = "${var.azure_tenant_id}"
  vm_size                           = "Standard_DS2_v2"
}

source "digitalocean" "ubuntu" {
  api_token    = "${var.digitalocean_token}"
  image        = "ubuntu-20-04-x64"
  region       = "nyc1"
  size         = "s-2vcpu-2gb-intel"
  ssh_username = "root"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.azure-arm.ubuntu", "source.digitalocean.ubuntu", "source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    scripts = ["prepare.sh"]
  }

  provisioner "file" {
    destination = "/tmp"
    source      = "liveswitch-docker-compose/"
  }

  provisioner "shell" {
    scripts = ["install.sh", "cleanup.sh", "img_check.sh"]
  }

  provisioner "shell" {
    expect_disconnect = true
    scripts           = ["finalize.sh"]
  }

}
