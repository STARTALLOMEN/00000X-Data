---
title: "Dọn dẹp tài nguyên"
date: 2024-01-01
weight: 90
chapter: false
pre: "<b>9. </b>"
---

## Xóa dữ liệu trong S3 buckets

### Bước 1: Xóa dữ liệu trong S3 buckets

1. Mở AWS Management Console và tìm kiếm "S3"
2. Chọn "Amazon S3" từ kết quả tìm kiếm
3. Tìm bucket data lake của bạn (có tên bắt đầu bằng "sdlf-")
4. Chạy lệnh sau trong CloudShell để xóa tất cả dữ liệu trong bucket:

```bash
# Lấy tên bucket từ CloudFormation outputs
DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

# Xóa tất cả objects trong bucket
echo "Xóa tất cả objects trong bucket $DATA_LAKE_BUCKET"
aws s3 rm s3://$DATA_LAKE_BUCKET --recursive

# Xóa tất cả objects trong artifact bucket
ARTIFACT_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-cicd-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`ArtifactBucketName`].OutputValue' \
    --output text 2>/dev/null)

if [ ! -z "$ARTIFACT_BUCKET" ]; then
    echo "Xóa tất cả objects trong bucket $ARTIFACT_BUCKET"
    aws s3 rm s3://$ARTIFACT_BUCKET --recursive
fi
```

## Xóa CloudWatch Dashboards và Alarms

### Bước 1: Xóa CloudWatch Dashboards

1. Mở AWS Management Console và tìm kiếm "CloudWatch"
2. Chọn "CloudWatch" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Dashboards"
4. Tìm và chọn dashboard "SDLF-Monitoring-Dashboard"
5. Nhấp vào "Actions" và chọn "Delete"
6. Xác nhận xóa dashboard

### Bước 2: Xóa CloudWatch Alarms

1. Trong CloudWatch, chọn "Alarms" từ menu bên trái
2. Tìm và chọn các alarms có tên bắt đầu bằng "SDLF-" (có thể chọn nhiều alarm bằng cách giữ Ctrl và nhấp chuột)
3. Nhấp vào "Actions" và chọn "Delete"
4. Xác nhận xóa alarms

### Bước 3: Xóa SNS Topics

1. Mở AWS Management Console và tìm kiếm "SNS"
2. Chọn "Simple Notification Service" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Topics"
4. Tìm và chọn topic "SDLF-Alerts"
5. Nhấp vào "Delete"
6. Nhập "delete me" vào trường xác nhận
7. Nhấp vào "Delete"

## Xóa EventBridge Rules

### Bước 1: Xóa EventBridge Rules

1. Mở AWS Management Console và tìm kiếm "EventBridge"
2. Chọn "Amazon EventBridge" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Rules"
4. Tìm và chọn rule "SDLF-Pipeline-Notifications"
5. Nhấp vào "Delete"
6. Xác nhận xóa rule

## Xóa CloudFormation Stacks

### Bước 1: Xóa ETL Pipeline Stack

1. Mở AWS Management Console và tìm kiếm "CloudFormation"
2. Chọn "CloudFormation" từ kết quả tìm kiếm
3. Tìm stack có tên "sdlf-team-a-dataset-a-glue-stack" hoặc tương tự
4. Chọn stack và nhấp vào "Delete"
5. Xác nhận xóa stack
6. Đợi stack bị xóa hoàn toàn (trạng thái "DELETE_COMPLETE")

### Bước 2: Xóa Dataset Stack

1. Tìm stack có tên "sdlf-team-a-dataset-a-stack" hoặc tương tự
2. Chọn stack và nhấp vào "Delete"
3. Xác nhận xóa stack
4. Đợi stack bị xóa hoàn toàn (trạng thái "DELETE_COMPLETE")

### Bước 3: Xóa Team Stack

1. Tìm stack có tên "sdlf-team-a-stack" hoặc tương tự
2. Chọn stack và nhấp vào "Delete"
3. Xác nhận xóa stack
4. Đợi stack bị xóa hoàn toàn (trạng thái "DELETE_COMPLETE")

### Bước 4: Xóa CI/CD Stack

1. Tìm stack có tên "sdlf-cicd-stack"
2. Chọn stack và nhấp vào "Delete"
3. Xác nhận xóa stack
4. Đợi stack bị xóa hoàn toàn (trạng thái "DELETE_COMPLETE")

### Bước 5: Xóa Foundations Stack

1. Tìm stack có tên "sdlf-foundations-stack"
2. Chọn stack và nhấp vào "Delete"
3. Xác nhận xóa stack
4. Đợi stack bị xóa hoàn toàn (trạng thái "DELETE_COMPLETE")

## Xóa CodeCommit Repositories

### Bước 1: Xóa CodeCommit Repositories

1. Mở AWS Management Console và tìm kiếm "CodeCommit"
2. Chọn "AWS CodeCommit" từ kết quả tìm kiếm
3. Tìm và chọn repository có tên bắt đầu bằng "sdlf-"
4. Nhấp vào "Delete repository"
5. Nhập tên repository để xác nhận
6. Nhấp vào "Delete"
7. Lặp lại cho tất cả các repositories có tên bắt đầu bằng "sdlf-"

## Xóa IAM Roles và Policies

### Bước 1: Xóa IAM Roles

1. Mở AWS Management Console và tìm kiếm "IAM"
2. Chọn "IAM" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Roles"
4. Tìm và chọn các roles có tên chứa "sdlf" hoặc "SDLF"
5. Nhấp vào "Delete"
6. Nhập tên role để xác nhận
7. Nhấp vào "Delete"
8. Lặp lại cho tất cả các roles có tên chứa "sdlf" hoặc "SDLF"

### Bước 2: Xóa IAM Policies

1. Trong IAM, chọn "Policies" từ menu bên trái
2. Tìm và chọn các policies có tên chứa "sdlf" hoặc "SDLF"
3. Nhấp vào "Actions" và chọn "Delete"
4. Nhập tên policy để xác nhận
5. Nhấp vào "Delete"
6. Lặp lại cho tất cả các policies có tên chứa "sdlf" hoặc "SDLF"

## Xóa Glue Databases và Tables

### Bước 1: Xóa Glue Databases và Tables

1. Mở AWS Management Console và tìm kiếm "Glue"
2. Chọn "AWS Glue" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Databases"
4. Tìm và chọn database "team_a_db" hoặc tương tự
5. Nhấp vào "Actions" và chọn "Delete database"
6. Chọn "Delete all tables in the database" nếu có
7. Nhấp vào "Delete"

## Xóa Athena Workgroups

### Bước 1: Xóa Athena Workgroups

1. Mở AWS Management Console và tìm kiếm "Athena"
2. Chọn "Amazon Athena" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Workgroups"
4. Tìm và chọn workgroup "analytics-team-workgroup"
5. Nhấp vào "Actions" và chọn "Delete workgroup"
6. Nhập tên workgroup để xác nhận
7. Nhấp vào "Delete"

## Xác nhận tất cả tài nguyên đã được xóa

### Bước 1: Kiểm tra CloudFormation Stacks

1. Mở AWS Management Console và tìm kiếm "CloudFormation"
2. Chọn "CloudFormation" từ kết quả tìm kiếm
3. Xác nhận không còn stack nào có tên bắt đầu bằng "sdlf-" (trừ những stack có trạng thái "DELETE_COMPLETE")

### Bước 2: Kiểm tra S3 Buckets

1. Mở AWS Management Console và tìm kiếm "S3"
2. Chọn "Amazon S3" từ kết quả tìm kiếm
3. Xác nhận không còn bucket nào có tên bắt đầu bằng "sdlf-"

### Bước 3: Kiểm tra Lambda Functions

1. Mở AWS Management Console và tìm kiếm "Lambda"
2. Chọn "AWS Lambda" từ kết quả tìm kiếm
3. Xác nhận không còn function nào có tên bắt đầu bằng "sdlf-"

### Bước 4: Kiểm tra Glue Jobs

1. Mở AWS Management Console và tìm kiếm "Glue"
2. Chọn "AWS Glue" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Jobs"
4. Xác nhận không còn job nào có tên bắt đầu bằng "sdlf-"

## Script tự động dọn dẹp

Nếu bạn muốn tự động hóa quá trình dọn dẹp, bạn có thể sử dụng script sau trong CloudShell:

```bash
#!/bin/bash

echo "Bắt đầu quá trình dọn dẹp tài nguyên SDLF..."

# Xóa dữ liệu trong S3 buckets
echo "Xóa dữ liệu trong S3 buckets..."
DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text 2>/dev/null)

if [ ! -z "$DATA_LAKE_BUCKET" ]; then
    echo "Xóa tất cả objects trong bucket $DATA_LAKE_BUCKET"
    aws s3 rm s3://$DATA_LAKE_BUCKET --recursive
fi

ARTIFACT_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-cicd-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`ArtifactBucketName`].OutputValue' \
    --output text 2>/dev/null)

if [ ! -z "$ARTIFACT_BUCKET" ]; then
    echo "Xóa tất cả objects trong bucket $ARTIFACT_BUCKET"
    aws s3 rm s3://$ARTIFACT_BUCKET --recursive
fi

# Xóa CloudWatch Dashboards
echo "Xóa CloudWatch Dashboards..."
aws cloudwatch delete-dashboards --dashboard-names "SDLF-Monitoring-Dashboard"

# Xóa CloudWatch Alarms
echo "Xóa CloudWatch Alarms..."
for alarm in $(aws cloudwatch describe-alarms --query "MetricAlarms[?starts_with(AlarmName, 'SDLF-')].AlarmName" --output text); do
    echo "Xóa alarm $alarm"
    aws cloudwatch delete-alarms --alarm-names "$alarm"
done

# Xóa SNS Topics
echo "Xóa SNS Topics..."
for topic in $(aws sns list-topics --query "Topics[?contains(TopicArn, 'SDLF-Alerts')].TopicArn" --output text); do
    echo "Xóa topic $topic"
    aws sns delete-topic --topic-arn "$topic"
done

# Xóa EventBridge Rules
echo "Xóa EventBridge Rules..."
for rule in $(aws events list-rules --query "Rules[?Name=='SDLF-Pipeline-Notifications'].Name" --output text); do
    echo "Xóa rule $rule"
    aws events remove-targets --rule "$rule" --ids "1"
    aws events delete-rule --name "$rule"
done

# Xóa CloudFormation Stacks
echo "Xóa CloudFormation Stacks..."

# Xóa ETL Pipeline Stacks
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query "StackSummaries[?contains(StackName, 'sdlf') && contains(StackName, 'glue')].StackName" --output text); do
    echo "Xóa stack $stack"
    aws cloudformation delete-stack --stack-name "$stack"
done

# Đợi ETL Pipeline Stacks bị xóa
echo "Đợi ETL Pipeline Stacks bị xóa..."
sleep 60

# Xóa Dataset Stacks
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query "StackSummaries[?contains(StackName, 'sdlf') && contains(StackName, 'dataset')].StackName" --output text); do
    echo "Xóa stack $stack"
    aws cloudformation delete-stack --stack-name "$stack"
done

# Đợi Dataset Stacks bị xóa
echo "Đợi Dataset Stacks bị xóa..."
sleep 60

# Xóa Team Stacks
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query "StackSummaries[?contains(StackName, 'sdlf') && contains(StackName, 'team')].StackName" --output text); do
    echo "Xóa stack $stack"
    aws cloudformation delete-stack --stack-name "$stack"
done

# Đợi Team Stacks bị xóa
echo "Đợi Team Stacks bị xóa..."
sleep 60

# Xóa CI/CD Stack
if aws cloudformation describe-stacks --stack-name sdlf-cicd-stack &>/dev/null; then
    echo "Xóa stack sdlf-cicd-stack"
    aws cloudformation delete-stack --stack-name sdlf-cicd-stack
    
    # Đợi CI/CD Stack bị xóa
    echo "Đợi CI/CD Stack bị xóa..."
    sleep 60
fi

# Xóa Foundations Stack
if aws cloudformation describe-stacks --stack-name sdlf-foundations-stack &>/dev/null; then
    echo "Xóa stack sdlf-foundations-stack"
    aws cloudformation delete-stack --stack-name sdlf-foundations-stack
fi

# Xóa CodeCommit Repositories
echo "Xóa CodeCommit Repositories..."
for repo in $(aws codecommit list-repositories --query "repositories[?contains(repositoryName, 'sdlf')].repositoryName" --output text); do
    echo "Xóa repository $repo"
    aws codecommit delete-repository --repository-name "$repo"
done

# Xóa Glue Databases
echo "Xóa Glue Databases..."
for db in $(aws glue get-databases --query "DatabaseList[?contains(Name, 'team_')].Name" --output text); do
    echo "Xóa database $db"
    aws glue delete-database --name "$db"
done

# Xóa Athena Workgroups
echo "Xóa Athena Workgroups..."
if aws athena get-work-group --work-group analytics-team-workgroup &>/dev/null; then
    echo "Xóa workgroup analytics-team-workgroup"
    aws athena delete-work-group --work-group analytics-team-workgroup --recursive-delete-option
fi

echo "Quá trình dọn dẹp đã hoàn tất!"
```

Để sử dụng script này:
1. Mở CloudShell
2. Tạo file script:
   ```bash
   nano cleanup-sdlf.sh
   ```
3. Sao chép và dán script vào editor
4. Nhấn Ctrl+X, sau đó Y và Enter để lưu
5. Cấp quyền thực thi cho script:
   ```bash
   chmod +x cleanup-sdlf.sh
   ```
6. Chạy script:
   ```bash
   ./cleanup-sdlf.sh
   ```

{{% notice warning %}}
Script này sẽ xóa tất cả tài nguyên liên quan đến SDLF. Đảm bảo bạn đã sao lưu bất kỳ dữ liệu quan trọng nào trước khi chạy script.
{{% /notice %}}

## Kết thúc Workshop

Chúc mừng! Bạn đã hoàn thành workshop về Serverless Data Lake Framework (SDLF). Trong workshop này, bạn đã:

1. Thiết lập cơ sở hạ tầng cho data lake serverless
2. Triển khai CI/CD pipeline cho quản lý mã nguồn
3. Đăng ký team và dataset
4. Triển khai ETL pipeline
5. Nạp và xử lý dữ liệu
6. Truy vấn dữ liệu với Athena
7. Thiết lập giám sát và cảnh báo
8. Dọn dẹp tài nguyên

Những kiến thức và kỹ năng bạn đã học trong workshop này có thể được áp dụng để xây dựng các data lake serverless cho các dự án thực tế.