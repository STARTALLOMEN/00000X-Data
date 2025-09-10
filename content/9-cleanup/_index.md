---
title: "Clean Up Resources"
date: 2024-01-01
weight: 90
chapter: false
pre: "<b>9. </b>"
---

## Clean Up Resources

After completing the workshop, you should clean up all AWS resources to avoid unnecessary costs.

### 1. Delete data from S3 buckets
1. Go to the AWS Management Console and search for "S3"
2. Select **Amazon S3** from the search results
3. Find your data lake bucket (name starts with `sdlf-`)
4. Run the following command in CloudShell to delete all objects:

```bash
# Get the bucket name from CloudFormation outputs
DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Deleting all objects in bucket $DATA_LAKE_BUCKET"
aws s3 rm s3://$DATA_LAKE_BUCKET --recursive
```

5. Repeat for the artifact bucket if needed

### 2. Delete CloudWatch Dashboards and Alarms
1. Go to **CloudWatch** in the AWS Console
2. Delete the dashboard `SDLF-Monitoring-Dashboard`
3. Delete alarms with names starting with `SDLF-`

### 3. Delete SNS Topics
1. Go to **SNS** in the AWS Console
2. Delete the topic `SDLF-Alerts`

### 4. Delete EventBridge Rules
1. Go to **EventBridge** in the AWS Console
2. Delete the rule `SDLF-Pipeline-Notifications`

### 5. Delete CloudFormation Stacks
1. Go to **CloudFormation** in the AWS Console
2. Delete all stacks created for the workshop (names start with `sdlf-`)

### 6. Delete CodeCommit Repositories
1. Go to **CodeCommit** in the AWS Console
2. Delete repositories created for the workshop

### 7. Delete IAM Roles and Policies
1. Go to **IAM** in the AWS Console
2. Delete roles and policies created for the workshop (names contain `sdlf`)

### 8. Delete Glue Databases and Tables
1. Go to **Glue** in the AWS Console
2. Delete databases and tables created for the workshop

### 9. Delete Athena Workgroups
1. Go to **Athena** in the AWS Console
2. Delete the workgroup `analytics-team-workgroup`

### 10. Final check
- Make sure all resources created for the workshop are deleted
- Double-check S3 buckets, IAM roles, and CloudFormation stacks

{{% notice warning %}}
**Warning**: This cleanup will delete all resources related to SDLF. Make sure to back up any important data before proceeding.
{{% /notice %}}

## Congratulations!

You have completed the Serverless Data Lake Framework (SDLF) workshop. You now know how to:

1. Set up the foundational infrastructure for a serverless data lake
2. Deploy a CI/CD pipeline for code management
3. Register teams and datasets
4. Deploy an ETL pipeline
5. Ingest and process data
6. Query data with Athena
7. Set up monitoring and alerts
8. Clean up resources

The knowledge gained in this workshop can be applied to build serverless data lakes for your own projects. 