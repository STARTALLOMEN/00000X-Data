---
title: "Serverless Data Lake Framework Jump Start"
date: 2024-01-01
weight: 1
chapter: false
---


# Serverless Data Lake Framework Jump Start

#### Overview

This workshop guides learners through implementing AWS serverless services to build a modern data lake architecture on the AWS platform, ensuring scalability and future readiness.

Serverless Data Lake Framework (SDLF) is a toolkit comprising reusable infrastructure components, designed to accelerate the deployment of enterprise data lake systems on AWS, helping reduce production deployment time from months to just weeks. SDLF adheres to the principles of the AWS Well-Architected Framework and provides many other benefits for businesses, as detailed in the [documentation](https://sdlf.readthedocs.io/en/latest/).

![SDLF Architecture](/images/1/sdlf-layers-architecture.png?width=90pc)

| Layer | Description |
| --- | --- |
| storage | Data lake storage layers with S3 and Lake Formation |
| catalog | Glue data catalog (databases and crawlers) |
| processing | Lambda functions and Glue jobs triggered by EventBridge to process data |
| consumption | Athena workgroups to query and use data |
| orchestration | Step Functions and EventBridge to orchestrate processing workflows |
| governance and security | Lake Formation, KMS Keys, and IAM Roles for governance and security |

#### Objectives
Our goal is to illustrate how raw data can be stored, categorized, transformed (using light and/or heavy transformation methods), and consumed by applications and end users.

This workshop uses a dataset downloaded from [here](https://github.com/aws-solutions-library-samples/data-lakes-on-aws/tree/main/sdlf-utils/workshop-examples/legislators/data). The dataset contains JSON-formatted information about US legislators and the positions they have held in the US House of Representatives and Senate, and has been lightly edited and provided in the GitHub repository for the purposes of this workshop.

In this workshop, using SDLF, we will standardize and process data using light and heavy transformation methods, and ultimately make the data queryable by end users through Amazon Athena.

## Implementation Steps
    
1. [Prerequisites](1-prerequisite)
2. [Deploy SDLF Foundations](2-foundations)
3. [Set up CI/CD Pipeline](3-cicd-pipeline)
4. [Register Team and Dataset](4-team-dataset)
5. [Deploy ETL Pipeline](5-etl-pipeline)
6. [Ingest and Process Data](6-data-ingestion)
7. [Query Data with Athena](7-athena-query)
8. [Monitoring and Troubleshooting](8-monitoring)
9. [Clean Up Resources](9-cleanup)