---
title: "Verify Deployment"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>2.4 </b>"
---

## Verify Deployment

After deploying the SDLF infrastructure, you should verify that all resources have been created successfully.

### Steps

#### Step 1: Check CloudFormation stack status

1. In the AWS Console, go to the CloudFormation service
2. Select the SDLF stack
3. Ensure the status is `CREATE_COMPLETE`

#### Step 2: Review created resources

1. In the CloudFormation stack details, review the list of created resources (S3 buckets, IAM roles, Glue catalog, etc.)
2. Confirm that all expected resources are present

#### Step 3: Test access to S3 bucket

1. Go to the S3 service in the AWS Console
2. Find the data lake bucket created by the stack
3. Verify you can access the bucket and see the expected folders

{{% notice tip %}}
If any resources are missing, check the CloudFormation Events tab for errors and resolve them before proceeding.
{{% /notice %}}

### Troubleshooting

**Issue**: Stack status is not `CREATE_COMPLETE`
**Solution**: Review the Events tab for error messages and fix any issues (e.g., permissions, parameter values).

**Issue**: Cannot access S3 bucket
**Solution**: Check IAM permissions and bucket policy.

### Summary

In this section, you have:
1. Checked the CloudFormation stack status
2. Reviewed the created resources
3. Tested access to the S3 bucket

You are now ready to proceed to the next section of the workshop. 