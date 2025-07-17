---
title: "Deploy ETL Pipeline"
date: 2024-01-01
weight: 50
chapter: false
pre: "<b>5. </b>"
---

## ETL Pipeline Overview

ETL Pipeline is the data processing and transformation component in SDLF. This pipeline will use AWS Glue to extract, transform and load data.

### ETL Pipeline Architecture

![ETL Pipeline Architecture](../../../static/images/5/0.png?width=40pc)

### Key Components:

1. **Glue Jobs**: Process and transform data
2. **Step Functions**: Orchestrate workflow
3. **EventBridge**: Trigger events
4. **S3 Buckets**: Store raw, processed, curated data
5. **Glue Data Catalog**: Metadata management

### Deployment Process:

1. **Create Glue Jobs**: Set up data processing jobs
2. **Configure Step Functions**: Create workflow orchestration
3. **Setup EventBridge**: Configure triggers
4. **Test Pipeline**: Check operation

### Estimated Time: 60-90 minutes

{{% notice note %}}
Make sure you have completed the Team and Dataset section before starting this section.
{{% /notice %}} 