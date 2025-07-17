---
title: "Tạo và sử dụng Views"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>7.4 </b>"
---

## Tạo và sử dụng Views

Views trong Athena giúp đơn giản hóa các truy vấn phức tạp và cho phép tái sử dụng logic truy vấn. Views cũng có thể được sử dụng để giới hạn quyền truy cập vào dữ liệu nhạy cảm.

### Các bước thực hiện

#### Bước 1: Mở Amazon Athena Console

1. Đăng nhập vào AWS Management Console
2. Tìm kiếm "Athena" trong thanh tìm kiếm
3. Chọn "Amazon Athena" từ kết quả tìm kiếm
4. Đảm bảo bạn đang sử dụng workgroup "analytics-team-workgroup"

![Mở Amazon Athena Console](../../../../static/images/7/4/7.4.1_open_athena_console.png?width=40pc)

#### Bước 2: Tạo view cơ bản

1. Trong Query editor, nhập truy vấn SQL sau để tạo view cơ bản:

```sql
CREATE OR REPLACE VIEW "team_a_db"."transactions_view" AS
SELECT 
    transaction_id,
    customer_id,
    amount,
    currency,
    transaction_date,
    merchant_category
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS";
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Tạo view cơ bản](../../../../static/images/7/4/7.4.2_create_basic_view.png?width=40pc)

#### Bước 3: Xác nhận view đã được tạo

1. Trong danh sách tables bên trái, nhấp vào biểu tượng làm mới
2. Xác nhận "transactions_view" xuất hiện trong danh sách
3. Mở rộng view để xem schema

![Xác nhận view](../../../../static/images/7/4/7.4.3_verify_view.png?width=40pc)

#### Bước 4: Truy vấn view

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT * FROM "team_a_db"."transactions_view" LIMIT 10;
```

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter
3. Xem kết quả truy vấn ở phần dưới màn hình

![Truy vấn view](../../../../static/images/7/4/7.4.4_query_view.png?width=40pc)

#### Bước 5: Tạo view tổng hợp

1. Trong Query editor, nhập truy vấn SQL sau để tạo view tổng hợp:

```sql
CREATE OR REPLACE VIEW "team_a_db"."daily_transactions_summary" AS
SELECT 
    DATE(transaction_date) as tx_date,
    merchant_category,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount,
    AVG(amount) as avg_amount
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY DATE(transaction_date), merchant_category;
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Tạo view tổng hợp](../../../../static/images/7/4/7.4.5_create_aggregate_view.png?width=40pc)

#### Bước 6: Truy vấn view tổng hợp

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT * FROM "team_a_db"."daily_transactions_summary"
ORDER BY tx_date DESC, total_amount DESC
LIMIT 20;
```

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter
3. Xem kết quả truy vấn ở phần dưới màn hình

![Truy vấn view tổng hợp](../../../../static/images/7/4/7.4.6_query_aggregate_view.png?width=40pc)

#### Bước 7: Tạo view cho phân tích khách hàng

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
CREATE OR REPLACE VIEW "team_a_db"."customer_spending_analysis" AS
SELECT 
    customer_id,
    COUNT(*) as transaction_count,
    SUM(amount) as total_spent,
    AVG(amount) as avg_transaction,
    MIN(transaction_date) as first_transaction,
    MAX(transaction_date) as last_transaction
FROM "team_a_db"."transactions_YYYYMMDD_HHMMSS"
GROUP BY customer_id;
```

(Thay "transactions_YYYYMMDD_HHMMSS" bằng tên table thực tế)

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter

![Tạo view phân tích khách hàng](../../../../static/images/7/4/7.4.7_create_customer_view.png?width=40pc)

#### Bước 8: Truy vấn view phân tích khách hàng

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SELECT * FROM "team_a_db"."customer_spending_analysis"
ORDER BY total_spent DESC
LIMIT 10;
```

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter
3. Xem kết quả truy vấn ở phần dưới màn hình

![Truy vấn view phân tích khách hàng](../../../../static/images/7/4/7.4.8_query_customer_view.png?width=40pc)

#### Bước 9: Xem thông tin về view

1. Trong Query editor, nhập truy vấn SQL sau:

```sql
SHOW CREATE VIEW "team_a_db"."transactions_view";
```

2. Nhấp vào "Run query" hoặc nhấn Ctrl+Enter
3. Xem định nghĩa SQL của view

![Xem thông tin về view](../../../../static/images/7/4/7.4.9_show_view_definition.png?width=40pc)

### Lợi ích của việc sử dụng Views

1. **Đơn giản hóa truy vấn phức tạp**: Ẩn logic phức tạp đằng sau view đơn giản
2. **Tái sử dụng logic**: Định nghĩa logic một lần và sử dụng nhiều lần
3. **Bảo mật dữ liệu**: Giới hạn quyền truy cập vào các cột nhạy cảm
4. **Chuẩn hóa dữ liệu**: Đảm bảo tính nhất quán trong cách dữ liệu được truy vấn
5. **Tối ưu hiệu suất**: Giảm lượng dữ liệu được quét bằng cách chỉ chọn các cột cần thiết

### Xử lý sự cố

**Vấn đề**: Lỗi "View already exists"
**Giải pháp**:
1. Sử dụng CREATE OR REPLACE VIEW thay vì CREATE VIEW
2. Hoặc xóa view hiện có trước bằng DROP VIEW

**Vấn đề**: Lỗi khi truy vấn view
**Giải pháp**:
1. Kiểm tra định nghĩa view bằng SHOW CREATE VIEW
2. Đảm bảo table gốc vẫn tồn tại và có thể truy cập
3. Kiểm tra quyền truy cập vào view và table gốc

{{% notice note %}}
Views trong Athena là metadata-only và không lưu trữ dữ liệu. Mỗi khi bạn truy vấn một view, Athena sẽ thực hiện truy vấn định nghĩa view trên dữ liệu gốc.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Export kết quả truy vấn](../5-export-results) để lưu và chia sẻ kết quả phân tích.