terraform {
  backend "s3" {
    bucket         = "sentania-labs-terraform-state"
    key            = "vra/vm-apps-private-cloud/lab/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}