---
title: "Các bước chuẩn bị"
date: 2024-01-01
weight: 10
chapter: false
pre: "<b>1. </b>"
---

## Tổng quan

Trước khi bắt đầu triển khai Location Recommendation System, chúng ta cần chuẩn bị môi trường làm việc trên AWS. Phần này sẽ hướng dẫn bạn đăng nhập vào AWS Management Console, mở AWS CloudShell và chọn region phù hợp cho việc xây dựng hệ thống gợi ý địa điểm sử dụng SDLF và Yelp Dataset.

[Tài liệu chính thức về SDLF](https://github.com/awslabs/aws-serverless-data-lake-framework)

![Kiến trúc SDLF](../../../static/images/1/0.png?width=40pc)

## Yêu cầu

- Tài khoản AWS với quyền AdministratorAccess (budget $150 USD)
- Trình duyệt web hiện đại (Chrome, Firefox, Safari, Edge)
- Kết nối internet ổn định để download Yelp Open Dataset
- Hiểu biết cơ bản về JSON format và business recommendation concepts

## Dataset Information

Chúng ta sẽ sử dụng **Yelp Open Dataset** bao gồm:
- **business.json**: Thông tin 150,000+ doanh nghiệp (location, category, rating, attributes)
- **review.json**: 6.9 triệu reviews với rating và text content
- **user.json**: 1.9 triệu user profiles và interaction history
- **tip.json**: Tips ngắn gọn từ users về businesses
- **checkin.json**: Check-in data theo thời gian và địa điểm

## Các bước thực hiện

1. [Đăng nhập vào AWS Management Console](1-aws-console)
2. [Mở AWS CloudShell](2-cloudshell)
3. [Chọn region phù hợp cho cost optimization](3-region-selection)

{{% notice note %}}
Workshop này được thiết kế để thực hiện trên AWS CloudShell với budget control ($150), giúp bạn không cần cài đặt bất kỳ công cụ nào trên máy tính cá nhân.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn sử dụng region us-east-1 (N. Virginia) cho toàn bộ workshop để optimize cost và tránh data transfer charges.
{{% /notice %}}

{{% notice tip %}}
Ước tính chi phí workshop: $20-40 cho 3 tháng triển khai, bao gồm S3 storage, Glue jobs, Lambda functions, và Athena queries.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Đăng nhập vào AWS Management Console](1-aws-console) để bắt đầu xây dựng Location Recommendation System.