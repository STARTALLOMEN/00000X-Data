---
title: "Nạp và xử lý dữ liệu"
date: 2024-01-01
weight: 60
chapter: false
pre: "<b>6. </b>"
---

## Tổng quan

Trong phần này, chúng ta sẽ nạp dữ liệu vào data lake và theo dõi quá trình xử lý thông qua ETL pipeline đã thiết lập. Đây là một phần quan trọng trong quy trình làm việc với data lake, nơi dữ liệu thô được đưa vào hệ thống và được xử lý qua nhiều giai đoạn để trở thành dữ liệu có giá trị cho phân tích.

[Tài liệu chính thức về SDLF Data Ingestion](https://github.com/awslabs/aws-serverless-data-lake-framework/tree/master/sdlf-utils)

![Kiến trúc Data Ingestion](../../../static/images/6/0.png?width=40pc)

## Quy trình xử lý dữ liệu trong SDLF

Khi dữ liệu được nạp vào data lake, quy trình xử lý sẽ diễn ra như sau:

1. **Raw Layer**: Dữ liệu thô được upload vào S3 bucket trong thư mục `/raw`
2. **EventBridge Rule**: Phát hiện sự kiện S3 PutObject và kích hoạt Step Functions state machine
3. **Step Functions**: Điều phối quy trình ETL thông qua nhiều giai đoạn
4. **Stage A**: Dữ liệu được xử lý sơ bộ và lưu vào thư mục `/stage`
5. **Stage B**: Dữ liệu được xử lý thêm và lưu vào thư mục `/analytics`
6. **Catalog**: Dữ liệu được đăng ký vào AWS Glue Data Catalog để sẵn sàng cho truy vấn

## Các bước thực hiện

1. [Chuẩn bị dữ liệu mẫu](1-prepare-data) - Tạo dữ liệu JSON mẫu để nạp vào data lake
2. [Upload dữ liệu](2-upload-data) - Đưa dữ liệu vào S3 và theo dõi quá trình xử lý

{{% notice note %}}
Khi dữ liệu được upload vào S3 bucket, EventBridge rule sẽ tự động kích hoạt ETL pipeline để xử lý dữ liệu. Bạn không cần phải thực hiện thêm bất kỳ hành động nào để bắt đầu quá trình xử lý.
{{% /notice %}}

{{% notice warning %}}
Đảm bảo bạn đã hoàn thành phần ETL Pipeline (Phần 5) trước khi bắt đầu phần này. Nếu ETL pipeline chưa được thiết lập đúng cách, quá trình xử lý dữ liệu sẽ không hoạt động.
{{% /notice %}}

## Lợi ích của quy trình nạp dữ liệu tự động

- **Giảm thời gian xử lý**: Dữ liệu được xử lý tự động ngay khi được nạp vào hệ thống
- **Nhất quán**: Áp dụng cùng một quy trình xử lý cho tất cả dữ liệu
- **Khả năng mở rộng**: Dễ dàng xử lý khối lượng dữ liệu lớn
- **Theo dõi**: Có thể theo dõi trạng thái xử lý của từng file dữ liệu
- **Tái sử dụng**: Các thành phần xử lý có thể được tái sử dụng cho nhiều loại dữ liệu khác nhau

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Chuẩn bị dữ liệu mẫu](1-prepare-data) để nạp vào data lake.