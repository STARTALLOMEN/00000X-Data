---
title: "Configure Permissions"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>4.3 </b>"
---

## Configure Permissions

After creating a dataset, you need to configure access permissions so your team can use and manage the data securely.

### Steps

#### Step 1: Open the SDLF Console or use AWS CLI

1. Go to the SDLF management console (if available) or use AWS CLI
2. Navigate to the Permissions section

#### Step 2: Set permissions for your team

1. Click "Add Permission" or use the CLI command:

```bash
aws sdlf grant-permission --team-name <your-team-name> --dataset-name <your-dataset-name> --permission <read|write|admin>
```

2. Select the appropriate permission level (read, write, admin)
3. Confirm and apply the permissions

#### Step 3: Verify permissions

1. List permissions for your dataset:

```bash
aws sdlf list-permissions --team-name <your-team-name> --dataset-name <your-dataset-name>
```

2. Check the permissions in the console or CLI output

{{% notice tip %}}
Grant only the permissions necessary for each user or group to follow the principle of least privilege.
{{% /notice %}}

### Troubleshooting

**Issue**: Permission grant failed
**Solution**: Check IAM permissions and ensure you have the required access.

**Issue**: Permissions not updated
**Solution**: Refresh the console or re-run the CLI command.

### Summary

In this section, you have:
1. Opened the SDLF console or AWS CLI
2. Configured permissions for your dataset
3. Verified the permissions

You are now ready to proceed to the next section of the workshop. 