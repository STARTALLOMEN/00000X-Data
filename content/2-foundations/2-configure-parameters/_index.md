---
title: "Configure Parameters"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>2.2 </b>"
---

## Configure Parameters

After cloning the SDLF repository, you need to configure deployment parameters. This section will guide you through editing the parameter files required for the deployment.

### Steps

#### Step 1: Locate the parameter file

1. In the cloned repository, navigate to the parameters directory:

```bash
cd aws-serverless-data-lake-framework/deployment/parameters
```

2. List the files:

```bash
ls -la
```

#### Step 2: Edit the parameters

1. Open the parameter file (e.g., `parameters.json`) with a text editor:

```bash
nano parameters.json
```

2. Update the values as needed (e.g., bucket names, region, team name, etc.)
3. Save and exit the editor (Ctrl+X, then Y, then Enter)

#### Step 3: Verify the parameters

1. Print the file contents to verify:

```bash
cat parameters.json
```

2. Ensure all required fields are filled in correctly

{{% notice tip %}}
Use meaningful names for buckets and resources to avoid conflicts in your AWS account.
{{% /notice %}}

### Troubleshooting

**Issue**: Permission denied when editing
**Solution**: Make sure you have write permissions in the directory.

**Issue**: Syntax error in JSON
**Solution**: Use a JSON validator to check your file before saving.

### Summary

In this section, you have:
1. Located the parameter file
2. Edited and saved deployment parameters
3. Verified the parameter file

Next, you will [Deploy CloudFormation](../3-deploy-cloudformation) to set up the infrastructure. 