---
title: "Deploy CloudFormation"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>2.3 </b>"
---

## Deploy CloudFormation

In this section, you will deploy the SDLF infrastructure using AWS CloudFormation. This will provision all the necessary resources for your data lake.

### Steps

#### Step 1: Open AWS CloudShell

1. Open AWS Management Console
2. Click the CloudShell icon in the top navigation bar
3. Wait for CloudShell to initialize

#### Step 2: Deploy the CloudFormation stack

1. In CloudShell, navigate to the deployment directory:

```bash
cd aws-serverless-data-lake-framework/deployment
```

2. Run the deployment script:

```bash
./deploy.sh
```

3. Wait for the deployment to complete (this may take 15-20 minutes)

#### Step 3: Verify the deployment

1. In the AWS Console, go to the CloudFormation service
2. Check that the stack status is `CREATE_COMPLETE`
3. Review the resources created by the stack

{{% notice tip %}}
You can monitor the deployment progress in the CloudFormation console.
{{% /notice %}}

### Troubleshooting

**Issue**: Stack creation failed
**Solution**: Check the Events tab in CloudFormation for error messages and resolve any issues (e.g., missing permissions, invalid parameters).

**Issue**: Script not executable
**Solution**: Run `chmod +x deploy.sh` to make the script executable.

### Summary

In this section, you have:
1. Opened AWS CloudShell
2. Deployed the SDLF CloudFormation stack
3. Verified the deployment

Next, you will [Verify the deployment](../4-verify-deployment) to ensure everything is set up correctly. 