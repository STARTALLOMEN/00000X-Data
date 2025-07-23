---
title: "Register Team"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>4.1 </b>"
---

## Register Team

In this section, you will register a new team in SDLF. Teams are used to manage access and organize datasets in your data lake.

### Steps

#### Step 1: Open the SDLF Console or use AWS CLI

1. Go to the SDLF management console (if available) or use AWS CLI
2. Navigate to the Teams section

#### Step 2: Register a new team

1. Click "Create Team" or use the CLI command:

```bash
aws sdlf create-team --team-name <your-team-name>
```

2. Fill in the required information (team name, description, etc.)
3. Confirm and create the team

#### Step 3: Verify the team

1. List all teams to verify your new team appears:

```bash
aws sdlf list-teams
```

2. Check the team details in the console or CLI output

{{% notice tip %}}
Choose a meaningful team name to reflect your project or business unit.
{{% /notice %}}

### Troubleshooting

**Issue**: Team creation failed
**Solution**: Check IAM permissions and ensure you have the required access.

**Issue**: Team not visible
**Solution**: Refresh the console or re-run the CLI command.

### Summary

In this section, you have:
1. Opened the SDLF console or AWS CLI
2. Registered a new team
3. Verified the team was created

Next, you will [Create a dataset](../2-create-dataset) for your team. 