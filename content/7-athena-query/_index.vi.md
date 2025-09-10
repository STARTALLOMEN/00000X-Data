---
title: "Xây dựng Recommendation APIs với Athena"
date: 2024-01-01
weight: 70
chapter: false
pre: "<b>7. </b>"
---

## Tổng quan

Trong phần này, chúng ta sẽ sử dụng Amazon Athena để tạo ra các recommendation algorithms và APIs cho Location Recommendation System. Chúng ta sẽ viết các SQL queries phức tạp để phân tích dữ liệu Yelp và tạo ra intelligent recommendations dựa trên location, rating, category và user preferences.

[Tài liệu chính thức về Amazon Athena](https://docs.aws.amazon.com/athena/latest/ug/what-is.html)

![Kiến trúc Athena Query](../../../static/images/7/architecture.png?width=40pc)

## Lợi ích của Amazon Athena

- **Serverless**: Không cần quản lý infrastructure
- **Trả tiền theo truy vấn (pay‑per‑query)**: Chỉ trả tiền cho lượng dữ liệu được quét
- **Tương thích với SQL**: Sử dụng ANSI SQL tiêu chuẩn
- **Tích hợp với AWS Glue Data Catalog**: Tự động phát hiện schema
- **Hiệu suất cao**: Sử dụng engine Presto cho truy vấn nhanh

## Các bước thực hiện

1. [Thiết lập Athena Workgroup](1-setup-workgroup) - Cấu hình môi trường làm việc cho Athena
2. [Tạo và chạy Glue Crawler](2-create-crawler) - Phát hiện schema của dữ liệu
3. [Thực hiện truy vấn SQL](3-run-queries) - Truy vấn và phân tích dữ liệu
4. [Tạo và sử dụng Views](4-create-views) - Đơn giản hóa truy vấn phức tạp
5. [Xuất kết quả truy vấn](5-export-results) - Lưu và chia sẻ kết quả phân tích

{{% notice note %}}
Amazon Athena tính phí dựa trên lượng dữ liệu được quét trong mỗi truy vấn. Để tối ưu chi phí, hãy sử dụng các kỹ thuật như partition pruning, column projection và nén dữ liệu.
{{% /notice %}}

## Bước tiếp theo

Hãy bắt đầu với việc [Thiết lập Athena Workgroup](1-setup-workgroup) để chuẩn bị môi trường truy vấn.
