---
title: "Create Dataset"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>4.2 </b>"
---

## Create Dataset

After registering your team, you need to create a dataset for your team to manage and store data.

### Steps

#### Step 1: Open the SDLF Console or use AWS CLI

1. Go to the SDLF management console (if available) or use AWS CLI
2. Navigate to the Datasets section

#### Step 2: Create a new dataset

1. Click "Create Dataset" or use the CLI command:

```bash
aws sdlf create-dataset --team-name <your-team-name> --dataset-name <your-dataset-name>
```

2. Fill in the required information (dataset name, description, etc.)
3. Confirm and create the dataset

#### Step 3: Verify the dataset

1. List all datasets for your team:

```bash
aws sdlf list-datasets --team-name <your-team-name>
```

2. Check the dataset details in the console or CLI output

{{% notice tip %}}
Use descriptive names for datasets to make management easier.
{{% /notice %}}

### Troubleshooting

**Issue**: Dataset creation failed
**Solution**: Check IAM permissions and ensure you have the required access.

**Issue**: Dataset not visible
**Solution**: Refresh the console or re-run the CLI command.

### Summary

In this section, you have:
1. Opened the SDLF console or AWS CLI
2. Created a new dataset
3. Verified the dataset was created

Next, you will [Configure permissions](../3-configure-permissions) for your dataset. 