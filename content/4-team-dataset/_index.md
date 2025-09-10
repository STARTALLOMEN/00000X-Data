---
title: "Register Team and Dataset"
date: 2024-01-01
weight: 40
chapter: false
pre: "<b>4. </b>"
---

## Overview

In this section, we will register the "yelp-recommender" team and "yelp-business-data" dataset in SDLF to establish Yelp data processing structure and access permissions for the recommendation system.

[Official documentation on SDLF Teams and Datasets](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-team)

![Team and Dataset Architecture](../../../static/images/4/0.png?width=40pc)

## Key Components for Yelp Recommendation System

1. **Team "yelp-recommender"**: Team managing Yelp dataset and recommendation algorithms
2. **Datasets**: 
   - `yelp-business-data`: Business information and attributes
   - `yelp-review-data`: User reviews and ratings
   - `yelp-user-data`: User profiles and preferences
3. **Permissions**: Access rights for ETL pipelines and API functions
4. **Data Catalog**: Metadata about Yelp dataset structure and relationships

## Team Configuration

- **Team Name**: `yelp-recommender`
- **Datasets**: Multiple Yelp data sources
- **Access Pattern**: Read/Write for ETL, Read-only for recommendation APIs
- **Security**: Row-level security for sensitive user data

## Implementation Steps

1. [Register team "yelp-recommender"](1-register-team)
2. [Create Yelp datasets](2-create-dataset)
3. [Set up permissions for recommendation system](3-configure-permissions)

{{% notice note %}}
Registering teams and datasets for Yelp data is an important step to establish security boundaries and data governance for the recommendation system.
{{% /notice %}}

{{% notice warning %}}
Make sure you have completed the CI/CD Pipeline section before starting this part. Team registration requires pipeline infrastructure.
{{% /notice %}}

{{% notice tip %}}
Team and dataset setup doesn't incur additional costs but establishes foundation for data processing charges later.
{{% /notice %}}

## Next Step

Next, we will [Register team "yelp-recommender"](1-register-team) to begin setting up the Yelp data structure.