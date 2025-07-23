---
title: "Set up CI/CD Pipeline"
date: 2024-01-01
weight: 30
chapter: false
pre: "<b>3. </b>"
---

## Overview

The CI/CD Pipeline is an important component for automating the deployment and updates of SDLF. This pipeline will use AWS CodeCommit, CodeBuild, and CodePipeline.

[Official documentation on SDLF CI/CD](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-cicd)

![CI/CD Pipeline Architecture](../../../static/images/3/0.png?width=40pc)

## Key Components

1. **CodeCommit**: Repository for storing source code
2. **CodeBuild**: Build and test code
3. **CodePipeline**: Orchestrate the CI/CD process
4. **CloudFormation**: Deploy infrastructure
5. **S3 Artifacts**: Store build artifacts

## Implementation Steps

1. [Create CodeCommit repositories](1-create-repositories)
2. [Configure CodeBuild](2-configure-codebuild)
3. [Set up CodePipeline](3-setup-pipeline)
4. [Test the pipeline](4-test-pipeline)

{{% notice note %}}
The CI/CD Pipeline will help automate the deployment of SDLF components whenever there are changes in the source code.
{{% /notice %}}

{{% notice warning %}}
Make sure you have completed the SDLF Foundations section before starting this part.
{{% /notice %}}

## Next Step

Next, we will [Create CodeCommit repositories](1-create-repositories) to store the SDLF source code.