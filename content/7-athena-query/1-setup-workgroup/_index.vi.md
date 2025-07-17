---
title: "Thiết lập Athena Workgroup"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>7.1 </b>"
---

## Thiết lập Athena Workgroup

Workgroup trong Amazon Athena giúp bạn tổ chức người dùng, teams, applications và quản lý việc truy vấn. Mỗi workgroup có thể có cấu hình riêng về vị trí lưu kết quả truy vấn, giới hạn dữ liệu quét và theo dõi chi phí.

### Các bước thực hiện

#### Bước 1: Mở CloudShell

1. Đăng nhập vào AWS Management Console
2. Nhấp vào biểu tượng CloudShell ở thanh menu phía trên
3. Đợi CloudShell khởi động hoàn tất

![Mở CloudShell](../../../../static/images/7/1/7.1.1_open_cloudshell.png?width=40pc)

#### Bước 2: Lấy tên S3 bucket của data lake

1. Trong CloudShell, chạy lệnh sau để lấy tên S3 bucket từ CloudFormation outputs:

```bash
DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh
3. Ghi lại tên bucket được hiển thị, chúng ta sẽ sử dụng trong các bước tiếp theo

![Lấy tên bucket](../../../../static/images/7/1/7.1.2_get_bucket_name.png?width=40pc)

#### Bước 3: Tạo Athena workgroup

1. Trong CloudShell, chạy lệnh sau để tạo workgroup cho analytics team:

```bash
aws athena create-work-group \
    --name analytics-team-workgroup \
    --configuration '{
        "ResultConfiguration": {
            "OutputLocation": "s3://'$DATA_LAKE_BUCKET'/athena-results/analytics-team/"
        },
        "EnforceWorkGroupConfiguration": true,
        "PublishCloudwatchMetricsEnabled": true,
        "BytesScannedCutoffPerQuery": 1073741824
    }' \
    --description "Workgroup for analytics team queries"
```

2. Nhấn Enter để thực hiện lệnh

![Tạo workgroup](../../../../static/images/7/1/7.1.3_create_workgroup.png?width=40pc)

#### Bước 4: Xác nhận workgroup đã được tạo

1. Trong CloudShell, chạy lệnh sau để liệt kê các workgroup:

```bash
aws athena list-work-groups
```

2. Nhấn Enter để thực hiện lệnh
3. Xác nhận "analytics-team-workgroup" xuất hiện trong danh sách

![Xác nhận workgroup](../../../../static/images/7/1/7.1.4_verify_workgroup.png?width=40pc)

#### Bước 5: Kiểm tra cấu hình workgroup

1. Trong CloudShell, chạy lệnh sau để xem chi tiết cấu hình của workgroup:

```bash
aws athena get-work-group --work-group analytics-team-workgroup
```

2. Nhấn Enter để thực hiện lệnh
3. Xác nhận các cấu hình như OutputLocation, EnforceWorkGroupConfiguration, v.v.

![Kiểm tra cấu hình](../../../../static/images/7/1/7.1.5_check_config.png?width=40pc)

### Xác nhận trên AWS Console

Bạn cũng có thể xác nhận workgroup đã được tạo thông qua AWS Console:

1. Mở AWS Management Console và tìm kiếm "Athena"
2. Trong menu bên trái, chọn "Workgroups"
3. Xác nhận "analytics-team-workgroup" xuất hiện trong danh sách
4. Nhấp vào tên workgroup để xem chi tiết cấu hình

![Xác nhận trên Console](../../../../static/images/7/1/7.1.6_console_verification.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "Access Denied" khi tạo workgroup
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo bạn có quyền "athena:CreateWorkGroup"
3. Kiểm tra quyền truy cập vào S3 bucket

**Vấn đề**: Không thể tìm thấy tên bucket từ CloudFormation
**Giải pháp**:
1. Kiểm tra tên stack CloudFormation chính xác là "sdlf-foundations-stack"
2. Kiểm tra stack đã được triển khai thành công
3. Kiểm tra output key chính xác là "DataLakeBucketName"

{{% notice note %}}
Workgroup giúp bạn quản lý và theo dõi chi phí truy vấn Athena. Mỗi team hoặc dự án nên có workgroup riêng để dễ dàng phân tích chi phí.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tạo và chạy Glue Crawler](../2-create-crawler) để phát hiện schema của dữ liệu trong data lake.