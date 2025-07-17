---
title: "Thiết lập quyền truy cập"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>4.3 </b>"
---

## Thiết lập quyền truy cập

Sau khi đã tạo team và dataset, chúng ta cần thiết lập quyền truy cập để quản lý quyền truy cập vào dữ liệu.

### Các bước thực hiện

#### Bước 1: Thiết lập Lake Formation permissions

1. Mở AWS Management Console và tìm kiếm "Lake Formation"
2. Trong menu bên trái, chọn "Permissions" > "Data lake permissions"
3. Nhấp vào nút "Grant"

![Mở Lake Formation](../../../static/images/4/3/4.3.1_open_lake_formation.png?width=40pc)

4. Trong phần "Principals", chọn "IAM users and roles"
5. Chọn role "sdlf-team-a-role" từ danh sách

![Chọn IAM role](../../../static/images/4/3/4.3.2_select_iam_role.png?width=40pc)

6. Trong phần "LF-Tags or catalog resources", chọn "Named data catalog resources"
7. Trong phần "Databases", chọn "team_a_db" từ danh sách
8. Trong phần "Tables", chọn "All tables"
9. Trong phần "Table permissions", chọn các quyền sau:
   - Select
   - Describe
   - Alter
   - Drop
   - Delete
   - Insert

![Thiết lập permissions](../../../static/images/4/3/4.3.3_set_permissions.png?width=40pc)

10. Nhấp vào nút "Grant" để cấp quyền

#### Bước 2: Thiết lập S3 bucket policy

1. Trong CloudShell, nhập lệnh sau để lấy tên của Data Lake bucket (nếu bạn chưa thực hiện ở bước trước):

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/4/3/4.3.4_get_bucket_name.png?width=40pc)

3. Nhập lệnh sau để lấy ARN của IAM role:

```bash
export TEAM_ROLE_ARN=$(aws iam get-role \
    --role-name sdlf-team-a-role \
    --query 'Role.Arn' \
    --output text)

echo "Team Role ARN: $TEAM_ROLE_ARN"
```

4. Nhấn Enter để thực hiện lệnh

![Lấy ARN của IAM role](../../../static/images/4/3/4.3.5_get_role_arn.png?width=40pc)

5. Nhập lệnh sau để tạo bucket policy:

```bash
cat > bucket-policy.json << EOL
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "$TEAM_ROLE_ARN"
      },
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::$DATA_LAKE_BUCKET",
        "arn:aws:s3:::$DATA_LAKE_BUCKET/raw/team-a/*",
        "arn:aws:s3:::$DATA_LAKE_BUCKET/stage/team-a/*",
        "arn:aws:s3:::$DATA_LAKE_BUCKET/analytics/team-a/*"
      ]
    }
  ]
}
EOL
```

6. Nhấn Enter để thực hiện lệnh

![Tạo bucket policy](../../../static/images/4/3/4.3.6_create_bucket_policy.png?width=40pc)

7. Nhập lệnh sau để áp dụng bucket policy:

```bash
aws s3api put-bucket-policy \
    --bucket $DATA_LAKE_BUCKET \
    --policy file://bucket-policy.json
```

8. Nhấn Enter để thực hiện lệnh

![Áp dụng bucket policy](../../../static/images/4/3/4.3.7_apply_bucket_policy.png?width=40pc)

9. Nếu lệnh thực hiện thành công, bạn sẽ không thấy output nào

#### Bước 3: Kiểm tra bucket policy

1. Nhập lệnh sau để kiểm tra bucket policy đã được áp dụng:

```bash
aws s3api get-bucket-policy --bucket $DATA_LAKE_BUCKET
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra bucket policy](../../../static/images/4/3/4.3.8_check_bucket_policy.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về bucket policy đã được áp dụng

#### Bước 4: Kiểm tra Lake Formation permissions

1. Trong AWS Management Console, tìm kiếm "Lake Formation"
2. Trong menu bên trái, chọn "Permissions" > "Data lake permissions"
3. Tìm kiếm role "sdlf-team-a-role" trong danh sách
4. Kiểm tra xem role đã được cấp quyền truy cập vào database "team_a_db" chưa

![Kiểm tra Lake Formation permissions](../../../static/images/4/3/4.3.9_check_lake_formation.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi thiết lập Lake Formation permissions
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo bạn có quyền truy cập vào Lake Formation
3. Kiểm tra xem bạn có quyền cấp permissions không

**Vấn đề**: Lỗi "MalformedPolicy" khi áp dụng bucket policy
**Giải pháp**:
1. Kiểm tra cú pháp của policy
2. Đảm bảo ARN của role và bucket là chính xác
3. Kiểm tra xem policy có vượt quá kích thước tối đa không

{{% notice warning %}}
Trong môi trường production, bạn nên áp dụng nguyên tắc least privilege (quyền tối thiểu cần thiết) khi thiết lập quyền truy cập. Trong workshop này, chúng ta cấp quyền rộng hơn để đơn giản hóa quá trình.
{{% /notice %}}

## Tổng kết

Chúc mừng! Bạn đã hoàn thành việc đăng ký team và dataset trong SDLF, bao gồm:

1. Đăng ký team trong DynamoDB
2. Tạo dataset trong DynamoDB
3. Tạo cấu trúc thư mục trong S3
4. Tạo Glue Database
5. Thiết lập quyền truy cập thông qua Lake Formation và S3 bucket policy

Các bước này đã thiết lập cấu trúc dữ liệu và quyền truy cập cần thiết cho SDLF.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Triển khai ETL Pipeline](../../5-etl-pipeline) để xử lý và chuyển đổi dữ liệu.