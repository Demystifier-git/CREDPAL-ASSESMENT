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

### Running Locally

1. Clone the repository:

```bash
git clone https://github.com/<your-username>/credpal-node-app.git
cd credpal-node-app