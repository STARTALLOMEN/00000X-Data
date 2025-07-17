---
title: "Kiểm tra kết quả triển khai"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>2.4 </b>"
---

## Kiểm tra kết quả triển khai

Sau khi triển khai SDLF Foundations thành công, chúng ta cần kiểm tra các tài nguyên đã được tạo để đảm bảo mọi thứ hoạt động như mong đợi.

### Các bước thực hiện

#### Bước 1: Kiểm tra CloudFormation Outputs

1. Trong CloudShell, nhập lệnh sau để xem outputs của CloudFormation stack:

```bash
aws cloudformation describe-stacks --stack-name sdlf-foundations-stack --query 'Stacks[0].Outputs'
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra CloudFormation Outputs](../../../static/images/2/4/2.4.1_check_outputs.png?width=40pc)

3. Bạn sẽ thấy danh sách các outputs quan trọng, bao gồm:
   - `DataLakeBucketName`: Tên của S3 bucket chính cho data lake
   - `ArtifactsBucketName`: Tên của S3 bucket chứa artifacts
   - `StagingBucketName`: Tên của S3 bucket cho staging data
   - `CentralBucketName`: Tên của S3 bucket trung tâm
   - Và các outputs khác

4. Lưu lại các giá trị này vì chúng sẽ được sử dụng trong các phần tiếp theo

#### Bước 2: Kiểm tra S3 Buckets

1. Nhập lệnh sau để lấy tên của Data Lake bucket:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks --stack-name sdlf-foundations-stack --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' --output text)
echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/2/4/2.4.2_get_bucket_name.png?width=40pc)

3. Kiểm tra xem bucket đã được tạo thành công:

```bash
aws s3 ls s3://$DATA_LAKE_BUCKET
```

4. Nhấn Enter để thực hiện lệnh

![Kiểm tra bucket](../../../static/images/2/4/2.4.2_check_bucket.png?width=40pc)

5. Bạn sẽ thấy danh sách các thư mục trong bucket (có thể trống nếu bucket mới được tạo)

#### Bước 3: Kiểm tra DynamoDB Tables

1. Nhập lệnh sau để liệt kê các DynamoDB tables đã được tạo:

```bash
aws dynamodb list-tables
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra DynamoDB Tables](../../../static/images/2/4/2.4.3_check_dynamodb.png?width=40pc)

3. Bạn sẽ thấy danh sách các tables, bao gồm:
   - `sdlf-metadata`
   - `sdlf-teams`
   - `sdlf-datasets`
   - `sdlf-pipeline-execution`
   - Và các tables khác

#### Bước 4: Kiểm tra IAM Roles

1. Nhập lệnh sau để liệt kê các IAM roles liên quan đến SDLF:

```bash
aws iam list-roles --query 'Roles[?contains(RoleName, `sdlf`)].RoleName'
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra IAM Roles](../../../static/images/2/4/2.4.4_check_iam_roles.png?width=40pc)

3. Bạn sẽ thấy danh sách các IAM roles đã được tạo cho SDLF

#### Bước 5: Kiểm tra Lake Formation

1. Nhập lệnh sau để kiểm tra Lake Formation Data Lake Settings:

```bash
aws lakeformation get-data-lake-settings
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra Lake Formation](../../../static/images/2/4/2.4.5_check_lake_formation.png?width=40pc)

3. Bạn sẽ thấy thông tin về Data Lake Settings, bao gồm các admins và các cài đặt khác

#### Bước 6: Kiểm tra qua AWS Management Console

1. Mở tab mới trong trình duyệt
2. Truy cập AWS Management Console
3. Tìm kiếm và chọn "S3"
4. Kiểm tra xem các buckets sau đã được tạo:
   - sdlf-datalake-[account-id]-[region]
   - sdlf-artifacts-[account-id]-[region]
   - sdlf-staging-[account-id]-[region]
   - sdlf-central-[account-id]-[region]

![Kiểm tra S3 trong Console](../../../static/images/2/4/2.4.6_console_s3.png?width=40pc)

5. Tìm kiếm và chọn "DynamoDB"
6. Kiểm tra xem các tables đã được liệt kê ở Bước 3 đã được tạo

![Kiểm tra DynamoDB trong Console](../../../static/images/2/4/2.4.6_console_dynamodb.png?width=40pc)

7. Tìm kiếm và chọn "Lake Formation"
8. Kiểm tra xem Data Lake đã được thiết lập

![Kiểm tra Lake Formation trong Console](../../../static/images/2/4/2.4.6_console_lake_formation.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Không thấy một số tài nguyên đã được tạo
**Giải pháp**:
1. Kiểm tra lại region hiện tại, đảm bảo bạn đang ở cùng region với nơi triển khai SDLF
2. Kiểm tra CloudFormation stack status để đảm bảo triển khai đã hoàn tất
3. Kiểm tra CloudWatch Logs để tìm lỗi trong quá trình triển khai

**Vấn đề**: Lỗi khi truy cập S3 buckets
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo tên bucket chính xác (phân biệt chữ hoa chữ thường)
3. Kiểm tra bucket policy và ACLs

{{% notice tip %}}
Lưu lại các giá trị từ CloudFormation outputs (đặc biệt là tên các S3 buckets) vì chúng sẽ được sử dụng nhiều lần trong các phần tiếp theo của workshop.
{{% /notice %}}

## Tổng kết

Chúc mừng! Bạn đã triển khai thành công SDLF Foundations, bao gồm:

1. Các S3 buckets cho data lake
2. DynamoDB tables cho metadata
3. IAM roles và policies
4. Lake Formation settings
5. Các tài nguyên khác cần thiết cho SDLF

Các tài nguyên này tạo thành cơ sở hạ tầng cơ bản cho Serverless Data Lake Framework, và bạn sẽ xây dựng trên nền tảng này trong các phần tiếp theo.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Thiết lập CI/CD Pipeline](../../3-cicd-pipeline) để tự động hóa việc triển khai các thành phần khác của SDLF.