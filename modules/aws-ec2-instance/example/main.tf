module "ec2_instance" {
  source  = "../"

  project_id             = "my-ec2-instance"
  instance_id            = "t3.micro"
  vpc_id                 = "vpc-063d7xxxxxxxxxxxx"
  ssh_keyname            = "ireland-key"
  subnet_id              = "subnet-04b3xxxxxxxxxxxxx"
  ubuntu_distribution_id = "22.04"

}
