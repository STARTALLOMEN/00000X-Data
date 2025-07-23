---
title: "Clone the SDLF Repository"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>2.1 </b>"
---

## Clone the SDLF Repository

The first step in deploying SDLF is to clone the official repository to your working environment. In this section, you will use AWS CloudShell to clone the repository.

### Steps

#### Step 1: Open AWS CloudShell

1. Open AWS Management Console
2. Click the CloudShell icon in the top navigation bar
3. Wait for CloudShell to initialize

#### Step 2: Clone the repository

1. In CloudShell, run the following command:

```bash
git clone https://github.com/awslabs/aws-serverless-data-lake-framework.git
cd aws-serverless-data-lake-framework
```

2. Press Enter to execute the command

#### Step 3: Verify the repository

1. List the contents of the directory:

```bash
ls -la
```

2. You should see the repository files and folders

{{% notice tip %}}
You can use CloudShell to run AWS CLI commands without installing anything on your local machine.
{{% /notice %}}

### Troubleshooting

**Issue**: Permission denied when cloning
**Solution**: Make sure you have the correct permissions in your AWS account.

**Issue**: Git not found
**Solution**: CloudShell comes with Git pre-installed. If you encounter this error, try restarting CloudShell.

### Summary

In this section, you have:
1. Opened AWS CloudShell
2. Cloned the SDLF repository
3. Verified the repository contents

Next, you will [Configure parameters](../2-configure-parameters) for the deployment. 