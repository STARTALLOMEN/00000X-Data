---
title: "Tạo và chạy Glue Crawler"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>7.2 </b>"
---

## Tạo và chạy Glue Crawler

AWS Glue Crawler quét dữ liệu của bạn trong Amazon S3, phát hiện schema và tạo các bảng trong AWS Glue Data Catalog. Các bảng này sau đó có thể được truy vấn bằng Amazon Athena.

### Các bước thực hiện

#### Bước 1: Mở AWS Glue Console

1. Đăng nhập vào AWS Management Console
2. Tìm kiếm "Glue" trong thanh tìm kiếm
3. Chọn "AWS Glue" từ kết quả tìm kiếm

![Mở AWS Glue Console](../../../../static/images/7/2/7.2.1_open_glue_console.png?width=40pc)

#### Bước 2: Tạo Glue Crawler

1. Trong menu bên trái, chọn "Crawlers"
2. Nhấp vào nút "Create crawler"

![Chọn Create crawler](../../../../static/images/7/2/7.2.2_create_crawler_button.png?width=40pc)

#### Bước 3: Cấu hình thông tin crawler

1. Nhập thông tin cơ bản:
   - Crawler name: `team-a-dataset-a-crawler`
   - Mô tả (tùy chọn): `Crawler for Team A's dataset A`
2. Nhấp vào "Next"

![Cấu hình thông tin crawler](../../../../static/images/7/2/7.2.3_crawler_info.png?width=40pc)

#### Bước 4: Chọn data source

1. Chọn "Data source type": `S3`
2. Chọn "Crawl data in": `Specified path in my account`
3. Nhập "Include path":
   ```
   s3://<DATA_LAKE_BUCKET>/post-stage/team-a/dataset-a/
   ```
   (Thay `<DATA_LAKE_BUCKET>` bằng tên bucket thực tế từ bước trước)
4. Nhấp vào "Next"

![Chọn data source](../../../../static/images/7/2/7.2.4_data_source.png?width=40pc)

#### Bước 5: Cấu hình IAM role

1. Chọn "Create an IAM role"
2. Nhập tên role: `AWSGlueServiceRole-team-a-crawler`
3. Hoặc chọn "Choose an existing IAM role" và chọn role có tên chứa "GlueServiceRole"
4. Nhấp vào "Next"

![Cấu hình IAM role](../../../../static/images/7/2/7.2.5_iam_role.png?width=40pc)

#### Bước 6: Cấu hình output và scheduling

1. Chọn "Target database":
   - Chọn "Add database"
   - Nhập tên database: `team_a_db`
   - Nhấp vào "Create"
2. Nhập "Table name prefix": `transactions_`
3. Chọn "Frequency": `Run on demand`
4. Nhấp vào "Next"

![Cấu hình output và scheduling](../../../../static/images/7/2/7.2.6_output_scheduling.png?width=40pc)

#### Bước 7: Xem lại và tạo crawler

1. Xem lại tất cả các cấu hình
2. Nhấp vào "Create crawler"

![Xem lại và tạo crawler](../../../../static/images/7/2/7.2.7_review_create.png?width=40pc)

#### Bước 8: Chạy crawler

1. Đợi crawler được tạo thành công
2. Chọn crawler "team-a-dataset-a-crawler" trong danh sách
3. Nhấp vào "Run crawler"

![Chạy crawler](../../../../static/images/7/2/7.2.8_run_crawler.png?width=40pc)

#### Bước 9: Theo dõi tiến trình crawler

1. Theo dõi trạng thái của crawler trong danh sách
2. Đợi trạng thái chuyển từ "Starting" sang "Running" và cuối cùng là "Ready"
3. Quá trình này có thể mất vài phút

![Theo dõi tiến trình](../../../../static/images/7/2/7.2.9_monitor_progress.png?width=40pc)

#### Bước 10: Xác nhận tables đã được tạo

1. Trong menu bên trái, chọn "Databases"
2. Chọn database "team_a_db"
3. Chọn "Tables" để xem danh sách tables
4. Xác nhận có table bắt đầu bằng "transactions_"

![Xác nhận tables](../../../../static/images/7/2/7.2.10_verify_tables.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Crawler không tìm thấy dữ liệu
**Giải pháp**:
1. Kiểm tra đường dẫn S3 chính xác
2. Đảm bảo dữ liệu đã được nạp vào bucket
3. Kiểm tra IAM role có đủ quyền truy cập S3

**Vấn đề**: Crawler chạy thành công nhưng không tạo tables
**Giải pháp**:
1. Kiểm tra định dạng dữ liệu (CSV, JSON, Parquet, v.v.)
2. Đảm bảo dữ liệu có cấu trúc nhất quán
3. Kiểm tra logs của crawler trong CloudWatch

{{% notice tip %}}
Nếu dữ liệu của bạn được phân vùng (ví dụ: theo ngày), Glue Crawler sẽ tự động phát hiện cấu trúc phân vùng và tạo các cột phân vùng tương ứng trong schema.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Thực hiện truy vấn SQL](../3-run-queries) để phân tích dữ liệu trong data lake.