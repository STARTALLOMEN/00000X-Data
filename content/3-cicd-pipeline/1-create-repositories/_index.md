---
title: "Create CodeCommit Repositories"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>3.1 </b>"
---

## Create CodeCommit Repositories

In this step, you will create CodeCommit repositories to store the source code for SDLF components.

### 1. Access CodeCommit

1. Log in to the AWS Console
2. Search for **CodeCommit** in the service search bar
3. Click **CodeCommit**

![Open CodeCommit](../../../static/images/3/3.2_OpenCodeCommit.png?width=90pc)

### 2. Create the first repository

1. Click **Create repository**
2. Enter **Repository name**: `sdlf-workshop-foundations`
3. Enter **Description**: `SDLF Foundations infrastructure code`
4. Click **Create repository**

![Create foundations repository](../../../static/images/3/3.3_CreateFoundationRepo.png?width=90pc)

### 3. Create the second repository

1. Click **Create repository** again
2. Enter **Repository name**: `sdlf-workshop-pipelines`
3. Enter **Description**: `SDLF Pipeline configurations`
4. Click **Create repository**

![Create pipelines repository](../../../static/images/3/3.4_CreatePipelineRepo.png?width=90pc)

### 4. Create the third repository

1. Click **Create repository**
2. Enter **Repository name**: `sdlf-workshop-teams`
3. Enter **Description**: `SDLF Team and dataset configurations`
4. Click **Create repository**

![Create teams repository](../../../static/images/3/3.5_CreateTeamRepo.png?width=90pc)

### 5. Verify created repositories

1. In the repositories list, confirm that there are 3 repositories:
   - `sdlf-workshop-foundations`
   - `sdlf-workshop-pipelines`
   - `sdlf-workshop-teams`

![Repositories list](../../../static/images/3/3.6_RepositoryList.png?width=90pc)

### 6. Prepare for the next step

- Note down the repository names
- Prepare code to push to the repositories
- Ensure you have access permissions to the repositories

{{% notice note %}}
**Note**:

- Repository names must be unique within the region
- You can add tags for management
- Delete repositories when no longer needed
{{% /notice %}}