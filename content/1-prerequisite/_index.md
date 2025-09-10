---
title: "Prerequisites"
date: 2024-01-01
weight: 10
chapter: false
pre: "<b>1. </b>"
---

## Overview

Before starting the deployment of the Location Recommendation System, we need to prepare the working environment on AWS. This section will guide you through logging into the AWS Management Console, opening AWS CloudShell, and selecting the appropriate region for building the location recommendation system using SDLF and Yelp Dataset.

[Official SDLF Documentation](https://github.com/awslabs/aws-serverless-data-lake-framework)

![SDLF Architecture](../../../static/images/1/0.png?width=40pc)

## Requirements

- AWS account with AdministratorAccess permissions (budget $150 USD)
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Stable internet connection to download Yelp Open Dataset
- Basic understanding of JSON format and business recommendation concepts

## Dataset Information

We will use **Yelp Open Dataset** including:
- **business.json**: Information about 150,000+ businesses (location, category, rating, attributes)
- **review.json**: 6.9 million reviews with ratings and text content
- **user.json**: 1.9 million user profiles and interaction history
- **tip.json**: Short tips from users about businesses
- **checkin.json**: Check-in data by time and location

## Implementation Steps

1. [Log in to AWS Management Console](1-aws-console)
2. [Open AWS CloudShell](2-cloudshell)
3. [Select appropriate region for cost optimization](3-region-selection)

{{% notice note %}}
This workshop is designed to be completed using AWS CloudShell with budget control ($150), allowing you to avoid installing any tools on your personal computer.
{{% /notice %}}

{{% notice warning %}}
Ensure you use region us-east-1 (N. Virginia) throughout the workshop to optimize costs and avoid data transfer charges.
{{% /notice %}}

{{% notice tip %}}
Estimated workshop cost: $20-40 for 3 months deployment, including S3 storage, Glue jobs, Lambda functions, and Athena queries.
{{% /notice %}}

## Next Step

Next, we will [Log in to AWS Management Console](1-aws-console) to begin building the Location Recommendation System.