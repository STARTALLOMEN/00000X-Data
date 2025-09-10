---
title: "Xây dựng Location Recommendation System"
date: 2024-01-01
weight: 1
chapter: false
---


# Xây dựng Location Recommendation System

#### Tổng quan

Workshop này hướng dẫn người học cách triển khai Serverless Data Lake Framework (SDLF) để xây dựng Location Recommendation System sử dụng Yelp Dataset. Chúng ta sẽ sử dụng các dịch vụ serverless của AWS để tạo ra một nền tảng recommendation engine mạnh mẽ, có khả năng mở rộng và sẵn sàng cho production.

Hệ thống này sử dụng Serverless Data Lake Framework (SDLF) - một bộ công cụ bao gồm các thành phần hạ tầng (infrastructure) có thể tái sử dụng, được thiết kế để tăng tốc việc triển khai recommendation system doanh nghiệp trên AWS. SDLF tuân thủ các nguyên tắc của AWS Well-Architected Framework và mang lại khả năng xử lý dữ liệu Yelp quy mô lớn một cách hiệu quả, như được mô tả chi tiết trong [tài liệu](https://sdlf.readthedocs.io/en/latest/).

![SDLF Architecture](/images/1/sdlf-layers-architecture.png?width=90pc)

| Layer | Mô tả cho Location Recommendation System |
| --- | --- |
| storage | Lưu trữ Yelp Dataset (business, review, user, tip, checkin) trong S3 với Lake Formation |
| catalog | Glue data catalog quản lý schema của Yelp data và metadata cho recommendation engine |
| processing | Lambda functions và Glue jobs xử lý Yelp data, tính toán recommendation scores và similarity metrics |
| consumption | Athena workgroups để query business data và tạo recommendation APIs |
| orchestration | Step Functions và EventBridge điều phối ETL workflow và recommendation pipeline |
| governance and security | Lake Formation, KMS Keys, và IAM Roles bảo mật Yelp data và API access |

#### Mục tiêu
Mục tiêu của workshop này là xây dựng Location Recommendation System sử dụng Yelp Open Dataset. Chúng ta sẽ minh họa cách dữ liệu Yelp (businesses, reviews, users, tips, check-ins) có thể được lưu trữ, phân loại, chuyển đổi và tạo ra các API recommendation mạnh mẽ cho việc tìm kiếm và gợi ý địa điểm.

Workshop này sử dụng Yelp Open Dataset bao gồm thông tin về hơn 150,000 doanh nghiệp, 6.9 triệu reviews, và 1.9 triệu users trong định dạng JSON. Dataset được tải xuống từ [Yelp Open Dataset](https://www.yelp.com/dataset) và đã được chuẩn bị sẵn cho mục đích của workshop này.

Sử dụng SDLF, chúng ta sẽ:
- Xử lý và chuẩn hóa dữ liệu Yelp bằng ETL pipeline
- Tạo recommendation algorithms dựa trên rating, location, và user preferences
- Xây dựng APIs cho business search và location recommendations
- Phát triển dashboard analytics cho business intelligence

## Các bước thực hiện
    
1. [Các bước chuẩn bị](1-prerequisite)
2. [Triển khai SDLF Foundations](2-foundations)
3. [Thiết lập CI/CD Pipeline](3-cicd-pipeline)
4. [Đăng ký Team và Dataset](4-team-dataset)
5. [Triển khai ETL Pipeline cho Yelp Data](5-etl-pipeline)
6. [Nạp và xử lý dữ liệu Yelp](6-data-ingestion)
7. [Xây dựng Recommendation APIs với Athena](7-athena-query)
8. [Giám sát và xử lý sự cố](8-monitoring)
9. [Dọn dẹp tài nguyên](9-cleanup)
