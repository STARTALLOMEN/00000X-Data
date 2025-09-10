---
title: "Configure CodeBuild Projects"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>3.2 </b>"
---

## Configure CodeBuild Projects

In this step, you will create CodeBuild projects to build and test code from the CodeCommit repositories.

### 1. Access CodeBuild
1. Log in to the AWS Console
2. Search for **CodeBuild** in the service search bar
3. Click **CodeBuild**

![Open CodeBuild](../../../static/images/3/3.7_OpenCodeBuild.png?width=90pc)

### 2. Create the first Build Project
1. Click **Create build project**
2. Enter **Project name**: `sdlf-workshop-foundations-build`
3. Enter **Description**: `Build project for SDLF foundations`

![Create build project](../../../static/images/3/3.8_CreateBuildProject.png?width=90pc)

### 3. Configure Source
1. In the **Source** section, select:
   - **Source provider**: AWS CodeCommit
   - **Repository**: `sdlf-workshop-foundations`
   - **Branch**: `main`
2. Click **Next**

![Configure Source](../../../static/images/3/3.9_ConfigureSource.png?width=90pc)

### 4. Configure Environment
1. In the **Environment** section:
   - **Environment image**: Managed image
   - **Operating system**: Ubuntu
   - **Runtime**: Standard
   - **Image**: aws/codebuild/standard:5.0
   - **Service role**: Create a service role in your account
2. Click **Next**

![Configure Environment](../../../static/images/3/3.10_ConfigureEnvironment.png?width=90pc)

### 5. Configure Buildspec
1. In the **Buildspec** section:
   - Select **Use a buildspec file**
   - **Buildspec name**: `buildspec.yml`
2. Click **Next**

![Configure Buildspec](../../../static/images/3/3.11_ConfigureBuildspec.png?width=90pc)

### 6. Configure Artifacts
1. In the **Artifacts** section:
   - **Type**: Amazon S3
   - **Bucket name**: Select the artifacts bucket from SDLF foundations
   - **Name**: `foundations-artifacts`
2. Click **Next**

![Configure Artifacts](../../../static/images/3/3.12_ConfigureArtifacts.png?width=90pc)

### 7. Create Project
1. Review the configuration
2. Click **Create build project**

### 8. Create the second Build Project
1. Click **Create build project** again
2. Enter **Project name**: `sdlf-workshop-pipelines-build`
3. Repeat steps 3-7 with the repository `sdlf-workshop-pipelines`

### 9. Create the third Build Project
1. Click **Create build project**
2. Enter **Project name**: `sdlf-workshop-teams-build`
3. Repeat steps 3-7 with the repository `sdlf-workshop-teams`

### 10. Verify Build Projects
1. In the projects list, confirm that there are 3 projects:
   - `sdlf-workshop-foundations-build`
   - `sdlf-workshop-pipelines-build`
   - `sdlf-workshop-teams-build`

![Build Projects list](../../../static/images/3/3.13_BuildProjectList.png?width=90pc)

### 11. Test Build Project
1. Select a project
2. Click **Start build**
3. Check the build logs to ensure it works correctly

{{% notice note %}}
**Note**:
- Make sure the S3 artifacts bucket has access permissions
- The service role needs access to S3 and CloudWatch Logs
- The buildspec file should be created in the repository
{{% /notice %}} 