module "ssh_key_pair" {
  source = "../../modules/key_pair"

  env      = "dev"
  key_path = file("~/.ssh/asus-laptop.pub")
}