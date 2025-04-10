variable "instance_ami" {
  type= map(any)
  default = {
    us-east-1-amazon:"ami-00a929b66ed6e0de6"

  }
}