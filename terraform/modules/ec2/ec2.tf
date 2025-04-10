# data "terraform_remote_state" "vpc" {
#   backend = "local"

#   config = {
#     path = "../../project"
#   }
# }


# resource "aws_instance" "myec2" {
#   ami           = var.instance_ami["us-east-1-amazon"]
#   instance_type = "t2.micro"
#   for_each = tomap(data.terraform_remote_state.vpc.outputs.private_subnet)
#   subnet_id      = each.value.id
#   tags = {
#     Name = "ec2-dev"
#   }
# }


