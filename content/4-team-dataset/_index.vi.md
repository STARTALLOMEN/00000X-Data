---
title: "Đăng ký Team và Dataset"
date: 2024-01-01
weight: 40
chapter: false
pre: "<b>4. </b>"
---

## Tổng quan

Trong phần này, chúng ta sẽ đăng ký team "yelp-recommender" và dataset "yelp-business-data" trong SDLF để thiết lập cấu trúc xử lý dữ liệu Yelp và quyền truy cập cho recommendation system.

[Tài liệu chính thức về SDLF Teams và Datasets](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-team)

![Kiến trúc Team và Dataset](../../../static/images/4/0.png?width=40pc)

## Các thành phần chính cho Yelp Recommendation System

1. **Team "yelp-recommender"**: Nhóm quản lý Yelp dataset và recommendation algorithms
2. **Datasets**: 
   - `yelp-business-data`: Business information và attributes
   - `yelp-review-data`: User reviews và ratings
   - `yelp-user-data`: User profiles và preferences
3. **Permissions**: Quyền truy cập cho ETL pipelines và API functions
4. **Data Catalog**: Metadata về Yelp dataset structure và relationships

## Team Configuration

- **Team Name**: `yelp-recommender`
- **Datasets**: Multiple Yelp data sources
- **Access Pattern**: Read/Write for ETL, Read-only cho recommendation APIs
- **Security**: Row-level security cho sensitive user data

## Các bước thực hiện

1. [Đăng ký team "yelp-recommender"](1-register-team)
2. [Tạo Yelp datasets](2-create-dataset)
3. [Thiết lập quyền cho recommendation system](3-configure-permissions)

{{% notice note %}}
Việc đăng ký team và dataset cho Yelp data là bước quan trọng để thiết lập security boundaries và data governance cho recommendation system.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đã hoàn thành phần CI/CD Pipeline trước khi bắt đầu phần này. Team registration requires pipeline infrastructure.
{{% /notice %}}

{{% notice tip %}}
Team và dataset setup không incur additional costs nhưng establish foundation cho data processing charges later.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Đăng ký team "yelp-recommender"](1-register-team) để bắt đầu thiết lập Yelp data structure.