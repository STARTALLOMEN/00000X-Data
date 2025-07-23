---
title: "Prepare Sample Data"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>6.1 </b>"
---

## Prepare Sample Data

The first step in data ingestion is to prepare sample data to upload to the data lake. In this section, you will create two types of sample data:

1. **Legislators data**: Contains information about legislators, including ID, name, party, state, and term.
2. **Transactions data**: Contains information about transactions, including transaction ID, customer ID, amount, currency, transaction date, and category.

Both types of data will be stored in JSON Lines format, with each line being a valid JSON object.

### Steps

#### Step 1: Create a directory for sample data

1. Open AWS Management Console and search for "CloudShell"
2. Once CloudShell is ready, run the following commands to create a directory for sample data:

```bash
mkdir -p ~/environment/sample-data
cd ~/environment/sample-data
```

3. Press Enter to execute the commands

{{% notice tip %}}
CloudShell is a browser-based terminal managed by AWS, allowing you to run AWS CLI commands without installing any software on your computer.
{{% /notice %}}

#### Step 2: Create sample data for legislators

1. Use a text editor or script to create a file named `legislators.jsonl` with sample records
2. Each line should be a valid JSON object representing a legislator

#### Step 3: Create sample data for transactions

1. Use a text editor or script to create a file named `transactions.jsonl` with sample records
2. Each line should be a valid JSON object representing a transaction

#### Step 4: Verify the sample data

1. List the files in the directory:

```bash
ls -la
```

2. Print the contents of the files to verify:

```bash
cat legislators.jsonl
cat transactions.jsonl
```

#### (Optional) Create larger sample data with Python script

1. Create a Python script to generate more records if needed
2. Run the script and verify the output

### Troubleshooting

**Issue**: Error creating sample data file
**Solution**: Check directory permissions and available disk space.

**Issue**: Permission denied when running Python script
**Solution**: Add execute permission to the script:

```bash
chmod +x generate_data.py
```

{{% notice tip %}}
You can customize the sample data as needed. JSON Lines format is widely used in big data systems for efficient processing.
{{% /notice %}}

### Summary

In this section, you have:
1. Created a directory for sample data in CloudShell
2. Created sample data for legislators and transactions
3. Verified the created data
4. (Optional) Generated larger sample data with a script

Next, you will [Upload data](../2-upload-data) to the data lake to trigger the ETL pipeline. 