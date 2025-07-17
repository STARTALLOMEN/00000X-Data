---
title: "Đăng ký team"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>4.1 </b>"
---

## Đăng ký team

Bước đầu tiên trong việc thiết lập cấu trúc dữ liệu là đăng ký team trong SDLF.

### Các bước thực hiện

#### Bước 1: Lấy thông tin Data Lake Bucket

1. Trong CloudShell, nhập lệnh sau để lấy tên của Data Lake bucket:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/4/1/4.1.1_get_bucket_name.png?width=40pc)

3. Bạn sẽ thấy tên của Data Lake bucket, ví dụ:
```
Data Lake Bucket: sdlf-datalake-123456789012-us-east-1
```

#### Bước 2: Đăng ký team trong DynamoDB

1. Nhập lệnh sau để đăng ký team trong bảng DynamoDB sdlf-teams:

```bash
aws dynamodb put-item \
    --table-name sdlf-teams \
    --item '{
        "name": {"S": "team-a"},
        "bucket": {"S": "'$DATA_LAKE_BUCKET'"},
        "prefix": {"S": "team-a"}
    }'
```

2. Nhấn Enter để thực hiện lệnh

![Đăng ký team](../../../static/images/4/1/4.1.2_register_team.png?width=40pc)

3. Nếu lệnh thực hiện thành công, bạn sẽ không thấy output nào

#### Bước 3: Kiểm tra team đã đăng ký

1. Nhập lệnh sau để kiểm tra team đã được đăng ký:

```bash
aws dynamodb scan --table-name sdlf-teams
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra team](../../../static/images/4/1/4.1.3_check_team.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về team đã đăng ký, ví dụ:

```json
{
    "Items": [
        {
            "name": {
                "S": "team-a"
            },
            "bucket": {
                "S": "sdlf-datalake-123456789012-us-east-1"
            },
            "prefix": {
                "S": "team-a"
            }
        }
    ],
    "Count": 1,
    "ScannedCount": 1,
    "ConsumedCapacity": null
}
```

#### Bước 4: Tạo IAM Role cho team

1. Nhập lệnh sau để tạo IAM role cho team:

```bash
# Tạo trust policy
cat > team-role-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-team-a-role \
    --assume-role-policy-document file://team-role-trust-policy.json

# Gán AmazonS3FullAccess policy
aws iam attach-role-policy \
    --role-name sdlf-team-a-role \
    --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

# Gán AWSGlueServiceRole policy
aws iam attach-role-policy \
    --role-name sdlf-team-a-role \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/4/1/4.1.4_create_iam_role.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về IAM role đã được tạo

#### Bước 5: Tạo cấu trúc thư mục trong S3

1. Nhập lệnh sau để tạo cấu trúc thư mục trong S3 bucket:

```bash
# Tạo thư mục raw
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key raw/team-a/

# Tạo thư mục stage
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key stage/team-a/

# Tạo thư mục analytics
aws s3api put-object \
    --bucket $DATA_LAKE_BUCKET \
    --key analytics/team-a/
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo cấu trúc thư mục](../../../static/images/4/1/4.1.5_create_directories.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về các objects đã được tạo, bao gồm ETag

#### Bước 6: Kiểm tra cấu trúc thư mục

1. Nhập lệnh sau để kiểm tra cấu trúc thư mục đã tạo:

```bash
aws s3 ls s3://$DATA_LAKE_BUCKET/ --recursive
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra cấu trúc thư mục](../../../static/images/4/1/4.1.6_check_directories.png?width=40pc)

3. Bạn sẽ thấy danh sách các thư mục đã tạo:
```
analytics/team-a/
raw/team-a/
stage/team-a/
```

### Xử lý sự cố

**Vấn đề**: Lỗi "ResourceNotFoundException" khi truy vấn CloudFormation stack
**Giải pháp**:
1. Kiểm tra tên stack chính xác
2. Đảm bảo bạn đang ở đúng region
3. Kiểm tra xem stack đã được triển khai thành công chưa

**Vấn đề**: Lỗi "ResourceNotFoundException" khi thao tác với DynamoDB
**Giải pháp**:
1. Kiểm tra tên bảng chính xác
2. Đảm bảo bảng đã được tạo trong phần SDLF Foundations
3. Kiểm tra region của bảng

{{% notice tip %}}
Bạn có thể tạo nhiều teams khác nhau bằng cách lặp lại các bước trên với tên team khác nhau (ví dụ: team-b, team-c).
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tạo dataset](../2-create-dataset) để thiết lập cấu trúc dữ liệu cho team.