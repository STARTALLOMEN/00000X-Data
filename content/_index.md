---
title: "Building Location Recommendation System"
date: 2024-01-01
weight: 1
chapter: false
---


# Building Location Recommendation System

#### Overview

This workshop guides learners through implementing Serverless Data Lake Framework (SDLF) to build a Location Recommendation System using Yelp Dataset. We will use AWS serverless services to create a powerful recommendation engine platform that is scalable and production-ready.

This system uses Serverless Data Lake Framework (SDLF) - a toolkit comprising reusable infrastructure components, designed to accelerate the deployment of enterprise recommendation systems on AWS. SDLF adheres to the principles of the AWS Well-Architected Framework and provides efficient large-scale Yelp data processing capabilities, as detailed in the [documentation](https://sdlf.readthedocs.io/en/latest/).

![SDLF Architecture](/images/1/sdlf-layers-architecture.png?width=90pc)

| Layer | Description for Location Recommendation System |
| --- | --- |
| storage | Store Yelp Dataset (business, review, user, tip, checkin) in S3 with Lake Formation |
| catalog | Glue data catalog managing Yelp data schemas and metadata for recommendation engine |
| processing | Lambda functions and Glue jobs processing Yelp data, calculating recommendation scores and similarity metrics |
| consumption | Athena workgroups to query business data and create recommendation APIs |
| orchestration | Step Functions and EventBridge orchestrating ETL workflows and recommendation pipelines |
| governance and security | Lake Formation, KMS Keys, and IAM Roles securing Yelp data and API access |

#### Objectives

The objective of this workshop is to build a Location Recommendation System using Yelp Open Dataset. We will illustrate how Yelp data (businesses, reviews, users, tips, check-ins) can be stored, categorized, transformed, and used to create powerful recommendation APIs for location search and suggestions.

This workshop uses Yelp Open Dataset containing information about over 150,000 businesses, 6.9 million reviews, and 1.9 million users in JSON format. The dataset is downloaded from [Yelp Open Dataset](https://www.yelp.com/dataset) and has been prepared for the purposes of this workshop.

Using SDLF, we will:
- Process and standardize Yelp data through ETL pipelines
- Create recommendation algorithms based on rating, location, and user preferences
- Build APIs for business search and location recommendations
- Develop analytics dashboard for business intelligence

## Implementation Steps

1. [Prerequisites](1-prerequisite)
2. [Deploy SDLF Foundations](2-foundations)
3. [Set up CI/CD Pipeline](3-cicd-pipeline)
4. [Register Team and Dataset](4-team-dataset)
5. [Deploy ETL Pipeline for Yelp Data](5-etl-pipeline)
6. [Ingest and Process Yelp Data](6-data-ingestion)
7. [Build Recommendation APIs with Athena](7-athena-query)
8. [Monitoring and Troubleshooting](8-monitoring)
9. [Clean Up Resources](9-cleanup)
