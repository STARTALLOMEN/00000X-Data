---
title: "Register Team and Dataset"
date: 2024-01-01
weight: 40
chapter: false
pre: "<b>4. </b>"
---

## Overview

In this section, we will register a team and dataset in SDLF to establish data structure and access permissions.

[Official documentation on SDLF Teams and Datasets](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-team)

![Team and Dataset Architecture](../../../static/images/4/0.png?width=40pc)

## Key Components

1. **Team**: Working group with specific access permissions
2. **Dataset**: Data set managed by the team
3. **Permissions**: Access rights to data
4. **Data Catalog**: Metadata about the data

## Implementation Steps

1. [Register a team](1-register-team)
2. [Create a dataset](2-create-dataset)
3. [Set up access permissions](3-configure-permissions)

{{% notice note %}}
Registering teams and datasets is an important step to establish data structure and access permissions in SDLF.
{{% /notice %}}

{{% notice warning %}}
Make sure you have completed the CI/CD Pipeline section before starting this part.
{{% /notice %}}

## Next Step

Next, we will [Register a team](1-register-team) to begin setting up the data structure.