---
title: "Deploy SDLF Foundations"
date: 2024-01-01
weight: 20
chapter: false
pre: "<b>2. </b>"
---

## SDLF Foundations Overview

SDLF Foundations is the basic infrastructure required to deploy Serverless Data Lake Framework. This section will set up the core components of the data lake.

### Foundations Architecture

![SDLF Foundations Architecture](../../../static/images/2/0.png?width=40pc)

### Key Components:

1. **S3 Buckets**: Store raw, processed, and curated data
2. **Glue Data Catalog**: Manage metadata and schema
3. **Lake Formation**: Manage data access permissions
4. **IAM Roles**: Permissions for services
5. **KMS Keys**: Data encryption
6. **CloudWatch**: Monitoring and logging

### Deployment Process:

1. **Download SDLF**: Clone repository and configure
2. **Configure Parameters**: Set up required parameters
3. **Deploy CloudFormation**: Create infrastructure
4. **Verify Deployment**: Check created components

### Estimated Time: 45-60 minutes

{{% notice note %}}
Make sure you have completed the Prerequisites section before starting this section.
{{% /notice %}}