# Terraspace Example Project: All and Hooks

This is an example Terraspace project to help debug: https://community.boltops.com/t/terraspace-all-up-does-not-run-terraform-hooks/912

## Debugging

The hook code

app/stacks/demo/config/hooks/terraform.rb

```ruby
before("apply",
  execute: "echo 'app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply'",
)

after("apply",
  execute: "echo 'app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply'"
)
```

Testing terraspace all

    $ terraspace all up -y
    Running:
        terraspace up demo # batch 1
    Batch Run 1:
    Running: terraspace up demo Logs: log/up/demo.log
    app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply
    app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply
    terraspace up demo:  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    Time took: 3s
    $ cat log/up/demo.log
    # Logfile created on 2022-06-11 01:37:45 +0000 by logger.rb/v1.5.0
    [2022-06-11T01:37:45 #16835 terraspace up demo]: Current directory: .terraspace-cache/us-west-2/dev/stacks/demo
    [2022-06-11T01:37:46 #16835 terraspace up demo]: => terraform plan -input=false
    [2022-06-11T01:37:47 #16835 terraspace up demo]:
    [2022-06-11T01:37:47 #16835 terraspace up demo]: Terraform used the selected providers to generate the following execution
    [2022-06-11T01:37:47 #16835 terraspace up demo]: plan. Resource actions are indicated with the following symbols:
    [2022-06-11T01:37:47 #16835 terraspace up demo]:   + create
    [2022-06-11T01:37:47 #16835 terraspace up demo]:
    [2022-06-11T01:37:47 #16835 terraspace up demo]: Terraform will perform the following actions:
    [2022-06-11T01:37:47 #16835 terraspace up demo]:   # random_pet.this will be created
    [2022-06-11T01:37:47 #16835 terraspace up demo]:   + resource "random_pet" "this" {
    [2022-06-11T01:37:47 #16835 terraspace up demo]:       + id        = (known after apply)
    [2022-06-11T01:37:47 #16835 terraspace up demo]:       + length    = 2
    [2022-06-11T01:37:47 #16835 terraspace up demo]:       + separator = "-"
    [2022-06-11T01:37:47 #16835 terraspace up demo]:     }
    [2022-06-11T01:37:47 #16835 terraspace up demo]:
    [2022-06-11T01:37:47 #16835 terraspace up demo]: Plan: 1 to add, 0 to change, 0 to destroy.
    [2022-06-11T01:37:47 #16835 terraspace up demo]:
    [2022-06-11T01:37:47 #16835 terraspace up demo]: ───────────────────────────
    [2022-06-11T01:37:47 #16835 terraspace up demo]:
    [2022-06-11T01:37:47 #16835 terraspace up demo]: Note: You didn't use the -out option to save this plan, so Terraform can't
    [2022-06-11T01:37:47 #16835 terraspace up demo]: guarantee to take exactly these actions if you run "terraform apply" now.
    [2022-06-11T01:37:47 #16835 terraspace up demo]: Hook: Running terraform before apply hook.
    [2022-06-11T01:37:47 #16835 terraspace up demo]: => echo 'app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply'
    [2022-06-11T01:37:47 #16835 terraspace up demo]: => terraform apply -auto-approve -input=false
    [2022-06-11T01:37:48 #16835 terraspace up demo]:
    [2022-06-11T01:37:48 #16835 terraspace up demo]: Terraform used the selected providers to generate the following execution
    [2022-06-11T01:37:48 #16835 terraspace up demo]: plan. Resource actions are indicated with the following symbols:
    [2022-06-11T01:37:48 #16835 terraspace up demo]:   + create
    [2022-06-11T01:37:48 #16835 terraspace up demo]:
    [2022-06-11T01:37:48 #16835 terraspace up demo]: Terraform will perform the following actions:
    [2022-06-11T01:37:48 #16835 terraspace up demo]:   # random_pet.this will be created
    [2022-06-11T01:37:48 #16835 terraspace up demo]:   + resource "random_pet" "this" {
    [2022-06-11T01:37:48 #16835 terraspace up demo]:       + id        = (known after apply)
    [2022-06-11T01:37:48 #16835 terraspace up demo]:       + length    = 2
    [2022-06-11T01:37:48 #16835 terraspace up demo]:       + separator = "-"
    [2022-06-11T01:37:48 #16835 terraspace up demo]:     }
    [2022-06-11T01:37:48 #16835 terraspace up demo]:
    [2022-06-11T01:37:48 #16835 terraspace up demo]: Plan: 1 to add, 0 to change, 0 to destroy.
    [2022-06-11T01:37:48 #16835 terraspace up demo]:
    [2022-06-11T01:37:48 #16835 terraspace up demo]: random_pet.this: Creating...
    [2022-06-11T01:37:48 #16835 terraspace up demo]: random_pet.this: Creation complete after 0s [id=enough-rattler]
    [2022-06-11T01:37:49 #16835 terraspace up demo]:
    [2022-06-11T01:37:49 #16835 terraspace up demo]: Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    [2022-06-11T01:37:49 #16835 terraspace up demo]:
    [2022-06-11T01:37:49 #16835 terraspace up demo]: Hook: Running terraform after apply hook.
    [2022-06-11T01:37:49 #16835 terraspace up demo]: => echo 'app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply'
    [2022-06-11T01:37:49 #16835 terraspace up demo]: Time took: 1s
    $

Testing terraspace up

    $ terraspace up demo -y
    Building .terraspace-cache/us-west-2/dev/stacks/demo
    Current directory: .terraspace-cache/us-west-2/dev/stacks/demo
    => terraform plan -input=false
    random_pet.this: Refreshing state... [id=enough-rattler]

    No changes. Your infrastructure matches the configuration.


    Terraform has compared your real infrastructure against your configuration
    and found no differences, so no changes are needed.
    Hook: Running terraform before apply hook.
    => echo 'app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply'
    app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply
    => terraform apply -auto-approve -input=false
    random_pet.this: Refreshing state... [id=enough-rattler]

    No changes. Your infrastructure matches the configuration.


    Terraform has compared your real infrastructure against your configuration
    and found no differences, so no changes are needed.

    Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

    Hook: Running terraform after apply hook.
    => echo 'app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply'
    app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply
    Time took: 1s
    $

## Deploy

To deploy all the infrastructure stacks:

    terraspace all up

To deploy individual stacks:

    terraspace up demo # where demo is app/stacks/demo

## Terrafile

To use more modules, add them to the [Terrafile](https://terraspace.cloud/docs/terrafile/).
