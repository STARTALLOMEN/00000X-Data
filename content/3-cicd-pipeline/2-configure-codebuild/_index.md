---
title: "3.2 Cấu hình CodeBuild Projects"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>3.2 </b>"
---

## Cấu hình CodeBuild Projects

Trong bước này, bạn sẽ tạo các CodeBuild projects để build và test code từ CodeCommit repositories.

### 1. Truy cập CodeBuild
1. Đăng nhập AWS Console
2. Tìm kiếm **CodeBuild** trong thanh tìm kiếm dịch vụ
3. Click **CodeBuild**

![Mở CodeBuild](../../../static/images/3/3.7_OpenCodeBuild.png?width=90pc)

### 2. Tạo Build Project đầu tiên
1. Click **Create build project**
2. Nhập **Project name**: `sdlf-workshop-foundations-build`
3. Nhập **Description**: `Build project for SDLF foundations`

![Tạo build project](../../../static/images/3/3.8_CreateBuildProject.png?width=90pc)

### 3. Cấu hình Source
1. Ở mục **Source**, chọn:
   - **Source provider**: AWS CodeCommit
   - **Repository**: `sdlf-workshop-foundations`
   - **Branch**: `main`
2. Click **Next**

![Cấu hình Source](../../../static/images/3/3.9_ConfigureSource.png?width=90pc)

### 4. Cấu hình Environment
1. Ở mục **Environment**:
   - **Environment image**: Managed image
   - **Operating system**: Ubuntu
   - **Runtime**: Standard
   - **Image**: aws/codebuild/standard:5.0
   - **Service role**: Create a service role in your account
2. Click **Next**

![Cấu hình Environment](../../../static/images/3/3.10_ConfigureEnvironment.png?width=90pc)

### 5. Cấu hình Buildspec
1. Ở mục **Buildspec**:
   - Chọn **Use a buildspec file**
   - **Buildspec name**: `buildspec.yml`
2. Click **Next**

![Cấu hình Buildspec](../../../static/images/3/3.11_ConfigureBuildspec.png?width=90pc)

### 6. Cấu hình Artifacts
1. Ở mục **Artifacts**:
   - **Type**: Amazon S3
   - **Bucket name**: Chọn bucket artifacts từ SDLF foundations
   - **Name**: `foundations-artifacts`
2. Click **Next**

![Cấu hình Artifacts](../../../static/images/3/3.12_ConfigureArtifacts.png?width=90pc)

### 7. Tạo Project
1. Kiểm tra lại cấu hình
2. Click **Create build project**

### 8. Tạo Build Project thứ hai
1. Click **Create build project** (lần nữa)
2. Nhập **Project name**: `sdlf-workshop-pipelines-build`
3. Lặp lại các bước 3-7 với repository `sdlf-workshop-pipelines`

### 9. Tạo Build Project thứ ba
1. Click **Create build project**
2. Nhập **Project name**: `sdlf-workshop-teams-build`
3. Lặp lại các bước 3-7 với repository `sdlf-workshop-teams`

### 10. Kiểm tra Build Projects
1. Trong danh sách projects, xác nhận có 3 projects:
   - `sdlf-workshop-foundations-build`
   - `sdlf-workshop-pipelines-build`
   - `sdlf-workshop-teams-build`

![Danh sách Build Projects](../../../static/images/3/3.13_BuildProjectList.png?width=90pc)

### 11. Test Build Project
1. Chọn một project
2. Click **Start build**
3. Kiểm tra build logs để đảm bảo hoạt động đúng

{{% notice note %}}
**Lưu ý**:
- Đảm bảo S3 bucket artifacts có quyền truy cập
- Service role cần có quyền truy cập S3, CloudWatch Logs
- Buildspec file sẽ được tạo trong repository
{{% /notice %}} 