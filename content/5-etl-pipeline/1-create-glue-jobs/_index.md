---
title: "Create Glue Jobs"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>5.1 </b>"
---

## Create Glue Jobs

In this section, you will create AWS Glue jobs to process and transform your data as part of the ETL pipeline.

### Steps

#### Step 1: Open the AWS Glue Console

1. Go to the AWS Management Console
2. Search for "Glue" and select AWS Glue
3. In the left menu, click on "Jobs"

#### Step 2: Create a new Glue job

1. Click "Add job"
2. Enter the job name (e.g., `team-a-dataset-a-stage-a`)
3. Select the IAM role created for SDLF
4. Choose the type of job (Spark or Python Shell)
5. Specify the script location and S3 paths for input/output
6. Configure other settings as needed
7. Click "Save job"

#### Step 3: Run and monitor the job

1. Select the job and click "Run job"
2. Monitor the job status in the Glue console
3. Check logs for errors or output

{{% notice tip %}}
You can reuse Glue job scripts for different datasets by parameterizing the input and output locations.
{{% /notice %}}

### Troubleshooting

**Issue**: Job fails to start
**Solution**: Check IAM permissions and ensure the S3 paths are correct.

**Issue**: Script errors
**Solution**: Review the logs in CloudWatch for error messages and fix any issues in the script.

### Summary

In this section, you have:
1. Opened the AWS Glue console
2. Created a new Glue job
3. Ran and monitored the job

Next, you will [Set up Step Functions](../2-setup-step-functions) for workflow orchestration. 