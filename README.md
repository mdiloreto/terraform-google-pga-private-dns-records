
## Overview

This module is designed to enable and configure Private Google Access (PGA) in a Google Cloud Virtual Private Cloud (VPC). By enabling Private Google Access, Compute Engine VMs without external Virtual IP (VIP) addresses can connect to Google APIs and services through their internal IP addresses and the Default Route to 0.0.0.0/0 in the VPC does not have Default Internet Gateway as Next Hop. This will maintain external traffic to Google APIs and Services within the GCP Backbone.

Refer oficial Google Documentation for more details: [Configure Private Google Access](https://cloud.google.com/vpc/docs/configure-private-google-access)


## Table of Contents

- [Overview](#overview)
- [Theoretical Introduction](#theoretical-introduction)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Examples](#examples)
- [License](#license)

## Theoretical Introduction

### Private Google Access (PGA)

Private Google Access (PGA) allows Compute Engine virtual machine (VM) instances that only have internal IP addresses (i.e., no external IP addresses) to access Google APIs and services via their internal IP addresses. This is particularly useful for enhancing security and controlling data exfiltration by ensuring that traffic to Google services does not traverse the public internet.

### Benefits of Private Google Access

- **Enhanced Security**: By keeping traffic within Google's network, you reduce the exposure to external threats.
- **Simplified Compliance**: Keeping data transfers internal helps with compliance requirements that mandate strict control over data movement.
- **Cost Efficiency**: Eliminating the need for external IP addresses can reduce costs associated with networking and public IP address usage.

### Default Route usage

There are 2 ways of setting up the access to the Google APIs and Services that varies depending on the Routes configuration. Ensure that your VPC network can route traffic to the IP address ranges that are used by Google APIs and services.

* Basic configuration: 
  * Confirm that you have default routes with next hop default-internet-gateway and a destination range of 0.0.0.0/0 (for IPv4 traffic) and ::/0 (for IPv6 traffic, if needed). 
  * Create those routes if they are missing.

* Custom configuration: 
  * You DON'T have the default routes with next hop default-internet-gateway and a destination range of 0.0.0.0/0 (for IPv4 traffic) and ::/0 (for IPv6 traffic, if needed). 
  * Create routes for the IP address ranges used by Google APIs and services.
  * For this configuration option you have to configure new Routes and Private DNS Records for using the VIPs of the services. 

### private.googleapis.com

The domain `private.googleapis.com` is used to route traffic from your VMs to Google APIs and services using a private path that does not leave Google's network. This domain is especially useful for scenarios where you want to access services like Google Cloud Storage, Google Cloud Bigtable, and Google Cloud BigQuery without exposing your VMs to the public internet.

## How Private Google Access Works

1. **Enabling PGA on Subnets**: PGA is enabled on a per-subnet basis within your VPC. When enabled, VMs in the subnet can access Google services using their internal IP addresses.
2. **DNS Configuration**: Configure DNS to resolve `private.googleapis.com` to the appropriate private IP addresses provided by Google.
3. **Routing and Firewall**: Ensure proper routing and firewall rules are in place to allow traffic to the private IP ranges used by Google services.


## Prerequisites

- A Google Cloud Platform project with billing enabled.
- Terraform installed on your local machine.
- Proper IAM roles assigned: Project Owner, Editor, or Network Admin.

## Usage

1. Clone this repository to your local machine or use the Module from the Terraform Registry.
2. Navigate to the module directory.
3. Create a `main.tf` file and include the following code:

    ```hcl
    module "private_google_access" {
      source = "./path_to_module_directory"
      network_url    = var.network_url
      project_id     = var.project_id

    }
    ```

4. Define the required variables in a `variables.tf` file:

    ```hcl
    variable "project_id" {
      description = "The ID of the project in which to create the resources."
      type        = string
    }

    variable "network_url" {
      description = "Id or Self_link of the VPC."
      type        = string
    }
    ```

5. Create a `terraform.tfvars` file to specify the values for these variables:

    ```hcl
    project_id = "your-project-id"
    network_url = "projects/zone/your-network-name"

    ```

6. Initialize Terraform and apply the configuration:

    ```bash
    terraform init
    terraform apply
    ```

## Outputs

This module does not have specific outputs. It updates the existing subnet to enable Private Google Access.
