# Hello World Web Application Deployment

This project deploys a scalable "Hello World" web application using Infrastructure-as-Code (IaC). The app retrieves a "Hello World" message from a database and displays it to users, designed for high availability and scalability.

## Overview
- **IaC Tool**: Terraform on AWS.
- **App**: Flask (Python) application displaying "Hello World" from an RDS MySQL database.
- **Monitoring**: AWS CloudWatch for system and application performance.
- **Security**: VPC, Security Groups, WAF, and IAM roles for secure access.

## Prerequisites
- **AWS Account**
- **Terraform**: Install Terraform to deploy IaC.
- **Python 3**: Required to run the Flask app.

## Quick Start
1. **Clone the Repository**:
    ```bash
    git clone https://github.com/abdulrahmandv/project_curology.git
    cd project_curology
    ```
2. **Set up AWS credentials** and configure access.
3. **Initialize and Apply Terraform**:
    ```bash
    terraform init
    terraform apply
    ```

## Infrastructure Components
- **VPC with Subnets**: Public and private subnets for security and isolation.
- **Auto Scaling EC2 Instances**: Hosts the Flask app, scaling based on demand.
- **Application Load Balancer (ALB)**: Distributes traffic for high availability.
- **RDS MySQL Database**: Stores the "Hello World" message.

## Monitoring
CloudWatch monitors:
- **EC2 CPU Usage**: Ensures servers scale to handle traffic.
- **Database Connections and Latency**: Monitors response times.
- **Request Rates and Response Times**: Tracks user experience.

**Why These Metrics?** These metrics help monitor application performance, ensuring reliability and readiness for scaling.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
