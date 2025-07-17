---
title: "Thực hiện truy vấn SQL"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>7.3 </b>"
---

## Thực hiện truy vấn SQL

Sau khi đã thiết lập Athena Workgroup và tạo tables bằng Glue Crawler, bây giờ chúng ta có thể sử dụng SQL để truy vấn và phân tích dữ liệu trong data lake.

### Các bước thực hiện

#### Bước 1: Mở Amazon Athena Console

1. Đăng nhập vào AWS Management Console
2. Tìm kiếm "Athena" trong thanh tìm kiếm
3. Chọn "Amazon Athena" từ kết quả tìm kiếm

![Mở Amazon Athena Console](../../../../static/images/7/3/7.3.1_open_athena_console.png?width=40pc)

#### Bước 2: Chọn Workgroup

1. Trong menu bên trái, chọn "Workgroups"
2. Tìm và chọn "analytics-team-workgroup" từ danh sách
3. Nhấp vào "Switch workgroup" để chuyển sang workgroup này

![Chọn Workgroup](../../../../static/images/7/3/7.3.2_select_workgroup.png?width=40pc)

#### Bước 3: Chọn Database và Table

1. Trong menu bên trái, chọn "Query editor"
2. Từ dropdown "Database", chọn "team_a_db"
3. Bạn sẽ thấy danh sách tables trong database, bao gồm table "transactions_..." đã được tạo bởi Glue Crawler

![Chọn Database và Table](../../../../static/images/7/3/7.3.3_select_database_table.png?width=40pc)

#### Bước 4: Xem schema của table

1. Nhấp vào biểu tượng "..." bên cạnh tên table
2. Chọn "Preview table"
3. Hoặc mở rộng tên table để xem danh sách các cột và kiểu dữ liệu

![Xem schema của table](../../../../static/images/7/3/7.3.4_view_schema.png?width=40pc)

#### Bước 5: Thực hiện truy vấn cơ bản

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT * FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS" LIMIT 10;
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Thực hiện truy vấn cơ bản](../../../../static/images/7/3/7.3.5_basic_query.png?width=40pc)

3. Xem kết quả truy vấn ở phần dưới màn hình

#### Bước 6: Thực hiện truy vấn tổng hợp theo merchant_category

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT 
    merchant_category,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount,
    AVG(amount) as avg_amount
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY merchant_category
ORDER BY total_amount DESC;
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Truy vấn tổng hợp](../../../../static/images/7/3/7.3.6_aggregate_query.png?width=40pc)

#### Bước 7: Thực hiện truy vấn phân tích theo customer_id

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT 
    customer_id,
    COUNT(*) as transaction_count,
    SUM(amount) as total_spent,
    AVG(amount) as avg_transaction,
    MIN(transaction_date) as first_transaction,
    MAX(transaction_date) as last_transaction
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 20;
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Truy vấn phân tích](../../../../static/images/7/3/7.3.7_analytical_query.png?width=40pc)

#### Bước 8: Lưu truy vấn

1. Sau khi thực hiện truy vấn thành công, nhấp vào "Save as"
2. Nhập tên cho truy vấn, ví dụ: "Customer Spending Analysis"
3. Nhấp vào "Save"

![Lưu truy vấn](../../../../static/images/7/3/7.3.8_save_query.png?width=40pc)

#### Bước 9: Xem lịch sử truy vấn

1. Trong menu bên trái, chọn "Recent queries"
2. Xem danh sách các truy vấn đã thực hiện gần đây
3. Nhấp vào một truy vấn để mở lại trong Query editor

![Xem lịch sử truy vấn](../../../../static/images/7/3/7.3.9_query_history.png?width=40pc)

### Các truy vấn SQL hữu ích

#### Truy vấn 1: Phân tích giao dịch theo ngày

```sql
SELECT 
    DATE(transaction_date) as tx_date,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount,
    AVG(amount) as avg_amount
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY DATE(transaction_date)
ORDER BY tx_date DESC;
```

#### Truy vấn 2: Top 10 khách hàng có chi tiêu cao nhất

```sql
SELECT 
    customer_id,
    COUNT(*) as transaction_count,
    SUM(amount) as total_spent
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;
```

#### Truy vấn 3: Phân tích giao dịch theo giờ trong ngày

```sql
SELECT 
    EXTRACT(HOUR FROM transaction_date) as hour_of_day,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY EXTRACT(HOUR FROM transaction_date)
ORDER BY hour_of_day;
```

### Xử lý sự cố

**Vấn đề**: Lỗi "Table not found"
**Giải pháp**:
1. Kiểm tra tên database và table chính xác
2. Đảm bảo Glue Crawler đã chạy thành công
3. Kiểm tra quyền truy cập vào Glue Data Catalog

**Vấn đề**: Lỗi "Access Denied" khi truy vấn
**Giải pháp**:
1. Kiểm tra IAM permissions
2. Đảm bảo bạn có quyền truy cập vào S3 bucket chứa dữ liệu
3. Kiểm tra Lake Formation permissions nếu được sử dụng

{{% notice tip %}}
Để tối ưu chi phí khi sử dụng Athena, hãy giới hạn số lượng dữ liệu được quét bằng cách sử dụng WHERE clause, LIMIT, và chỉ chọn các cột cần thiết thay vì sử dụng SELECT *.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tạo và sử dụng Views](../4-create-views) để đơn giản hóa các truy vấn phức tạp.