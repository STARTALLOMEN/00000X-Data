---
title: "Chuẩn bị dữ liệu mẫu"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>6.1 </b>"
---

## Chuẩn bị dữ liệu mẫu

Bước đầu tiên trong việc nạp dữ liệu là chuẩn bị dữ liệu mẫu để upload vào data lake. Trong phần này, chúng ta sẽ tạo hai loại dữ liệu mẫu:

1. **Dữ liệu legislators**: Chứa thông tin về các nhà lập pháp, bao gồm ID, tên, đảng phái, tiểu bang, và nhiệm kỳ.
2. **Dữ liệu transactions**: Chứa thông tin về các giao dịch, bao gồm ID giao dịch, ID khách hàng, số tiền, loại tiền tệ, ngày giao dịch và danh mục.

Cả hai loại dữ liệu này sẽ được lưu trữ dưới dạng JSON Lines, mỗi dòng là một đối tượng JSON hợp lệ.

### Các bước thực hiện

#### Bước 1: Tạo thư mục cho dữ liệu mẫu

Đầu tiên, chúng ta cần tạo một thư mục để lưu trữ các file dữ liệu mẫu. CloudShell cung cấp một môi trường làm việc tạm thời để chúng ta có thể tạo và quản lý các file.

1. Mở AWS Management Console và tìm kiếm "CloudShell"

2. Khi CloudShell đã khởi động, nhập lệnh sau để tạo thư mục cho dữ liệu mẫu:

```bash
mkdir -p ~/environment/sample-data
cd ~/environment/sample-data
```

3. Nhấn Enter để thực hiện lệnh

![Tạo thư mục](../../../static/images/6/1/6.1.1_create_directory.png?width=40pc)

{{% notice tip %}}
CloudShell là một terminal dựa trên trình duyệt được quản lý bởi AWS, cho phép bạn chạy các lệnh AWS CLI mà không cần cài đặt bất kỳ phần mềm nào trên máy tính của bạn.
{{% /notice %}}

#### Bước 2: Tạo dữ liệu mẫu cho legislators

Tiếp theo, chúng ta sẽ tạo dữ liệu mẫu cho legislators. Dữ liệu này sẽ được lưu trữ dưới dạng JSON Lines, với mỗi dòng là một đối tượng JSON đại diện cho một nhà lập pháp.

1. Trong CloudShell, đảm bảo bạn đang ở thư mục `~/environment/sample-data`

2. Nhập lệnh sau để tạo file dữ liệu mẫu cho legislators:

```bash
cat > legislators.json << 'EOL'
{"id": "001", "name": "John Smith", "party": "Democratic", "state": "CA", "chamber": "Senate", "start_date": "2020-01-01", "end_date": "2026-01-01", "is_current": true, "term_length_days": 2191}
{"id": "002", "name": "Jane Doe", "party": "Republican", "state": "TX", "chamber": "House", "start_date": "2022-01-01", "end_date": "2024-01-01", "is_current": true, "term_length_days": 730}
{"id": "003", "name": "Robert Johnson", "party": "Democratic", "state": "NY", "chamber": "Senate", "start_date": "2018-01-01", "end_date": "2024-01-01", "is_current": true, "term_length_days": 2191}
{"id": "004", "name": "Emily Wilson", "party": "Republican", "state": "FL", "chamber": "House", "start_date": "2022-01-01", "end_date": "2024-01-01", "is_current": true, "term_length_days": 730}
{"id": "005", "name": "Michael Brown", "party": "Independent", "state": "OH", "chamber": "Senate", "start_date": "2020-01-01", "end_date": "2026-01-01", "is_current": true, "term_length_days": 2191}
EOL
```

3. Nhấn Enter để thực hiện lệnh

![Tạo dữ liệu legislators](../../../static/images/6/1/6.1.2_create_legislators_data.png?width=40pc)

4. Lệnh trên sẽ tạo một file có tên `legislators.json` với 5 bản ghi. Mỗi bản ghi chứa các trường sau:

   - **id**: Mã định danh duy nhất của nhà lập pháp
   - **name**: Tên của nhà lập pháp
   - **party**: Đảng phái chính trị (Democratic, Republican, Independent)
   - **state**: Tiểu bang (mã 2 ký tự của tiểu bang)
   - **chamber**: Viện (Senate hoặc House)
   - **start_date**: Ngày bắt đầu nhiệm kỳ (dạng YYYY-MM-DD)
   - **end_date**: Ngày kết thúc nhiệm kỳ (dạng YYYY-MM-DD)
   - **is_current**: Trạng thái hiện tại (true hoặc false)
   - **term_length_days**: Độ dài nhiệm kỳ tính bằng ngày

#### Bước 3: Tạo dữ liệu mẫu cho transactions

Sau khi đã tạo dữ liệu cho legislators, chúng ta sẽ tiếp tục tạo dữ liệu mẫu cho transactions. Dữ liệu này mô phỏng các giao dịch tài chính với các thông tin như ID giao dịch, ID khách hàng, số tiền, và danh mục giao dịch.

1. Trong CloudShell, đảm bảo bạn vẫn đang ở thư mục `~/environment/sample-data`

2. Nhập lệnh sau để tạo file dữ liệu mẫu cho transactions:

```bash
cat > transactions.json << 'EOL'
{"transaction_id": "tx001", "customer_id": "cust001", "amount": 100.50, "currency": "USD", "transaction_date": "2024-01-15", "merchant_category": "retail"}
{"transaction_id": "tx002", "customer_id": "cust002", "amount": 75.25, "currency": "USD", "transaction_date": "2024-01-15", "merchant_category": "food"}
{"transaction_id": "tx003", "customer_id": "cust001", "amount": 200.00, "currency": "USD", "transaction_date": "2024-01-16", "merchant_category": "travel"}
{"transaction_id": "tx004", "customer_id": "cust003", "amount": 50.75, "currency": "USD", "transaction_date": "2024-01-16", "merchant_category": "retail"}
{"transaction_id": "tx005", "customer_id": "cust002", "amount": 120.00, "currency": "USD", "transaction_date": "2024-01-17", "merchant_category": "entertainment"}
{"transaction_id": "tx006", "customer_id": "cust004", "amount": 300.25, "currency": "USD", "transaction_date": "2024-01-17", "merchant_category": "travel"}
{"transaction_id": "tx007", "customer_id": "cust001", "amount": 45.00, "currency": "USD", "transaction_date": "2024-01-18", "merchant_category": "food"}
{"transaction_id": "tx008", "customer_id": "cust005", "amount": 500.00, "currency": "USD", "transaction_date": "2024-01-18", "merchant_category": "electronics"}
{"transaction_id": "tx009", "customer_id": "cust002", "amount": 25.50, "currency": "USD", "transaction_date": "2024-01-19", "merchant_category": "food"}
{"transaction_id": "tx010", "customer_id": "cust003", "amount": 150.75, "currency": "USD", "transaction_date": "2024-01-19", "merchant_category": "retail"}
EOL
```

3. Nhấn Enter để thực hiện lệnh

![Tạo dữ liệu transactions](../../../static/images/6/1/6.1.3_create_transactions_data.png?width=40pc)

4. Lệnh trên sẽ tạo một file có tên `transactions.json` với 10 bản ghi. Mỗi bản ghi chứa các trường sau:

   - **transaction_id**: Mã định danh duy nhất của giao dịch
   - **customer_id**: Mã định danh của khách hàng thực hiện giao dịch
   - **amount**: Số tiền giao dịch
   - **currency**: Loại tiền tệ (USD, EUR, v.v.)
   - **transaction_date**: Ngày thực hiện giao dịch (dạng YYYY-MM-DD)
   - **merchant_category**: Danh mục của giao dịch (retail, food, travel, v.v.)
   
{{% notice note %}}
Dữ liệu transactions này sẽ được sử dụng để mô phỏng dữ liệu giao dịch thực tế trong hệ thống tài chính. Trong môi trường thực tế, dữ liệu này có thể đến từ nhiều nguồn khác nhau như hệ thống thanh toán, ứng dụng di động, hoặc các kênh giao dịch khác.
{{% /notice %}}

#### Bước 4: Kiểm tra dữ liệu mẫu

Sau khi đã tạo các file dữ liệu mẫu, chúng ta cần kiểm tra để đảm bảo dữ liệu đã được tạo đúng định dạng và có đầy đủ các trường cần thiết.

1. Trong CloudShell, nhập lệnh sau để kiểm tra nội dung của các file dữ liệu mẫu:

```bash
# Kiểm tra file legislators.json
cat legislators.json

# Kiểm tra file transactions.json
cat transactions.json
```

2. Nhấn Enter để thực hiện từng lệnh

![Kiểm tra dữ liệu](../../../static/images/6/1/6.1.4_check_data.png?width=40pc)

3. Bạn sẽ thấy nội dung của các file dữ liệu mẫu

4. Để kiểm tra số lượng bản ghi trong mỗi file, bạn có thể sử dụng lệnh `wc -l`:

```bash
# Đếm số dòng trong file legislators.json
wc -l legislators.json

# Đếm số dòng trong file transactions.json
wc -l transactions.json
```

5. Kết quả sẽ cho thấy file `legislators.json` có 5 dòng và file `transactions.json` có 10 dòng

{{% notice tip %}}
Kiểm tra dữ liệu trước khi upload là một bước quan trọng để đảm bảo quá trình ETL sẽ hoạt động đúng cách. Nếu dữ liệu không đúng định dạng, các bước xử lý sau này có thể gặp lỗi.
{{% /notice %}}

#### Bước 5: Tạo script để tạo dữ liệu mẫu lớn hơn (tùy chọn)

Trong môi trường thực tế, dữ liệu thường có khối lượng lớn hơn nhiều so với các file mẫu đơn giản mà chúng ta đã tạo. Để mô phỏng tốt hơn môi trường sản xuất, chúng ta có thể tạo một lượng dữ liệu lớn hơn bằng cách sử dụng script Python.

1. Nếu bạn muốn tạo dữ liệu mẫu lớn hơn, bạn có thể sử dụng script Python sau. Script này sẽ tạo 100 bản ghi legislators và 1000 bản ghi transactions với dữ liệu ngẫu nhiên:

```bash
cat > generate_data.py << 'EOL'
import json
import random
from datetime import datetime, timedelta
import uuid

# Tạo dữ liệu legislators
def generate_legislators(count=100):
    parties = ["Democratic", "Republican", "Independent"]
    states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
              "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
              "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
              "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
              "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    chambers = ["Senate", "House"]
    
    legislators = []
    for i in range(1, count + 1):
        id_str = f"{i:03d}"
        party = random.choice(parties)
        state = random.choice(states)
        chamber = random.choice(chambers)
        
        start_year = random.randint(2018, 2022)
        start_date = f"{start_year}-01-01"
        
        term_years = 6 if chamber == "Senate" else 2
        end_year = start_year + term_years
        end_date = f"{end_year}-01-01"
        
        term_length_days = term_years * 365
        
        legislator = {
            "id": id_str,
            "name": f"Legislator {id_str}",
            "party": party,
            "state": state,
            "chamber": chamber,
            "start_date": start_date,
            "end_date": end_date,
            "is_current": True,
            "term_length_days": term_length_days
        }
        legislators.append(legislator)
    
    return legislators

# Tạo dữ liệu transactions
def generate_transactions(count=1000):
    merchant_categories = ["retail", "food", "travel", "entertainment", "electronics", "healthcare", "education", "utilities"]
    currencies = ["USD", "EUR", "GBP", "JPY", "CAD", "AUD"]
    
    transactions = []
    for i in range(1, count + 1):
        transaction_id = f"tx{i:06d}"
        customer_id = f"cust{random.randint(1, 100):03d}"
        amount = round(random.uniform(10, 1000), 2)
        currency = random.choice(currencies)
        
        # Ngày giao dịch trong khoảng 30 ngày gần đây
        days_ago = random.randint(0, 30)
        transaction_date = (datetime.now() - timedelta(days=days_ago)).strftime("%Y-%m-%d")
        
        merchant_category = random.choice(merchant_categories)
        
        transaction = {
            "transaction_id": transaction_id,
            "customer_id": customer_id,
            "amount": amount,
            "currency": currency,
            "transaction_date": transaction_date,
            "merchant_category": merchant_category
        }
        transactions.append(transaction)
    
    return transactions

# Tạo và lưu dữ liệu
def save_data(data, filename):
    with open(filename, 'w') as f:
        for item in data:
            f.write(json.dumps(item) + '\n')

# Tạo dữ liệu
legislators = generate_legislators(100)
transactions = generate_transactions(1000)

# Lưu dữ liệu
save_data(legislators, 'legislators_large.json')
save_data(transactions, 'transactions_large.json')

print(f"Generated {len(legislators)} legislators and {len(transactions)} transactions")
EOL

# Cài đặt Python nếu cần
pip install --user datetime

# Chạy script
python generate_data.py
```

2. Nhấn Enter để thực hiện lệnh

![Tạo script](../../../static/images/6/1/6.1.5_create_script.png?width=40pc)

3. Bạn sẽ thấy thông báo về số lượng bản ghi đã được tạo

#### Bước 6: Kiểm tra dữ liệu mẫu lớn (nếu đã tạo)

Sau khi chạy script Python để tạo dữ liệu mẫu lớn hơn, chúng ta cần kiểm tra các file đã được tạo để đảm bảo chúng có đúng số lượng bản ghi như mong đợi.

1. Nếu bạn đã tạo dữ liệu mẫu lớn, nhập lệnh sau để kiểm tra số lượng bản ghi:

```bash
# Đếm số dòng trong file legislators_large.json
wc -l legislators_large.json

# Đếm số dòng trong file transactions_large.json
wc -l transactions_large.json
```

2. Nhấn Enter để thực hiện từng lệnh

![Kiểm tra dữ liệu lớn](../../../static/images/6/1/6.1.6_check_large_data.png?width=40pc)

3. Bạn sẽ thấy kết quả hiển thị số lượng bản ghi trong mỗi file:
   - `legislators_large.json`: 100 bản ghi
   - `transactions_large.json`: 1000 bản ghi

4. Bạn cũng có thể kiểm tra kích thước của các file bằng lệnh:

```bash
# Kiểm tra kích thước của các file
ls -lh legislators*.json transactions*.json
```

5. Lệnh này sẽ hiển thị kích thước của cả các file dữ liệu mẫu nhỏ và lớn

{{% notice note %}}
Việc tạo dữ liệu mẫu lớn hơn giúp kiểm tra hiệu suất của ETL pipeline và khả năng xử lý của hệ thống với khối lượng dữ liệu lớn hơn. Tuy nhiên, để tiết kiệm thời gian trong workshop này, bạn có thể chỉ sử dụng các file dữ liệu mẫu nhỏ hơn đã tạo ở các bước trước.
{{% /notice %}}

### Xử lý sự cố

**Vấn đề**: Lỗi "command not found: python"
**Giải pháp**:
1. Sử dụng `python3` thay vì `python`:
   ```bash
   python3 generate_data.py
   ```
2. Hoặc cài đặt Python trong CloudShell:
   ```bash
   sudo yum install -y python3
   ```

**Vấn đề**: Lỗi "ModuleNotFoundError: No module named 'datetime'"
**Giải pháp**:
1. Cài đặt thư viện datetime:
   ```bash
   pip3 install --user datetime
   ```

**Vấn đề**: Lỗi khi tạo file dữ liệu mẫu
**Giải pháp**:
1. Kiểm tra quyền truy cập thư mục:
   ```bash
   ls -la ~/environment/sample-data
   ```
2. Đảm bảo bạn có đủ dung lượng trống:
   ```bash
   df -h
   ```
3. Thử tạo file với nội dung ngắn hơn:
   ```bash
   echo '{"test": "data"}' > test.json
   ```

**Vấn đề**: Lỗi "Permission denied" khi chạy script Python
**Giải pháp**:
1. Thêm quyền thực thi cho script:
   ```bash
   chmod +x generate_data.py
   ```

{{% notice tip %}}
Bạn có thể tùy chỉnh dữ liệu mẫu theo nhu cầu của mình. Các file JSON được tạo ra có định dạng JSON Lines, với mỗi dòng là một đối tượng JSON hợp lệ. Định dạng này rất phổ biến trong các hệ thống xử lý dữ liệu lớn vì nó cho phép xử lý từng bản ghi một cách độc lập.
{{% /notice %}}

### Tổng kết

Trong phần này, chúng ta đã hoàn thành các bước sau:

1. Tạo thư mục cho dữ liệu mẫu trong CloudShell
2. Tạo dữ liệu mẫu cho legislators với 5 bản ghi
3. Tạo dữ liệu mẫu cho transactions với 10 bản ghi
4. Kiểm tra dữ liệu mẫu đã tạo
5. (Tùy chọn) Tạo dữ liệu mẫu lớn hơn với script Python

Dữ liệu mẫu này sẽ được sử dụng trong bước tiếp theo để upload vào data lake và kích hoạt ETL pipeline.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Upload dữ liệu](../2-upload-data) vào data lake để kích hoạt ETL pipeline và theo dõi quá trình xử lý dữ liệu.