---
title: "Open AWS CloudShell"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>1.2 </b>"
---

## Open AWS CloudShell

AWS CloudShell is a browser-based shell with pre-installed AWS CLI tools, allowing you to execute AWS commands without installing additional tools on your personal computer.

### Implementation Steps

#### Step 1: Find the CloudShell icon

1. In the AWS Management Console, look at the navigation bar at the top
2. Find the CloudShell icon (terminal icon) in the top right corner, next to your account name
3. Click on the CloudShell icon

![Find CloudShell icon](../../../static/images/1/2/1.2.1_find_cloudshell.png?width=40pc)

#### Step 2: Wait for CloudShell to start

1. A new window will open at the bottom of the screen
2. Wait for CloudShell to start (this may take a few seconds)
3. You will see a welcome message and a command prompt

![CloudShell starting](../../../static/images/1/2/1.2.2_cloudshell_starting.png?width=40pc)

#### Step 3: Check AWS CLI

1. When CloudShell is ready, enter the following command to check the AWS CLI version:

```bash
aws --version
```

2. Press Enter to execute the command

![Check AWS CLI version](../../../static/images/1/2/1.2.3_check_aws_cli.png?width=40pc)

3. You will see the result displaying the AWS CLI version, for example:

```
aws-cli/2.13.5 Python/3.11.6 Linux/4.14.326-250.539.amzn2.x86_64 exe/x86_64.amzn.2
```

#### Step 4: Check access permissions

1. Enter the following command to confirm you have the necessary access permissions:

```bash
aws sts get-caller-identity
```

2. Press Enter to execute the command

![Check access permissions](../../../static/images/1/2/1.2.4_check_permissions.png?width=40pc)

3. You will see the result displaying information about your AWS account, for example:

```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/your-username"
}
```

### Useful CloudShell Features

1. **Upload and download files**:
   - Click on the "Actions" icon (three dots) in the top right corner of CloudShell
   - Select "Upload" to upload a file or "Download" to download a file

2. **Resize the window**:
   - Click on the "Resize" icon (two arrows) to change the size of the CloudShell window
   - You can select "Full screen" to expand to full screen

3. **Open a new tab**:
   - Click on the "New tab" icon (+ sign) to open a new CloudShell tab

![CloudShell features](../../../static/images/1/2/1.2.5_cloudshell_features.png?width=40pc)

### Troubleshooting

**Issue**: CloudShell does not start
**Solution**:
1. Refresh the web page
2. Make sure you have access to the CloudShell service
3. Try logging out and logging back in

**Issue**: AWS CLI command returns "Access Denied" error
**Solution**:
1. Check your IAM permissions
2. Make sure you are using an account with AdministratorAccess permissions
3. Check the current region

{{% notice note %}}
CloudShell is available in most AWS regions, but not all. If you don't see the CloudShell icon, try switching to a different region.
{{% /notice %}}

{{% notice tip %}}
CloudShell stores your files in a home directory with 1GB of storage. This data is retained between sessions but may be deleted after a period of inactivity.
{{% /notice %}}

## Next Step

Next, we will [Select the appropriate region](../3-region-selection) for the workshop.