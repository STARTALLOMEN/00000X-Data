---
title: "Upload dữ liệu"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>6.2 </b>"
---

## Upload dữ liệu

Sau khi đã chuẩn bị dữ liệu mẫu, chúng ta sẽ upload dữ liệu vào data lake để kích hoạt ETL pipeline. Đây là bước quan trọng trong quy trình xử lý dữ liệu, nơi dữ liệu thô được đưa vào hệ thống và bắt đầu quá trình chuyển đổi.

### Quy trình nạp dữ liệu và ETL

Khi dữ liệu được upload vào S3 bucket trong thư mục `/raw`, các sự kiện sau sẽ xảy ra:

1. **EventBridge** phát hiện sự kiện S3 PutObject và kích hoạt Step Functions state machine
2. **Step Functions** điều phối quy trình ETL thông qua các bước:
   - Kiểm tra metadata của file
   - Chạy Glue job Stage A để xử lý sơ bộ dữ liệu
   - Lưu dữ liệu đã xử lý vào thư mục `/stage`
   - Chạy Glue job Stage B để xử lý thêm dữ liệu
   - Lưu dữ liệu đã xử lý vào thư mục `/analytics`
   - Cập nhật metadata và catalog

Trong phần này, chúng ta sẽ upload dữ liệu và theo dõi toàn bộ quá trình này.

### Các bước thực hiện

#### Bước 1: Lấy tên của Data Lake bucket

Để upload dữ liệu vào S3 bucket, trước tiên chúng ta cần biết chính xác tên của Data Lake bucket đã được tạo trong phần Foundations. Tên bucket này được lưu trong outputs của CloudFormation stack.

1. Mở AWS CloudShell (nếu chưa mở)

2. Trong CloudShell, nhập lệnh sau để lấy tên của Data Lake bucket và lưu vào biến môi trường:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

3. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/6/2/6.2.1_get_bucket_name.png?width=40pc)

4. Bạn sẽ thấy tên của Data Lake bucket, ví dụ:
```
Data Lake Bucket: sdlf-datalake-123456789012-us-east-1
```

5. Lệnh trên thực hiện các bước sau:
   - Sử dụng AWS CLI để truy vấn thông tin của CloudFormation stack `sdlf-foundations-stack`
   - Lọc kết quả để lấy giá trị của output có key là `DataLakeBucketName`
   - Lưu giá trị này vào biến môi trường `DATA_LAKE_BUCKET`
   - Hiển thị tên bucket để xác nhận
   
{{% notice note %}}
Biến môi trường `DATA_LAKE_BUCKET` sẽ được sử dụng trong các lệnh tiếp theo để tránh phải nhập lại tên bucket dài và phức tạp nhiều lần.
{{% /notice %}}

#### Bước 2: Upload dữ liệu legislators vào S3

Bây giờ chúng ta sẽ upload file dữ liệu legislators.json vào S3 bucket trong thư mục `/raw`. Đường dẫn đầy đủ sẽ là `/raw/team-a/dataset-a/legislators/`, tuân theo cấu trúc thư mục đã được thiết lập trong SDLF.

1. Đảm bảo bạn đang ở thư mục chứa dữ liệu mẫu:

```bash
cd ~/environment/sample-data
```

2. Kiểm tra file dữ liệu legislators.json có tồn tại không:

```bash
ls -la legislators.json
```

3. Upload file legislators.json vào S3 bucket:

```bash
# Upload file legislators.json
aws s3 cp legislators.json s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/legislators/
```

4. Nhấn Enter để thực hiện lệnh

![Upload dữ liệu legislators](../../../static/images/6/2/6.2.2_upload_legislators.png?width=40pc)

5. Bạn sẽ thấy thông báo xác nhận upload thành công, ví dụ:
```
upload: ./legislators.json to s3://sdlf-datalake-123456789012-us-east-1/raw/team-a/dataset-a/legislators/legislators.json
```

6. Bạn có thể kiểm tra xác nhận file đã được upload lên S3:

```bash
aws s3 ls s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/legislators/
```

{{% notice note %}}
Khi file được upload vào thư mục `/raw`, EventBridge sẽ tự động phát hiện sự kiện này và kích hoạt Step Functions state machine để bắt đầu quá trình ETL.
{{% /notice %}}

#### Bước 3: Kiểm tra ETL pipeline cho legislators

Sau khi upload file dữ liệu, ETL pipeline sẽ được kích hoạt tự động. Chúng ta cần kiểm tra Step Functions để theo dõi quá trình xử lý dữ liệu.

1. Mở AWS Management Console và tìm kiếm "Step Functions" trong thanh tìm kiếm

2. Nhấp vào dịch vụ "Step Functions" trong kết quả tìm kiếm

3. Trong trang Step Functions, bạn sẽ thấy danh sách các state machines. Tìm state machine có tên "team-a-dataset-a-pipeline"

4. Nhấp vào state machine để xem chi tiết

5. Trong tab "Executions", bạn sẽ thấy một execution mới đã được tạo tự động sau khi upload file

6. Nhấp vào execution để xem chi tiết và theo dõi tiến trình

![Kiểm tra execution](../../../static/images/6/2/6.2.3_check_execution.png?width=40pc)

7. Bạn sẽ thấy biểu đồ trực quan của quy trình ETL với các bước đang được thực hiện hoặc đã hoàn thành

8. Đợi cho đến khi execution hoàn thành (trạng thái "Succeeded"). Quá trình này có thể mất vài phút

{{% notice tip %}}
Step Functions cung cấp giao diện trực quan để theo dõi quá trình ETL. Mỗi bước trong quy trình được hiển thị với trạng thái cụ thể (Running, Succeeded, Failed). Bạn có thể nhấp vào từng bước để xem thông tin chi tiết hơn.
{{% /notice %}}

#### Bước 4: Kiểm tra dữ liệu đã xử lý

Sau khi ETL pipeline hoàn thành, dữ liệu sẽ được xử lý và lưu trữ trong các layer khác nhau của data lake. Chúng ta cần kiểm tra các layer này để xác nhận dữ liệu đã được xử lý đúng cách.

1. Quay lại CloudShell và đảm bảo biến `DATA_LAKE_BUCKET` vẫn còn được định nghĩa:

```bash
echo $DATA_LAKE_BUCKET
```

2. Nếu biến không còn giá trị, hãy chạy lại lệnh ở Bước 1 để lấy lại tên bucket

3. Kiểm tra dữ liệu đã được xử lý trong stage layer:

```bash
# Kiểm tra dữ liệu trong stage layer
aws s3 ls s3://$DATA_LAKE_BUCKET/stage/team-a/dataset-a/legislators/
```

4. Kiểm tra dữ liệu đã được xử lý trong analytics layer:

```bash
# Kiểm tra dữ liệu trong analytics layer
aws s3 ls s3://$DATA_LAKE_BUCKET/analytics/team-a/dataset-a/legislators/
```

5. Nhấn Enter để thực hiện từng lệnh

![Kiểm tra dữ liệu đã xử lý](../../../static/images/6/2/6.2.4_check_processed_data.png?width=40pc)

6. Bạn sẽ thấy danh sách các files đã được tạo trong mỗi layer. Các file này có thể có tên khác với file gốc và có thể được lưu trữ dưới dạng Parquet hoặc các định dạng khác tùy thuộc vào cấu hình của ETL pipeline

7. Để xem nội dung của một file cụ thể, bạn có thể sử dụng lệnh sau (thay thế `<file_name>` bằng tên file thực tế):

```bash
# Tải file về máy để xem nội dung
aws s3 cp s3://$DATA_LAKE_BUCKET/analytics/team-a/dataset-a/legislators/<file_name> ./
cat <file_name>
```

{{% notice note %}}
Dữ liệu trong stage layer là dữ liệu đã qua bước xử lý đầu tiên (Stage A), trong khi dữ liệu trong analytics layer là dữ liệu đã qua bước xử lý thứ hai (Stage B) và sẵn sàng cho việc phân tích.
{{% /notice %}}

#### Bước 5: Upload dữ liệu transactions vào S3

Sau khi đã kiểm tra quá trình xử lý dữ liệu legislators, chúng ta sẽ tiếp tục với dữ liệu transactions. Quy trình tương tự như với dữ liệu legislators, nhưng chúng ta sẽ upload vào thư mục `/raw/team-a/dataset-a/transactions/`.

1. Đảm bảo bạn vẫn đang ở thư mục chứa dữ liệu mẫu:

```bash
cd ~/environment/sample-data
```

2. Kiểm tra file dữ liệu transactions.json có tồn tại không:

```bash
ls -la transactions.json
```

3. Upload file transactions.json vào S3 bucket:

```bash
# Upload file transactions.json
aws s3 cp transactions.json s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/transactions/
```

4. Nhấn Enter để thực hiện lệnh

![Upload dữ liệu transactions](../../../static/images/6/2/6.2.5_upload_transactions.png?width=40pc)

5. Bạn sẽ thấy thông báo xác nhận upload thành công, ví dụ:
```
upload: ./transactions.json to s3://sdlf-datalake-123456789012-us-east-1/raw/team-a/dataset-a/transactions/transactions.json
```

6. Bạn có thể kiểm tra xác nhận file đã được upload lên S3:

```bash
aws s3 ls s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/transactions/
```

{{% notice note %}}
Giống như với dữ liệu legislators, việc upload file transactions.json sẽ tự động kích hoạt một execution mới của ETL pipeline. Mỗi file được upload sẽ tạo ra một execution riêng biệt.
{{% /notice %}}

#### Bước 6: Kiểm tra ETL pipeline cho transactions

Sau khi upload file transactions.json, chúng ta cần kiểm tra ETL pipeline để đảm bảo quá trình xử lý dữ liệu transactions cũng được kích hoạt và hoạt động đúng cách.

1. Quay lại trang Step Functions trong AWS Management Console (hoặc mở lại nếu đã đóng)

2. Đi đến state machine "team-a-dataset-a-pipeline" như đã làm ở Bước 3

3. Trong danh sách executions, bạn sẽ thấy một execution mới đã được tạo tự động sau khi upload file transactions.json

4. Nhấp vào execution mới nhất để xem chi tiết và theo dõi tiến trình

![Kiểm tra execution cho transactions](../../../static/images/6/2/6.2.6_check_transactions_execution.png?width=40pc)

5. Bạn sẽ thấy biểu đồ trực quan của quy trình ETL tương tự như với dữ liệu legislators

6. Đợi cho đến khi execution hoàn thành (trạng thái "Succeeded"). Quá trình này có thể mất vài phút

7. Bạn có thể xem thông tin chi tiết của từng bước trong quy trình bằng cách nhấp vào các nút trong biểu đồ

{{% notice tip %}}
Bạn có thể so sánh các execution khác nhau bằng cách xem thời gian thực hiện và trạng thái của từng bước. Điều này giúp bạn hiểu rõ hơn về hiệu suất của ETL pipeline với các loại dữ liệu khác nhau.
{{% /notice %}}

#### Bước 7: Kiểm tra dữ liệu transactions đã xử lý

Sau khi ETL pipeline cho transactions hoàn thành, chúng ta cần kiểm tra dữ liệu đã được xử lý trong các layer khác nhau của data lake, tương tự như đã làm với dữ liệu legislators.

1. Quay lại CloudShell và kiểm tra dữ liệu transactions đã được xử lý trong stage layer:

```bash
# Kiểm tra dữ liệu trong stage layer
aws s3 ls s3://$DATA_LAKE_BUCKET/stage/team-a/dataset-a/transactions/
```

2. Kiểm tra dữ liệu transactions đã được xử lý trong analytics layer:

```bash
# Kiểm tra dữ liệu trong analytics layer
aws s3 ls s3://$DATA_LAKE_BUCKET/analytics/team-a/dataset-a/transactions/
```

3. Nhấn Enter để thực hiện từng lệnh

![Kiểm tra dữ liệu transactions đã xử lý](../../../static/images/6/2/6.2.7_check_transactions_processed.png?width=40pc)

4. Bạn sẽ thấy danh sách các files đã được tạo trong mỗi layer

5. Để so sánh cấu trúc thư mục giữa các layer, bạn có thể sử dụng lệnh sau:

```bash
# So sánh cấu trúc thư mục giữa các layer
echo "=== RAW LAYER ==="
aws s3 ls s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/ --recursive | head -10

echo "\n=== STAGE LAYER ==="
aws s3 ls s3://$DATA_LAKE_BUCKET/stage/team-a/dataset-a/ --recursive | head -10

echo "\n=== ANALYTICS LAYER ==="
aws s3 ls s3://$DATA_LAKE_BUCKET/analytics/team-a/dataset-a/ --recursive | head -10
```

6. Lệnh này sẽ hiển thị cấu trúc thư mục và các file trong mỗi layer, giúp bạn hiểu rõ hơn về cách dữ liệu được tổ chức trong data lake

{{% notice note %}}
Dữ liệu trong analytics layer thường được tổ chức theo cấu trúc tối ưu cho truy vấn, có thể bao gồm phân vứng theo các trường như ngày, danh mục, v.v. Điều này giúp cải thiện hiệu suất truy vấn khi sử dụng các công cụ phân tích như Athena.
{{% /notice %}}

#### Bước 8: Upload dữ liệu mẫu lớn (tùy chọn)

Nếu bạn đã tạo dữ liệu mẫu lớn hơn bằng script Python ở phần trước, bạn có thể upload chúng vào data lake để kiểm tra hiệu suất của ETL pipeline với khối lượng dữ liệu lớn hơn.

1. Đảm bảo bạn vẫn đang ở thư mục chứa dữ liệu mẫu:

```bash
cd ~/environment/sample-data
```

2. Kiểm tra các file dữ liệu mẫu lớn có tồn tại không:

```bash
ls -la *_large.json
```

3. Nếu các file tồn tại, upload chúng vào S3 bucket trong các thư mục riêng để tránh nhầm lẫn với dữ liệu mẫu nhỏ hơn:

```bash
# Tạo thư mục large_data nếu chưa tồn tại
aws s3api put-object --bucket $DATA_LAKE_BUCKET --key raw/team-a/dataset-a/legislators/large_data/
aws s3api put-object --bucket $DATA_LAKE_BUCKET --key raw/team-a/dataset-a/transactions/large_data/

# Upload file legislators_large.json
aws s3 cp legislators_large.json s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/legislators/large_data/

# Upload file transactions_large.json
aws s3 cp transactions_large.json s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/transactions/large_data/
```

4. Nhấn Enter để thực hiện từng lệnh

![Upload dữ liệu lớn](../../../static/images/6/2/6.2.8_upload_large_data.png?width=40pc)

5. Bạn sẽ thấy thông báo xác nhận upload thành công

6. Sau khi upload, bạn có thể kiểm tra Step Functions để theo dõi các execution mới được tạo cho các file dữ liệu lớn này

{{% notice warning %}}
Việc xử lý dữ liệu lớn có thể mất nhiều thời gian hơn và có thể phát sinh thêm chi phí AWS. Đảm bảo bạn hiểu rõ về các giới hạn và chi phí liên quan trước khi upload dữ liệu lớn vào môi trường sản xuất.
{{% /notice %}}

#### Bước 9: Kiểm tra CloudWatch Logs

1. Mở AWS Management Console và tìm kiếm "CloudWatch"
2. Trong menu bên trái, chọn "Logs" > "Log groups"
3. Tìm log groups liên quan đến Glue jobs:
   - /aws-glue/jobs/team-a-dataset-a-stage-a
   - /aws-glue/jobs/team-a-dataset-a-stage-b
4. Nhấp vào mỗi log group để xem chi tiết
5. Chọn log stream mới nhất để xem logs

![Kiểm tra CloudWatch Logs](../../../static/images/6/2/6.2.9_check_logs.png?width=40pc)

6. Bạn sẽ thấy logs chi tiết của quá trình xử lý dữ liệu

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi upload dữ liệu
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo tên bucket chính xác
3. Kiểm tra bucket policy

**Vấn đề**: ETL pipeline không được kích hoạt tự động
**Giải pháp**:
1. Kiểm tra EventBridge rule đã được cấu hình đúng chưa
2. Kiểm tra prefix trong event pattern
3. Kiểm tra IAM role của EventBridge

**Vấn đề**: Glue job fails
**Giải pháp**:
1. Kiểm tra CloudWatch Logs để xem lỗi chi tiết
2. Đảm bảo định dạng dữ liệu đúng
3. Kiểm tra IAM role của Glue job

{{% notice tip %}}
Bạn có thể sử dụng lệnh `aws s3 ls s3://$DATA_LAKE_BUCKET/ --recursive` để xem tất cả các files trong S3 bucket.
{{% /notice %}}

## Tổng kết

Chúc mừng! Bạn đã hoàn thành việc nạp và xử lý dữ liệu trong SDLF, bao gồm:

1. Chuẩn bị dữ liệu mẫu
2. Upload dữ liệu vào S3 bucket
3. Kích hoạt và theo dõi ETL pipeline
4. Kiểm tra dữ liệu đã xử lý

Dữ liệu đã được xử lý qua các stages và lưu trữ trong analytics layer, sẵn sàng cho việc truy vấn và phân tích.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Truy vấn dữ liệu với Athena](../../7-athena-query) để phân tích dữ liệu đã được xử lý.