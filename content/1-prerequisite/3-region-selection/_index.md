---
title: "Select the appropriate region"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>1.3 </b>"
---

## Select the appropriate region

Selecting the right AWS region is important to ensure all necessary services are available and to optimize performance and costs.

### Implementation Steps

#### Step 1: Identify the current region

1. Look at the top right corner of the AWS Management Console
2. You will see the current region displayed (e.g., "N. Virginia" or "us-east-1")

![Identify current region](../../../static/images/1/3/1.3.1_current_region.png?width=40pc)

#### Step 2: Change the region (if needed)

1. Click on the dropdown menu displaying the current region
2. A list of regions will appear
3. Select one of the recommended regions:
   - **US East (N. Virginia)** - us-east-1
   - **US West (Oregon)** - us-west-2
   - **Europe (Ireland)** - eu-west-1
   - **Asia Pacific (Singapore)** - ap-southeast-1

![Change region](../../../static/images/1/3/1.3.2_change_region.png?width=40pc)

#### Step 3: Confirm the region in CloudShell

1. In CloudShell, enter the following command to confirm the current region:

```bash
aws configure get region
```

2. Press Enter to execute the command

![Confirm region in CloudShell](../../../static/images/1/3/1.3.3_verify_region.png?width=40pc)

3. The result will display the current region, for example:

```
us-east-1
```

#### Step 4: Set the default region (if needed)

1. If the displayed region is not the one you want to use, set the default region with the command:

```bash
aws configure set region us-east-1
```

2. Replace `us-east-1` with the region you want to use
3. Press Enter to execute the command

![Set default region](../../../static/images/1/3/1.3.4_set_default_region.png?width=40pc)

4. Verify that the region has been set:

```bash
aws configure get region
```

### Recommended Regions

| Region Name | Region Code | Location |
|------------|-----------|--------|
| US East (N. Virginia) | us-east-1 | North Virginia, USA |
| US West (Oregon) | us-west-2 | Oregon, USA |
| Europe (Ireland) | eu-west-1 | Ireland |
| Asia Pacific (Singapore) | ap-southeast-1 | Singapore |

### Troubleshooting

**Issue**: Region does not change in CloudShell after changing in Console
**Solution**:
1. Close and reopen CloudShell
2. Use the `aws configure set region` command as instructed above

**Issue**: Some services are not available in the selected region
**Solution**:
1. Switch to another recommended region
2. Prioritize using us-east-1 (N. Virginia) as it has the most complete set of AWS services

{{% notice warning %}}
Make sure you use the same region throughout the entire workshop. Changing regions midway can cause errors and increase costs due to cross-region data transfer.
{{% /notice %}}

{{% notice tip %}}
If you are in the Asia-Pacific region, consider using ap-southeast-1 (Singapore) to reduce latency. However, make sure all necessary services are available in this region.
{{% /notice %}}

## Next Step

Now that you have completed the preparation steps, we will continue with [Deploying SDLF Foundations](../../2-foundations) to start building the data lake.