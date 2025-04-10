module "custom_vpc" {
 source="../modules/vpc" 
}

module "custom_ec2"{
  source = "../modules/ec2"
}