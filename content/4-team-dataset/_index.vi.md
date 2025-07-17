---
title: "Đăng ký Team và Dataset"
date: 2024-01-01
weight: 40
chapter: false
pre: "<b>4. </b>"
---

## Tổng quan

Trong phần này, chúng ta sẽ đăng ký team và dataset trong SDLF để thiết lập cấu trúc dữ liệu và quyền truy cập.

[Tài liệu chính thức về SDLF Teams và Datasets](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-team)

![Kiến trúc Team và Dataset](../../../static/images/4/0.png?width=40pc)

## Các thành phần chính

1. **Team**: Nhóm làm việc với các quyền truy cập cụ thể
2. **Dataset**: Bộ dữ liệu được quản lý bởi team
3. **Permissions**: Quyền truy cập vào dữ liệu
4. **Data Catalog**: Metadata về dữ liệu

## Các bước thực hiện

1. [Đăng ký team](1-register-team)
2. [Tạo dataset](2-create-dataset)
3. [Thiết lập quyền truy cập](3-configure-permissions)

{{% notice note %}}
Việc đăng ký team và dataset là bước quan trọng để thiết lập cấu trúc dữ liệu và quyền truy cập trong SDLF.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đã hoàn thành phần CI/CD Pipeline trước khi bắt đầu phần này.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Đăng ký team](1-register-team) để bắt đầu thiết lập cấu trúc dữ liệu.