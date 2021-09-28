# LoadBalancer.org Appliance with Terraform
This repo contains a Terraform build for creating an HA-Pair with LoadBalancer.org appliances. Feel free to change as needed to suit your use case.

## Prereqs:
1. Terraform
2. Azure Account
3. Azure CLI

## LoadBalancer.org

### Advanced Layer 4/7 load balancing
Powerful, highly customizable solution which includes automated configuration, content routing and caching, DSR, Layer 7 content switching, VLAN tagging, and many other features. 

### Fully integrated WAF and GSLB
Secure, OWASP top 10-compliant Web Application Firewall protects your mission-critical services, while Global Server Load Balancing as standard ensures resilient multi-site deployments.

### SSL acceleration and offload
Unlimited support for SSL certificates, as well as support for third-party certificates and automated SSL certificate chaining. 


### High-performing, scalable and cost effective
High availability enables easy management without impacting your environment – update infrastructure assets without disruption, and enjoy limitless scalability.

### Effortless and consistent multi-site deployments
Load balance and scale across on-premise, hybrid, or cloud environments. World-class documentation and an intuitive web interface ensure simple setup, configuration and management.

### Secure, resilient and intelligent platform
Ensure uptime and protect your applications with enhanced features including seamless failover, customizable health checks, session persistence, WAF, and more.

## How To Use:
1. Clone this repo to any working directory you wish
2. Ensure you're logged into Azure from the terminal you plan to deploy from
3. Create password on line 54 in azurevm.tf that Azure will allow (15 characters with symbols, numbers, letters)
4. Run terraform init
5. Run terraform apply

Finished
