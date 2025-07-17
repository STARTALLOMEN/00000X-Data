---
title: "Cấu hình EventBridge"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>5.3 </b>"
---

## Cấu hình EventBridge

Bước cuối cùng trong việc triển khai ETL Pipeline là cấu hình Amazon EventBridge để tự động kích hoạt Step Functions state machine khi có dữ liệu mới được upload vào S3 bucket.

### Các bước thực hiện

#### Bước 1: Lấy ARN của Step Functions state machine

1. Trong CloudShell, nhập lệnh sau để lấy ARN của Step Functions state machine:

```bash
export STATE_MACHINE_ARN=$(aws stepfunctions list-state-machines \
    --query 'stateMachines[?name==`team-a-dataset-a-pipeline`].stateMachineArn' \
    --output text)

echo "State Machine ARN: $STATE_MACHINE_ARN"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy ARN của state machine](../../../static/images/5/3/5.3.1_get_state_machine_arn.png?width=40pc)

3. Bạn sẽ thấy ARN của state machine, ví dụ:
```
State Machine ARN: arn:aws:states:us-east-1:123456789012:stateMachine:team-a-dataset-a-pipeline
```

#### Bước 2: Lấy tên của Data Lake bucket

1. Nhập lệnh sau để lấy tên của Data Lake bucket:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/5/3/5.3.2_get_bucket_name.png?width=40pc)

#### Bước 3: Tạo IAM Role cho EventBridge

1. Nhập lệnh sau để tạo IAM role cho EventBridge:

```bash
# Tạo trust policy
cat > eventbridge-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-eventbridge-role \
    --assume-role-policy-document file://eventbridge-trust-policy.json

# Tạo policy cho EventBridge
cat > eventbridge-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "states:StartExecution"
      ],
      "Resource": "STATE_MACHINE_ARN_PLACEHOLDER"
    }
  ]
}
EOL

# Thay thế placeholder bằng ARN thực tế
sed -i "s|STATE_MACHINE_ARN_PLACEHOLDER|$STATE_MACHINE_ARN|g" eventbridge-policy.json

# Tạo policy
aws iam create-policy \
    --policy-name sdlf-eventbridge-policy \
    --policy-document file://eventbridge-policy.json

# Lấy Account ID
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Gán policy cho role
aws iam attach-role-policy \
    --role-name sdlf-eventbridge-role \
    --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/sdlf-eventbridge-policy
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/5/3/5.3.3_create_iam_role.png?width=40pc)

#### Bước 4: Tạo EventBridge rule

1. Mở AWS Management Console và tìm kiếm "EventBridge"
2. Trong menu bên trái, chọn "Rules"
3. Nhấp vào nút "Create rule"
4. Nhập thông tin cơ bản:
   - Name: team-a-dataset-a-s3-trigger
   - Description: Trigger ETL pipeline when new data is uploaded to S3
   - Event bus: default
5. Trong phần "Rule type", chọn "Rule with an event pattern"

![Tạo EventBridge rule](../../../static/images/5/3/5.3.4_create_rule_1.png?width=40pc)

6. Trong phần "Event pattern", chọn:
   - Event source: AWS services
   - AWS service: Simple Storage Service (S3)
   - Event type: Amazon S3 Event Notification
   - Specific event(s): Object Created
   - Specific bucket(s) by name: Nhập tên Data Lake bucket của bạn
   - Specific prefix(es): raw/team-a/dataset-a/

![Cấu hình event pattern](../../../static/images/5/3/5.3.4_create_rule_2.png?width=40pc)

7. Nhấp vào "Next"
8. Trong phần "Select targets":
   - Target type: AWS service
   - Select a target: Step Functions state machine
   - State machine: team-a-dataset-a-pipeline
   - Execution role: Use existing role
   - Existing role: sdlf-eventbridge-role

![Cấu hình target](../../../static/images/5/3/5.3.4_create_rule_3.png?width=40pc)

9. Trong phần "Configure input":
   - Input type: Input Transformer
   - Input Path:
     ```json
     {"bucket": "$.detail.bucket.name", "team": "team-a", "dataset": "dataset-a"}
     ```
   - Template:
     ```json
     {"bucket": <bucket>, "team": <team>, "dataset": <dataset>}
     ```

![Cấu hình input](../../../static/images/5/3/5.3.4_create_rule_4.png?width=40pc)

10. Nhấp vào "Next"
11. Nhấp vào "Next" lại
12. Nhấp vào "Create rule"

#### Bước 5: Kiểm tra EventBridge rule

1. Trong AWS Management Console, trang EventBridge, chọn "Rules" từ menu bên trái
2. Bạn sẽ thấy rule "team-a-dataset-a-s3-trigger" trong danh sách
3. Nhấp vào rule để xem chi tiết

![Kiểm tra rule](../../../static/images/5/3/5.3.5_check_rule.png?width=40pc)

#### Bước 6: Kiểm tra tự động kích hoạt

1. Trong CloudShell, nhập lệnh sau để tạo một file test và upload lên S3:

```bash
# Tạo file test
echo '{"test": "data"}' > test.json

# Upload file lên S3
aws s3 cp test.json s3://$DATA_LAKE_BUCKET/raw/team-a/dataset-a/
```

2. Nhấn Enter để thực hiện lệnh

![Upload file test](../../../static/images/5/3/5.3.6_upload_test_file.png?width=40pc)

3. Mở AWS Management Console và tìm kiếm "Step Functions"
4. Trong danh sách state machines, tìm "team-a-dataset-a-pipeline"
5. Nhấp vào state machine để xem chi tiết
6. Trong tab "Executions", bạn sẽ thấy một execution mới đã được tạo tự động

![Kiểm tra execution](../../../static/images/5/3/5.3.6_check_execution.png?width=40pc)

7. Nhấp vào execution để xem chi tiết và theo dõi tiến trình

### Xử lý sự cố

**Vấn đề**: EventBridge rule không kích hoạt Step Functions
**Giải pháp**:
1. Kiểm tra event pattern đã được cấu hình đúng chưa
2. Đảm bảo IAM role có quyền kích hoạt Step Functions
3. Kiểm tra S3 bucket và prefix đã được cấu hình đúng chưa

**Vấn đề**: Lỗi "AccessDeniedException" khi EventBridge kích hoạt Step Functions
**Giải pháp**:
1. Kiểm tra IAM role của EventBridge
2. Đảm bảo policy đã được gán cho role
3. Kiểm tra resource ARN trong policy

{{% notice tip %}}
Bạn có thể xem CloudWatch Logs để debug các vấn đề với EventBridge rules. Nhấp vào "Monitoring" tab trong trang chi tiết của rule để xem metrics.
{{% /notice %}}

## Tổng kết

Chúc mừng! Bạn đã hoàn thành việc triển khai ETL Pipeline trong SDLF, bao gồm:

1. Tạo Glue jobs để xử lý và chuyển đổi dữ liệu
2. Thiết lập Step Functions để orchestrate workflow
3. Cấu hình EventBridge để tự động kích hoạt pipeline khi có dữ liệu mới

ETL Pipeline này sẽ tự động xử lý dữ liệu khi có dữ liệu mới được upload vào S3 bucket, chuyển đổi dữ liệu qua các stages và lưu trữ kết quả trong analytics layer.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Nạp và xử lý dữ liệu](../../6-data-ingestion) để kiểm tra ETL pipeline đã triển khai.