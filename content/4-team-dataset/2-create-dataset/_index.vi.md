---
title: "Tạo dataset"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>4.2 </b>"
---

## Tạo dataset

Sau khi đã đăng ký team, chúng ta sẽ tạo dataset để thiết lập cấu trúc dữ liệu cho team.

### Các bước thực hiện

#### Bước 1: Lấy thông tin Data Lake Bucket

1. Trong CloudShell, nhập lệnh sau để lấy tên của Data Lake bucket (nếu bạn chưa thực hiện ở bước trước):

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/4/2/4.2.1_get_bucket_name.png?width=40pc)

#### Bước 2: Tạo dataset trong DynamoDB

1. Nhập lệnh sau để tạo dataset trong bảng DynamoDB sdlf-datasets:

```bash
aws dynamodb put-item \
    --table-name sdlf-datasets \
    --item '{
        "name": {"S": "dataset-a"},
        "team": {"S": "team-a"},
        "bucket": {"S": "'$DATA_LAKE_BUCKET'"},
        "transforms": {"L": [
            {"S": "stage-a"},
            {"S": "stage-b"}
        ]},
        "min_items_process": {"N": "1"},
        "version": {"N": "1"}
    }'
```

2. Nhấn Enter để thực hiện lệnh

![Tạo dataset](../../../static/images/4/2/4.2.2_create_dataset.png?width=40pc)

3. Nếu lệnh thực hiện thành công, bạn sẽ không thấy output nào

#### Bước 3: Kiểm tra dataset đã tạo

1. Nhập lệnh sau để kiểm tra dataset đã được tạo:

```bash
aws dynamodb scan --table-name sdlf-datasets
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra dataset](../../../static/images/4/2/4.2.3_check_dataset.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về dataset đã tạo, ví dụ:

```json
{
    "Items": [
        {
            "name": {
                "S": "dataset-a"
            },
            "team": {
                "S": "team-a"
            },
            "bucket": {
                "S": "sdlf-datalake-123456789012-us-east-1"
            },
            "transforms": {
                "L": [
                    {
                        "S": "stage-a"
                    },
                    {
                        "S": "stage-b"
                    }
                ]
            },
            "min_items_process": {
                "N": "1"
            },
            "version": {
                "N": "1"
            }
        }
    ],
    "Count": 1,
    "ScannedCount": 1,
    "ConsumedCapacity": null
}
```

#### Bước 4: Tạo cấu trúc thư mục cho dataset

1. Nhập lệnh sau để tạo cấu trúc thư mục cho dataset trong S3 bucket:

```bash
# Tạo thư mục raw
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key raw/team-a/dataset-a/

# Tạo thư mục stage
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key stage/team-a/dataset-a/

# Tạo thư mục analytics
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key analytics/team-a/dataset-a/
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo cấu trúc thư mục](../../../static/images/4/2/4.2.4_create_directories.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về các objects đã được tạo, bao gồm ETag

#### Bước 5: Kiểm tra cấu trúc thư mục

1. Nhập lệnh sau để kiểm tra cấu trúc thư mục đã tạo:

```bash
aws s3 ls s3://$DATA_LAKE_BUCKET/ --recursive
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra cấu trúc thư mục](../../../static/images/4/2/4.2.5_check_directories.png?width=40pc)

3. Bạn sẽ thấy danh sách các thư mục đã tạo, bao gồm:
```
analytics/team-a/dataset-a/
raw/team-a/dataset-a/
stage/team-a/dataset-a/
```

#### Bước 6: Tạo Glue Database cho dataset

1. Nhập lệnh sau để tạo Glue Database cho dataset:

```bash
aws glue create-database \
    --database-input '{
        "Name": "team_a_db",
        "Description": "Database for Team A datasets",
        "LocationUri": "s3://'$DATA_LAKE_BUCKET'/analytics/team-a/"
    }'
```

2. Nhấn Enter để thực hiện lệnh

![Tạo Glue Database](../../../static/images/4/2/4.2.6_create_glue_database.png?width=40pc)

3. Nếu lệnh thực hiện thành công, bạn sẽ không thấy output nào

#### Bước 7: Kiểm tra Glue Database

1. Nhập lệnh sau để kiểm tra Glue Database đã tạo:

```bash
aws glue get-database --name team_a_db
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra Glue Database](../../../static/images/4/2/4.2.7_check_glue_database.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về Glue Database đã tạo

### Xử lý sự cố

**Vấn đề**: Lỗi "ResourceNotFoundException" khi thao tác với DynamoDB
**Giải pháp**:
1. Kiểm tra tên bảng chính xác
2. Đảm bảo bảng đã được tạo trong phần SDLF Foundations
3. Kiểm tra region của bảng

**Vấn đề**: Lỗi "AccessDeniedException" khi tạo Glue Database
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo bạn có quyền truy cập vào Glue
3. Kiểm tra Lake Formation permissions

{{% notice tip %}}
Bạn có thể tạo nhiều datasets khác nhau cho cùng một team bằng cách lặp lại các bước trên với tên dataset khác nhau (ví dụ: dataset-b, dataset-c).
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Thiết lập quyền truy cập](../3-configure-permissions) để quản lý quyền truy cập vào dữ liệu.