---
title: "Log in to AWS Management Console"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>1.1 </b>"
---

## Log in to AWS Management Console

The first step is to log in to the AWS Management Console to begin the workshop.

### Implementation Steps

#### Step 1: Open a web browser

1. Open your web browser (Chrome, Firefox, Safari, or Edge)
2. Enter the address: [https://console.aws.amazon.com](https://console.aws.amazon.com)

![Open web browser](../../../static/images/1/1/1.1.1_open_browser.png?width=40pc)

#### Step 2: Enter login information

1. If you have an AWS account:
   - Enter your email address or AWS account ID
   - Click the **Next** button
   - Enter your password
   - Click the **Sign in** button

2. If you are an IAM user:
   - Enter the AWS account ID or alias
   - Click the **Next** button
   - Enter your IAM username
   - Enter your password
   - Click the **Sign in** button

![Enter login information](../../../static/images/1/1/1.1.2_login_screen.png?width=40pc)

#### Step 3: Verify successful login

After successfully logging in, you will see:
- The AWS Management Console displayed with AWS services
- Your account name in the top right corner
- The current region in the top right corner

![AWS Management Console](../../../static/images/1/1/1.1.3_aws_console.png?width=40pc)

### Troubleshooting

**Issue**: Cannot log in to AWS Console
**Solution**: 
1. Check your email/account ID and password
2. Use the "Forgot password" option if needed
3. Contact your AWS administrator if you still have issues

**Issue**: Message "You do not have permission to access this page"
**Solution**:
1. Make sure you are using an account with AdministratorAccess permissions
2. Check your IAM permissions
3. Contact your AWS administrator for additional permissions

{{% notice note %}}
If you are using AWS Organizations, you may need to select the correct account or role before proceeding.
{{% /notice %}}

## Next Step

Next, we will [Open AWS CloudShell](../2-cloudshell) to execute AWS CLI commands.