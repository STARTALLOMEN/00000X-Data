---
title: "Set Up CodePipeline"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>3.3 </b>"
---

## Set Up CodePipeline

In this step, you will create CodePipeline pipelines to automate the build and deployment process.

### 1. Access CodePipeline
1. Log in to the AWS Console
2. Search for **CodePipeline** in the service search bar
3. Click **CodePipeline**

![Open CodePipeline](../../../static/images/3/3.14_OpenCodePipeline.png?width=90pc)

### 2. Create the first pipeline
1. Click **Create pipeline**
2. Enter **Pipeline name**: `sdlf-workshop-foundations-pipeline`
3. Click **Next**

![Create pipeline](../../../static/images/3/3.15_CreatePipeline.png?width=90pc)

### 3. Configure Source stage
1. In the **Source** section:
   - **Source provider**: AWS CodeCommit
   - **Repository name**: `sdlf-workshop-foundations`
   - **Branch name**: `main`
   - **Change detection options**: CloudWatch Events
2. Click **Next**

![Configure Source stage](../../../static/images/3/3.16_ConfigureSourceStage.png?width=90pc)

### 4. Configure Build stage
1. In the **Build** section:
   - **Build provider**: AWS CodeBuild
   - **Region**: Select your current region
   - **Project name**: `sdlf-workshop-foundations-build`
2. Click **Next**

![Configure Build stage](../../../static/images/3/3.17_ConfigureBuildStage.png?width=90pc)

### 5. Configure Deploy stage
1. In the **Deploy** section:
   - **Deploy provider**: AWS CloudFormation
   - **Region**: Select your current region
   - **Action mode**: Create or update a stack
   - **Stack name**: `sdlf-workshop-foundations-stack`
   - **Template file**: `template.yml`
   - **Parameter file**: `parameters.json`
2. Click **Next**

![Configure Deploy stage](../../../static/images/3/3.18_ConfigureDeployStage.png?width=90pc)

### 6. Configure Service role
1. In the **Service role** section:
   - Select **Create a service role**
   - **Role name**: `sdlf-workshop-pipeline-role`
2. Click **Next**

![Configure Service role](../../../static/images/3/3.19_ConfigureServiceRole.png?width=90pc)

### 7. Create Pipeline
1. Review the configuration
2. Click **Create pipeline**

### 8. Create the second pipeline
1. Click **Create pipeline** again
2. Enter **Pipeline name**: `sdlf-workshop-pipelines-pipeline`
3. Repeat steps 3-7 with the corresponding repository and build project

### 9. Create the third pipeline
1. Click **Create pipeline**
2. Enter **Pipeline name**: `sdlf-workshop-teams-pipeline`
3. Repeat steps 3-7 with the corresponding repository and build project

### 10. Verify Pipelines
1. In the pipelines list, confirm that there are 3 pipelines:
   - `sdlf-workshop-foundations-pipeline`
   - `sdlf-workshop-pipelines-pipeline`
   - `sdlf-workshop-teams-pipeline`

![Pipelines list](../../../static/images/3/3.20_PipelineList.png?width=90pc)

### 11. Test Pipeline
1. Select a pipeline
2. Click **Release change** to trigger the pipeline
3. Monitor the progress through the stages

{{% notice note %}}
**Note**:
- Make sure CloudFormation templates are available in the repository
- The service role needs full access permissions
- The pipeline will automatically trigger when there are code changes
{{% /notice %}} 