variable "AZ" {
  type    = set(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_cidrs" {
  type = map(any)
  default = {
    public_1 : "10.0.10.0/24",
    public_2 : "10.0.20.0/24"
  }
}
variable "private_cidrs" {
  type = map(any)
  default = {
    private_1 : "10.0.10.0/24",
    private_2 : "10.0.20.0/24"
  }
}


