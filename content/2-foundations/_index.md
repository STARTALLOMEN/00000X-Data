---
title: "Deploy SDLF Foundations"
date: 2024-01-01
weight: 20
chapter: false
pre: "<b>2. </b>"
---

## Overview

SDLF Foundations is the basic infrastructure needed to deploy the Serverless Data Lake Framework. This section will set up the core components of the data lake.

[Official documentation on SDLF Foundations](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-foundations)

![SDLF Foundations Architecture](../../../static/images/2/0.png?width=40pc)

## Key Components

1. **S3 Buckets**: Store raw, processed, and curated data
2. **Glue Data Catalog**: Manage metadata and schema
3. **Lake Formation**: Manage data access permissions
4. **IAM Roles**: Assign permissions for services
5. **KMS Keys**: Encrypt data
6. **CloudWatch**: Monitor and log activities

## Implementation Steps

1. [Clone SDLF repository](1-clone-repository)
2. [Configure parameters](2-configure-parameters)
3. [Deploy CloudFormation](3-deploy-cloudformation)
4. [Verify deployment results](4-verify-deployment)

{{% notice note %}}
The SDLF Foundations deployment process may take about 15-20 minutes. This is a good time to learn more about the SDLF architecture.
{{% /notice %}}

{{% notice warning %}}
Make sure you are using the region selected in the previous section. Changing regions midway can cause errors.
{{% /notice %}}

## Next Step

Next, we will [Clone the SDLF repository](1-clone-repository) to begin deployment.