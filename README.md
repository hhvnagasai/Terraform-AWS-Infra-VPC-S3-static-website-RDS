# Terraform AWS Infrastructure Project

## Project Overview

This project demonstrates the deployment of a production-style AWS infrastructure using Terraform with a modular architecture and security-focused best practices. The infrastructure includes a custom VPC, public and private subnets, Internet Gateway, NAT Gateway, route tables, S3 static website hosting, and a secure MySQL RDS instance deployed inside private subnets.

The project was designed to showcase real-world DevOps and Infrastructure as Code (IaC) concepts such as modular Terraform design, secure cloud provisioning, networking architecture, automated infrastructure deployment, and cloud security best practices.

---

# AWS Services Used

* AWS VPC
* AWS Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Amazon S3
* Amazon RDS
* IAM
* Terraform

---

# Architecture

Internet
│
▼
Internet Gateway
│
▼
Public Subnet
│
├── NAT Gateway
│
▼
Private Subnets
│
└── RDS (MySQL)

S3 Bucket
└── Static Website Hosting

---

# Features Implemented

* Custom VPC creation
* Public and Private Subnets
* Public and Private Route Tables
* Internet Gateway configuration
* NAT Gateway setup
* S3 Static Website Hosting
* Dynamic website file upload using Terraform
* RDS MySQL deployment in private subnet
* Security Group based access control
* Modular Terraform architecture
* Infrastructure as Code (IaC)
* Sensitive file protection using `.gitignore`

---

# Project Structure

terraform-storage-task/

├── main.tf
├── variables.tf
├── output.tf
├── provider.tf
├── .gitignore
├── website/
├── modules/

modules/

├── vpc/
├── public_subnet/
├── private_subnet/
├── internet_gateway/
├── nat_gateway/
├── route_table_public/
├── route_table_private/
├── s3_website/
└── rds/

---

# Terraform Commands

## Initialize Terraform

terraform init

## Validate Configuration

terraform validate

## Preview Infrastructure

terraform plan

## Deploy Infrastructure

terraform apply

---

# Security Best Practices Implemented

* RDS deployed inside private subnet
* Public access disabled for RDS
* Sensitive Terraform files excluded using `.gitignore`
* No hardcoded AWS credentials
* Terraform variables used for sensitive values
* Controlled access using Security Groups
* Modular reusable infrastructure design

---

# S3 Static Website Hosting

The static website is hosted using Amazon S3 static website hosting.

Implemented Features:

* Automatic file upload using Terraform
* Dynamic file mapping using `fileset()`
* MIME type handling for HTML/CSS/JS
* Public bucket policy for website access
* Website endpoint output generation

---

# RDS Configuration

* Engine: MySQL
* Instance Type: db.t3.micro
* Deployment: Private Subnets
* Security Group restricted access
* Backup retention enabled
* Storage encryption enabled
* Multi-AZ ready subnet architecture

---

# Real-Time Errors Faced & Solutions

## 1. S3 Bucket Already Exists Error

Error:

BucketAlreadyExists: The requested bucket name is not available

Reason:
S3 bucket names are globally unique across AWS.

Solution:
Added unique naming strategy using custom bucket naming.

---

## 2. Route Table Output Error

Error:

Reference to undeclared resource

Reason:
Incorrect resource name used inside output block.

Solution:
Corrected resource references in output.tf files.

---

## 3. Website URL Not Working

Error:

DNS_PROBE_FINISHED_NXDOMAIN

Reason:
Incorrect S3 website endpoint format used.

Wrong Format:

s3-website-ap-south-1.amazonaws.com

Correct Format:

s3-website.ap-south-1.amazonaws.com

Solution:
Updated Terraform output URL format.

---

## 4. RDS Subnet Group Error

Error:

DBSubnetGroupDoesNotCoverEnoughAZs

Reason:
RDS requires subnets in at least 2 Availability Zones.

Solution:
Created an additional private subnet in another Availability Zone and attached both subnets to the DB subnet group.

---

## 5. RDS Password Variable Errors

Errors:

Missing required argument
Reference to undeclared input variable

Reason:
Variable naming mismatch between root module and child module.

Solution:
Corrected variable mappings and implemented secure password handling using Terraform variables.

---

## 6. GitHub Security Issues

Problem:
Sensitive files like:

* terraform.tfstate
* terraform.tfvars
* .terraform/

should not be pushed to GitHub.

Solution:
Configured `.gitignore` properly to secure sensitive files.

---

# Key Skills Demonstrated

* Terraform
* AWS Networking
* Infrastructure as Code
* Cloud Security
* S3 Static Website Hosting
* RDS Deployment
* Modular Terraform Design
* DevOps Best Practices
* Troubleshooting & Debugging

---

# Future Improvements

* CloudFront Integration
* GitHub Actions CI/CD
* Remote Terraform Backend (S3 + DynamoDB)
* AWS Secrets Manager Integration
* Multi-AZ RDS Deployment
* Monitoring with CloudWatch

---

# Author
Name - P.HARIHARA VENKATA NAGASAI

Role - DevOps Engineer 
