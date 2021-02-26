# Docker/ECS/Terraform Example

This repository shows a trivial infrastructure setup that was cobbled together from various tutorials.

This is a starting point I'm using to move my applications off of Heroku. In retrospect my relatively trivial apps should have been moved to a serverless technology like Lambda. That said, any feedback is welcome and hopefully this will help others.

### Details

It sets up several things:

* An AWS Fargate cluster, service, and ECS task for a containerized app with multi-AZ support. All defaults are set to bare minimums, so you'll need to edit to taste.
* A CloudWatch log group and stream.
* A DNS entry within a supplied hosted zone.
* An application load balancer (ALB) and SSL certificate with support for routing traffic from port 443 and 80 to your application's locally exposed container port.
* Some baseline networking, VPC, security groups, etc.

Things it doesn't set up:

* A database.
* Auto-scaling.
* Your hosted zone. You'll need to add it manually in Route53.

### Getting Started

1. Clone this repository.
1. Remove git references: `rm -rf .git`
1. Start with the example tfvars: 
    ```cp terraform.tfvars.example terraform.tfvars```
1. Edit `terraform.tfvars` to taste.
1. Run terraform: `terraform init ; terraform plan`
1. `apply` when ready!