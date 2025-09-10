---
title: "Test Pipeline"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>3.4 </b>"
---

## Test CI/CD Pipeline

In this step, you will test the pipeline to ensure the CI/CD process works correctly.

### 1. Access CodePipeline
1. Log in to the AWS Console
2. Search for **CodePipeline** in the service search bar
3. Click **CodePipeline**

![Open CodePipeline](../../../static/images/3/3.21_OpenCodePipeline.png?width=90pc)

### 2. Select a pipeline to test
1. Select the pipeline `sdlf-workshop-foundations-pipeline`
2. Check the current status

![Select Pipeline](../../../static/images/3/3.22_SelectPipeline.png?width=90pc)

### 3. Trigger the pipeline manually
1. Click **Release change**
2. Confirm to trigger the pipeline
3. Monitor the progress

![Trigger Pipeline](../../../static/images/3/3.23_TriggerPipeline.png?width=90pc)

### 4. Monitor the Source stage
1. Check that the Source stage turns green
2. Confirm that code is pulled from the repository
3. Check the commit message and author

![Source Stage](../../../static/images/3/3.24_SourceStage.png?width=90pc)

### 5. Monitor the Build stage
1. Check that the Build stage starts
2. Click on the build to view logs
3. Ensure the build is successful

![Build Stage](../../../static/images/3/3.25_BuildStage.png?width=90pc)

### 6. Monitor the Deploy stage
1. Check that the Deploy stage starts
2. Monitor CloudFormation stack creation
3. Ensure deployment is successful

![Deploy Stage](../../../static/images/3/3.26_DeployStage.png?width=90pc)

### 7. Verify the results
1. Go to the **CloudFormation Console**
2. Check that the stack is created/updated
3. Confirm that resources are created correctly

![Check CloudFormation](../../../static/images/3/3.27_CheckCloudFormation.png?width=90pc)

### 8. Test the second pipeline
1. Select the pipeline `sdlf-workshop-pipelines-pipeline`
2. Repeat steps 3-7

### 9. Test the third pipeline
1. Select the pipeline `sdlf-workshop-teams-pipeline`
2. Repeat steps 3-7

### 10. Check logs and troubleshooting
1. If the pipeline failed, click on the stage to view logs
2. Check error messages
3. Fix errors and trigger again

![Troubleshooting](../../../static/images/3/3.28_Troubleshooting.png?width=90pc)

### 11. Verify automation
1. Push code changes to the repository
2. Check that the pipeline is automatically triggered
3. Confirm end-to-end automation

{{% notice note %}}
**Note**:
- The pipeline will automatically trigger when there are code changes
- Check CloudWatch logs if there are errors
- Ensure service roles have sufficient permissions
{{% /notice %}} 