---
title: "Serverless Data Lake Framework Jump Start"
date: 2025-08-01
weight: 1
chapter: false
---

# Serverless Data Lake Framework Jump Start

#### Tổng quan

Workshop này hướng dẫn người học cách triển khai các dịch vụ serverless của AWS để xây dựng kiến trúc data lake hiện đại trên nền tảng AWS, đảm bảo khả năng mở rộng linh hoạt và sẵn sàng cho tương lai.

Serverless Data Lake Framework (SDLF) là một bộ công cụ bao gồm các thành phần infrastructure có thể tái sử dụng, được thiết kế để tăng tốc việc triển khai hệ thống data lake doanh nghiệp trên AWS, giúp giảm thời gian triển khai vào production từ nhiều tháng xuống chỉ còn vài tuần. SDLF tuân thủ các nguyên tắc của AWS Well-Architected Framework và mang lại nhiều lợi ích khác cho doanh nghiệp, như được mô tả chi tiết trong [tài liệu](https://sdlf.readthedocs.io/en/latest/).

![SDLF Architecture](/images/1/sdlf-layers-architecture.png?width=90pc)

| Layer | Mô tả |
| --- | --- |
| storage | Các layer lưu trữ data lake với S3 và Lake Formation |
| catalog | Glue data catalog (databases và crawlers) |
| processing | Lambda functions và Glue jobs được trigger bởi EventBridge để xử lý dữ liệu |
| consumption | Athena workgroups để query và sử dụng dữ liệu |
| orchestration | Step Functions và EventBridge để điều phối các workflow xử lý |
| governance and security | Lake Formation, KMS Keys, và IAM Roles cho quản trị và bảo mật |

#### Mục tiêu
Mục tiêu của chúng ta là minh họa cách dữ liệu thô có thể được lưu trữ, phân loại, chuyển đổi (sử dụng các phương pháp transformation nhẹ và/hoặc nặng), và được sử dụng bởi các ứng dụng cũng như end users.

Workshop này sử dụng dataset được tải xuống từ [đây](https://github.com/aws-solutions-library-samples/data-lakes-on-aws/tree/main/sdlf-utils/workshop-examples/legislators/data). Dataset chứa thông tin định dạng JSON về các nhà lập pháp Hoa Kỳ và các vị trí họ đã nắm giữ trong Hạ viện và Thượng viện Hoa Kỳ, và đã được chỉnh sửa nhẹ và cung cấp trong GitHub repository cho mục đích của workshop này.

Trong workshop này, sử dụng SDLF, chúng ta sẽ chuẩn hóa và xử lý dữ liệu bằng các phương pháp transformation nhẹ và nặng, và cuối cùng làm cho dữ liệu có thể query được bởi end users thông qua Amazon Athena.

### Workshop Content:

1. [Prerequisites](1-prerequisite)
2. [Deploy SDLF Foundations](2-foundations)
3. [Setup CI/CD Pipeline](3-cicd-pipeline)
4. [Register Team and Dataset](4-team-dataset)
5. [Deploy ETL Pipeline](5-etl-pipeline)
6. [Data Ingestion and Processing](6-data-ingestion)
7. [Query Data with Athena](7-athena-query)
8. [Monitoring and Troubleshooting](8-monitoring)



