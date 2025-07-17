---
title: "Thiết lập CI/CD Pipeline"
date: 2024-01-01
weight: 30
chapter: false
pre: "<b>3. </b>"
---

## Tổng quan

CI/CD Pipeline là thành phần quan trọng để tự động hóa việc triển khai và cập nhật SDLF. Pipeline này sẽ sử dụng AWS CodeCommit, CodeBuild và CodePipeline.

[Tài liệu chính thức về SDLF CI/CD](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-cicd)

![Kiến trúc CI/CD Pipeline](../../../static/images/3/0.png?width=40pc)

## Các thành phần chính

1. **CodeCommit**: Repository lưu trữ mã nguồn
2. **CodeBuild**: Build và test code
3. **CodePipeline**: Orchestrate quy trình CI/CD
4. **CloudFormation**: Deploy infrastructure
5. **S3 Artifacts**: Lưu trữ build artifacts

## Các bước thực hiện

1. [Tạo CodeCommit repositories](1-create-repositories)
2. [Cấu hình CodeBuild](2-configure-codebuild)
3. [Thiết lập CodePipeline](3-setup-pipeline)
4. [Kiểm tra pipeline](4-test-pipeline)

{{% notice note %}}
CI/CD Pipeline sẽ giúp tự động hóa việc triển khai các thành phần của SDLF mỗi khi có thay đổi trong mã nguồn.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đã hoàn thành phần SDLF Foundations trước khi bắt đầu phần này.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tạo CodeCommit repositories](1-create-repositories) để lưu trữ mã nguồn của SDLF.