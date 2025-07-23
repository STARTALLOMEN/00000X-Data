---
title: "Upload Data"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>6.2 </b>"
---

## Upload Data

After preparing sample data, you will upload it to the data lake to trigger the ETL pipeline. This is a crucial step where raw data enters the system and begins the transformation process.

### Data Ingestion and ETL Process

When data is uploaded to the S3 bucket in the `/raw` folder, the following events occur:

1. **EventBridge** detects the S3 PutObject event and triggers the Step Functions state machine
2. **Step Functions** orchestrates the ETL process through several stages:
   - Checks file metadata
   - Runs Glue job Stage A for initial processing
   - Stores processed data in the `/stage` folder
   - Runs Glue job Stage B for further processing
   - Stores processed data in the `/analytics` folder
   - Updates metadata and catalog

In this section, you will upload data and monitor the entire process.

### Steps

#### Step 1: Get the Data Lake bucket name

1. Open AWS CloudShell (if not already open)
2. In CloudShell, run the following command to get the Data Lake bucket name and save it to an environment variable:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

3. Press Enter to execute the command

#### Step 2: Upload the sample data

1. Use the AWS CLI to upload the sample data files:

```bash
aws s3 cp legislators.jsonl s3://$DATA_LAKE_BUCKET/raw/
aws s3 cp transactions.jsonl s3://$DATA_LAKE_BUCKET/raw/
```

2. Press Enter to upload the files

#### Step 3: Monitor the ETL process

1. Go to the Step Functions console in AWS
2. Monitor the execution of the ETL workflow
3. Check the output in the `/stage` and `/analytics` folders in the S3 bucket

{{% notice tip %}}
The ETL pipeline is triggered automatically when new data is uploaded to the S3 bucket.
{{% /notice %}}

### Troubleshooting

**Issue**: Upload fails
**Solution**: Check the bucket name and your AWS CLI configuration.

**Issue**: ETL process does not start
**Solution**: Ensure the EventBridge rule and Step Functions state machine are configured correctly.

### Summary

In this section, you have:
1. Retrieved the Data Lake bucket name
2. Uploaded sample data to S3
3. Monitored the ETL process

You are now ready to proceed to the next section of the workshop. 