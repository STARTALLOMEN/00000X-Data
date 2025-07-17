---
title: "Triển khai SDLF Foundations"
date: 2024-01-01
weight: 20
chapter: false
pre: "<b>2. </b>"
---

## Tổng quan

SDLF Foundations là cơ sở hạ tầng cơ bản cần thiết để triển khai Serverless Data Lake Framework. Phần này sẽ thiết lập các thành phần cốt lõi của data lake.

[Tài liệu chính thức về SDLF Foundations](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-foundations)

![Kiến trúc SDLF Foundations](../../../static/images/2/0.png?width=40pc)

## Các thành phần chính

1. **S3 Buckets**: Lưu trữ dữ liệu raw, processed và curated
2. **Glue Data Catalog**: Quản lý metadata và schema
3. **Lake Formation**: Quản lý quyền truy cập dữ liệu
4. **IAM Roles**: Phân quyền cho các dịch vụ
5. **KMS Keys**: Mã hóa dữ liệu
6. **CloudWatch**: Giám sát và logging

## Các bước thực hiện

1. [Clone repository SDLF](1-clone-repository)
2. [Cấu hình parameters](2-configure-parameters)
3. [Triển khai CloudFormation](3-deploy-cloudformation)
4. [Kiểm tra kết quả triển khai](4-verify-deployment)

{{% notice note %}}
Quá trình triển khai SDLF Foundations có thể mất khoảng 15-20 phút. Đây là thời gian tốt để tìm hiểu thêm về kiến trúc của SDLF.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đang sử dụng region đã chọn ở phần trước. Việc thay đổi region giữa chừng có thể gây ra lỗi.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Clone repository SDLF](1-clone-repository) để bắt đầu triển khai.