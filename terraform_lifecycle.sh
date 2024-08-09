#!/bin/bash
git stash
git merge
git pull origin main
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply --auto-approve