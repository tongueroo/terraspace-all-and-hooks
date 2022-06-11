terraform {
  backend "s3" {
    bucket         = "<%= expansion('terraform-state-:ACCOUNT-:REGION-:ENV') %>"
    key            = "<%= expansion(':TYPE_DIR/:APP/:ROLE/:MOD_NAME/:ENV/:EXTRA/:REGION/terraform.tfstate') %>"
    region         = "<%= expansion(':REGION') %>"
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
