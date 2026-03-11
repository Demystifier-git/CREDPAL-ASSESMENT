# CredPal Node.js Application - DevOps Assessment

## Overview

This repository contains a basic Node.js application with a PostgreSQL database. The application exposes the following endpoints:

- `GET /health` - Returns the health status of the application and database.
- `GET /status` - Returns application status and environment information.
- `POST /process` - Accepts JSON data and stores it in the database.

The application runs on port 3000 and is fully containerized using Docker. The infrastructure and deployment are automated using Terraform and GitHub Actions.

---

## Table of Contents

1. [Local Setup](#local-setup)  
2. [Accessing the Application](#accessing-the-application)  
3. [CI/CD Pipeline](#cicd-pipeline)  
4. [Infrastructure](#infrastructure)  
5. [Deployment Strategy](#deployment-strategy)  
6. [Security and Observability](#security-and-observability)  
7. [Key Decisions](#key-decisions)

---

## Local Setup

### Prerequisites

- Docker and Docker Compose installed
- Node.js (optional for local development outside containers)
- PostgreSQL (optional for local development outside containers)

- git clone https://github.com/Demystifier-git/CREDPAL-ASSESMENT.git
- Copy environment files:
- remove .example, .env will be left, before you run the command below
- cp src/.env.example src/.env
- cp database/.env.example database/.env 

- Start the application and database using Docker Compose
- docker compose up -d 
- docker compose up --build


The application will be accessible on http://localhost:3000


## Accessing the application
2. Accessing the Application

Once deployed in production, the application can be accessed using the public URL of the load balancer or domain.

- GET /health - Check the health of the application and database.
- GET /status - Check the status of the application.
- POST /process - Submit JSON payloads to store data in the database.

Example POST request:
curl -X POST https://your-app-domain/process \
  -H "Content-Type: application/json" \
  -d '{"key": "value"}'

This application can accessed live at;
- app.delightdavid.online/health
- app.delightdavid.online/status
- app.delightdavid.online/process


## CI/CD PIPELINE
3. CI/CD PIPELINE

The CI/CD workflow is implemented using GitHub Actions. It includes the following steps:

- Checkout repository
- Configure AWS credentials
- Package the application into a tarball
- Upload the tarball to S3
- configure Dockerhub credentials
- Deploy the application to the private EC2 instance via AWS SSM
- Switch to root and start containers using Docker Compose
- The pipeline is triggered by:
- Pushes to the main branch
- Manual workflow dispatch
- Manual approval is required before deploying to the production environment to ensure controlled releases.

## Infrastructure
4. Infrastructure

Infrastructure is provisioned using Terraform:

- VPC with public and private subnets
- Security groups for EC2,Load Balancer and VPC
- EC2 instance running the application
- Application Load Balancer with HTTPS configured
- Target group for traffic distribution
- IAM roles and instance profile for SSM and S3 access
- ROUTE53 configured for domain routing
- ACM configured for ssl certifcates
- Health checks configured as well 

## Deployment strategy
5. Zero-downtime deployment: 
- Implemented using rolling updates via Docker Compose. New containers are started before stopping the old ones.
- Manual approval: Required for production deployment using GitHub Actions environment protection rules.

## Security and observability
6. security and observability:
- Secrets such as database credentials, AWS keys, and Docker credentials are stored securely using - - - - GitHub Secrets and environment variables.
- HTTPS is enabled on the Application Load Balancer.
- The Node.js application runs as a non-root user inside the Docker container.
- Basic logging is implemented using console logs for server startup, database connection, and endpoint actions.
- Health checks are exposed via /health endpoint for monitoring.

## key-decisions
7. key-decisions
- Docker Multi-stage Build: Ensures small, production-ready images with only necessary dependencies.
- SSM Deployment: EC2 instances are updated via AWS SSM for security and automation.
- GitHub Actions: Provides CI/CD automation with production manual approval.
- Terraform IaC: Fully automates infrastructure creation and ensures reproducibility.
- Secrets Management: No secrets stored in GitHub code; all sensitive data is stored in environment secrets.
- Zero-downtime Deployment: Ensures continuous availability during application updates.
- Structured Logging: Enables easy monitoring and troubleshooting.  
- terraform statefiles and terraform.tfvars was kept in .gitignore because it contains sensitive files.

This setup provides a production-ready, fully automated DevOps pipeline for the Node.js application with secure, observable, and controlled deployment processes.


