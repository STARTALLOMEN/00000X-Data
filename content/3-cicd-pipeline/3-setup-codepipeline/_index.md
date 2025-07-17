---
title: "3.3 Thiết lập CodePipeline"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>3.3 </b>"
---

## Thiết lập CodePipeline

Trong bước này, bạn sẽ tạo CodePipeline để tự động hóa quy trình build và deploy.

### 1. Truy cập CodePipeline
1. Đăng nhập AWS Console
2. Tìm kiếm **CodePipeline** trong thanh tìm kiếm dịch vụ
3. Click **CodePipeline**

![Mở CodePipeline](../../../static/images/3/3.14_OpenCodePipeline.png?width=90pc)

### 2. Tạo Pipeline đầu tiên
1. Click **Create pipeline**
2. Nhập **Pipeline name**: `sdlf-workshop-foundations-pipeline`
3. Click **Next**

![Tạo pipeline](../../../static/images/3/3.15_CreatePipeline.png?width=90pc)

### 3. Cấu hình Source stage
1. Ở mục **Source**:
   - **Source provider**: AWS CodeCommit
   - **Repository name**: `sdlf-workshop-foundations`
   - **Branch name**: `main`
   - **Change detection options**: CloudWatch Events
2. Click **Next**

![Cấu hình Source stage](../../../static/images/3/3.16_ConfigureSourceStage.png?width=90pc)

### 4. Cấu hình Build stage
1. Ở mục **Build**:
   - **Build provider**: AWS CodeBuild
   - **Region**: Chọn region hiện tại
   - **Project name**: `sdlf-workshop-foundations-build`
2. Click **Next**

![Cấu hình Build stage](../../../static/images/3/3.17_ConfigureBuildStage.png?width=90pc)

### 5. Cấu hình Deploy stage
1. Ở mục **Deploy**:
   - **Deploy provider**: AWS CloudFormation
   - **Region**: Chọn region hiện tại
   - **Action mode**: Create or update a stack
   - **Stack name**: `sdlf-workshop-foundations-stack`
   - **Template file**: `template.yml`
   - **Parameter file**: `parameters.json`
2. Click **Next**

![Cấu hình Deploy stage](../../../static/images/3/3.18_ConfigureDeployStage.png?width=90pc)

### 6. Cấu hình Service role
1. Ở mục **Service role**:
   - Chọn **Create a service role**
   - **Role name**: `sdlf-workshop-pipeline-role`
2. Click **Next**

![Cấu hình Service role](../../../static/images/3/3.19_ConfigureServiceRole.png?width=90pc)

### 7. Tạo Pipeline
1. Kiểm tra lại cấu hình
2. Click **Create pipeline**

### 8. Tạo Pipeline thứ hai
1. Click **Create pipeline** (lần nữa)
2. Nhập **Pipeline name**: `sdlf-workshop-pipelines-pipeline`
3. Lặp lại các bước 3-7 với repository và build project tương ứng

### 9. Tạo Pipeline thứ ba
1. Click **Create pipeline**
2. Nhập **Pipeline name**: `sdlf-workshop-teams-pipeline`
3. Lặp lại các bước 3-7 với repository và build project tương ứng

### 10. Kiểm tra Pipelines
1. Trong danh sách pipelines, xác nhận có 3 pipelines:
   - `sdlf-workshop-foundations-pipeline`
   - `sdlf-workshop-pipelines-pipeline`
   - `sdlf-workshop-teams-pipeline`

![Danh sách Pipelines](../../../static/images/3/3.20_PipelineList.png?width=90pc)

### 11. Test Pipeline
1. Chọn một pipeline
2. Click **Release change** để trigger pipeline
3. Theo dõi tiến trình qua các stages

{{% notice note %}}
**Lưu ý**:
- Đảm bảo CloudFormation templates có sẵn trong repository
- Service role cần có quyền truy cập đầy đủ
- Pipeline sẽ tự động trigger khi có code changes
{{% /notice %}} 