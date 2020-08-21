variable "ssh_key" {}

provider "ibm" {
  generation = 2
  region = "us-south"
}

locals {
  BASENAME = "dnovais-arcelor" 
  ZONE     = "us-south-1"
  VPC      = "r006-aec51bbe-7a3c-470e-bfbf-ceace45a5351"
}

data "ibm_is_vpc" "vpc" {
  #id                        = "r006-aec51bbe-7a3c-470e-bfbf-ceace45a5351"
  name                      = "vpc-ibmcloud-dnovais"
}

data ibm_is_image "ubuntu" {
  name = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}

data ibm_is_ssh_key "ssh_key_id" {
  name = "${var.ssh_key}"
}

data ibm_resource_group "group" {
  name = "RG-dnovais"
}

resource ibm_is_subnet "subnet1" {
  name = "${local.BASENAME}-subnet1"
  vpc  = "${data.ibm_is_vpc.vpc.id}"
  zone = "${local.ZONE}"
  total_ipv4_address_count = 256
}

}
