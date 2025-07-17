---
title: "Export kết quả truy vấn"
date: 2024-01-01
weight: 5
chapter: false
pre: "<b>7.5 </b>"
---

## Export kết quả truy vấn

Sau khi thực hiện các truy vấn phân tích, bạn có thể muốn lưu kết quả để chia sẻ với người khác hoặc sử dụng trong các công cụ phân tích khác. Amazon Athena cho phép bạn export kết quả truy vấn theo nhiều định dạng khác nhau.

### Các bước thực hiện

#### Bước 1: Thực hiện truy vấn để export

1. Mở Amazon Athena Console
2. Đảm bảo bạn đang sử dụng workgroup "analytics-team-workgroup"
3. Trong Query editor, nhập một truy vấn có kết quả bạn muốn export, ví dụ:

```sql
SELECT * FROM "team_a_db"."daily_transactions_summary"
ORDER BY tx_date DESC, total_amount DESC
LIMIT 100;
```

4. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter
5. Đợi truy vấn hoàn thành và hiển thị kết quả

![Thực hiện truy vấn để export](../../../../static/images/7/5/7.5.1_run_query_for_export.png?width=40pc)

#### Bước 2: Export kết quả dưới dạng CSV

1. Sau khi truy vấn hoàn thành, nhấp vào biểu tượng "Download results" (hình tải xuống) ở góc trên bên phải của bảng kết quả
2. Chọn "CSV"
3. File CSV sẽ được tải xuống máy tính của bạn

![Export dạng CSV](../../../../static/images/7/5/7.5.2_export_csv.png?width=40pc)

#### Bước 3: Export kết quả dưới dạng JSON

1. Sau khi truy vấn hoàn thành, nhấp vào biểu tượng "Download results" (hình tải xuống) ở góc trên bên phải của bảng kết quả
2. Chọn "JSON"
3. File JSON sẽ được tải xuống máy tính của bạn

![Export dạng JSON](../../../../static/images/7/5/7.5.3_export_json.png?width=40pc)

#### Bước 4: Xem kết quả truy vấn trong S3

1. Mở AWS Management Console và tìm kiếm "S3"
2. Chọn "Amazon S3" từ kết quả tìm kiếm
3. Tìm và chọn bucket data lake của bạn (được sử dụng khi thiết lập workgroup)
4. Điều hướng đến thư mục "athena-results/analytics-team/"
5. Bạn sẽ thấy các file kết quả truy vấn được lưu trữ ở đây, được tổ chức theo ngày

![Xem kết quả trong S3](../../../../static/images/7/5/7.5.4_view_results_in_s3.png?width=40pc)

#### Bước 5: Tạo truy vấn lưu kết quả vào bảng mới

1. Trong Query editor, nhập truy vấn SQL sau để lưu kết quả vào bảng mới:

```sql
CREATE TABLE "team_a_db"."monthly_transaction_summary"
WITH (
    format = 'PARQUET',
    parquet_compression = 'SNAPPY',
    external_location = 's3://<DATA_LAKE_BUCKET>/analytics/monthly_summary/'
) AS
SELECT 
    DATE_TRUNC('month', transaction_date) as month,
    merchant_category,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount,
    AVG(amount) as avg_amount
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY DATE_TRUNC('month', transaction_date), merchant_category;
```

(Thay "<DATA_LAKE_BUCKET>" bằng tên bucket thực tế và "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Lưu kết quả vào bảng mới](../../../../static/images/7/5/7.5.5_save_to_new_table.png?width=40pc)

#### Bước 6: Xác nhận bảng mới đã được tạo

1. Trong danh sách tables bên trái, nhấp vào biểu tượng làm mới
2. Xác nhận "monthly_transaction_summary" xuất hiện trong danh sách
3. Truy vấn bảng mới để xác nhận dữ liệu:

```sql
SELECT * FROM "team_a_db"."monthly_transaction_summary"
ORDER BY month DESC, total_amount DESC;
```

![Xác nhận bảng mới](../../../../static/images/7/5/7.5.6_verify_new_table.png?width=40pc)

#### Bước 7: Xem dữ liệu Parquet trong S3

1. Mở AWS Management Console và tìm kiếm "S3"
2. Chọn "Amazon S3" từ kết quả tìm kiếm
3. Tìm và chọn bucket data lake của bạn
4. Điều hướng đến thư mục "analytics/monthly_summary/"
5. Bạn sẽ thấy các file Parquet chứa dữ liệu của bảng mới

![Xem dữ liệu Parquet trong S3](../../../../static/images/7/5/7.5.7_view_parquet_in_s3.png?width=40pc)

#### Bước 8: Thiết lập export tự động vào S3

1. Trong CloudShell, chạy lệnh sau để tạo một EventBridge rule để lưu tất cả kết quả truy vấn:

```bash
# Lấy DataLakeBucketName từ CloudFormation outputs
DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

# Tạo IAM role cho Athena để ghi kết quả vào S3
aws iam create-role \
    --role-name AthenaQueryResultsExportRole \
    --assume-role-policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "athena.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }'

# Tạo policy cho role
aws iam put-role-policy \
    --role-name AthenaQueryResultsExportRole \
    --policy-name S3Access \
    --policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:GetObject",
                    "s3:ListBucket"
                ],
                "Resource": [
                    "arn:aws:s3:::'$DATA_LAKE_BUCKET'",
                    "arn:aws:s3:::'$DATA_LAKE_BUCKET'/athena-exports/*"
                ]
            }
        ]
    }'

# Cập nhật cấu hình workgroup để tự động export kết quả
aws athena update-work-group \
    --work-group analytics-team-workgroup \
    --configuration '{
        "ResultConfiguration": {
            "OutputLocation": "s3://'$DATA_LAKE_BUCKET'/athena-results/analytics-team/",
            "EncryptionConfiguration": {
                "EncryptionOption": "SSE_S3"
            }
        },
        "EnforceWorkGroupConfiguration": true,
        "PublishCloudwatchMetricsEnabled": true,
        "BytesScannedCutoffPerQuery": 1073741824
    }'
```

2. Nhấn Enter để thực hiện lệnh

![Thiết lập export tự động](../../../../static/images/7/5/7.5.8_setup_auto_export.png?width=40pc)

### Các định dạng export hỗ trợ

Amazon Athena hỗ trợ export kết quả truy vấn trong các định dạng sau:

1. **CSV (Comma-Separated Values)**:
   - Phổ biến và dễ sử dụng với Excel, Google Sheets
   - Tốt cho dữ liệu dạng bảng đơn giản

2. **JSON (JavaScript Object Notation)**:
   - Tốt cho dữ liệu có cấu trúc phức tạp
   - Dễ dàng phân tích bằng các ngôn ngữ lập trình

3. **Parquet**:
   - Định dạng cột hiệu quả về lưu trữ và hiệu suất
   - Tốt cho phân tích dữ liệu lớn

### Xử lý sự cố

**Vấn đề**: Không thể tải xuống kết quả truy vấn
**Giải pháp**:
1. Kiểm tra kích thước kết quả (giới hạn tải xuống là 100MB)
2. Sử dụng LIMIT để giảm kích thước kết quả
3. Lưu kết quả vào bảng mới và truy vấn từng phần

**Vấn đề**: Lỗi khi tạo bảng từ kết quả truy vấn
**Giải pháp**:
1. Kiểm tra quyền truy cập vào S3 location
2. Đảm bảo đường dẫn S3 không tồn tại hoặc trống
3. Kiểm tra cú pháp SQL của truy vấn CTAS

{{% notice tip %}}
Khi làm việc với dữ liệu lớn, hãy sử dụng định dạng Parquet thay vì CSV hoặc JSON. Parquet tiết kiệm không gian lưu trữ và cải thiện hiệu suất truy vấn đáng kể.
{{% /notice %}}

## Tổng kết

Trong phần này, bạn đã học cách:
1. Export kết quả truy vấn Athena dưới dạng CSV và JSON
2. Xem kết quả truy vấn được lưu trữ trong S3
3. Lưu kết quả truy vấn vào bảng mới với định dạng Parquet
4. Thiết lập export tự động cho workgroup

Bạn đã hoàn thành phần truy vấn dữ liệu với Amazon Athena. Giờ đây, bạn có thể sử dụng Athena để phân tích dữ liệu trong data lake và chia sẻ kết quả với team của mình.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Giám sát và xử lý sự cố](../../8-monitoring) để thiết lập monitoring và alerting cho toàn bộ hệ thống.