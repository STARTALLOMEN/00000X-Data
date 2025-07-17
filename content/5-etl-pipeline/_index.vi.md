---
title: "Triển khai ETL Pipeline"
date: 2024-01-01
weight: 50
chapter: false
pre: "<b>5. </b>"
---

## Tổng quan

ETL Pipeline là thành phần xử lý và chuyển đổi dữ liệu trong SDLF. Pipeline này sẽ sử dụng AWS Glue để extract, transform và load dữ liệu.

[Tài liệu chính thức về SDLF ETL Pipeline](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-pipelines)

![Kiến trúc ETL Pipeline](../../../static/images/5/0.png?width=40pc)

## Các thành phần chính

1. **Glue Jobs**: Xử lý và chuyển đổi dữ liệu
2. **Step Functions**: Orchestrate workflow
3. **EventBridge**: Trigger events
4. **S3 Buckets**: Lưu trữ dữ liệu raw, stage, analytics
5. **Glue Data Catalog**: Quản lý metadata

## Các bước thực hiện

1. [Tạo Glue jobs](1-create-glue-jobs)
2. [Thiết lập Step Functions](2-setup-step-functions)
3. [Cấu hình EventBridge](3-configure-eventbridge)

{{% notice note %}}
ETL Pipeline sẽ tự động xử lý dữ liệu khi có dữ liệu mới được upload vào S3 bucket.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đã hoàn thành phần Team và Dataset trước khi bắt đầu phần này.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tạo Glue jobs](1-create-glue-jobs) để xử lý và chuyển đổi dữ liệu.