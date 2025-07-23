---
title: "Configure EventBridge"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>5.3 </b>"
---

## Configure EventBridge

In this section, you will configure Amazon EventBridge to trigger your ETL workflow automatically when new data is ingested.

### Steps

#### Step 1: Open the EventBridge Console

1. Go to the AWS Management Console
2. Search for "EventBridge" and select the service
3. Click "Rules" in the left menu

#### Step 2: Create a new rule

1. Click "Create rule"
2. Enter a rule name (e.g., `SDLF-Pipeline-Notifications`)
3. Set the event pattern to match S3 PutObject or Step Functions execution events
4. Set the target to your Step Functions state machine or SNS topic
5. Click "Create rule"

#### Step 3: Test the rule

1. Upload a file to the S3 bucket or trigger a Step Functions execution
2. Verify that the rule triggers the workflow as expected

{{% notice tip %}}
You can use EventBridge to automate notifications and error handling for your data pipeline.
{{% /notice %}}

### Troubleshooting

**Issue**: Rule does not trigger
**Solution**: Check the event pattern and ensure the target is configured correctly.

**Issue**: Permissions error
**Solution**: Ensure EventBridge has permission to invoke the target resource.

### Summary

In this section, you have:
1. Opened the EventBridge console
2. Created a new rule
3. Tested the rule

You are now ready to proceed to the next section of the workshop. 