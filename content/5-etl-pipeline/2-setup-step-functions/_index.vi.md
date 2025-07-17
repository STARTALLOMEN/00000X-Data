---
title: "Thiết lập Step Functions"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>5.2 </b>"
---

## Thiết lập Step Functions

Sau khi đã tạo các Glue jobs, chúng ta sẽ thiết lập AWS Step Functions để orchestrate workflow của ETL pipeline.

### Các bước thực hiện

#### Bước 1: Tạo định nghĩa state machine

1. Trong CloudShell, nhập lệnh sau để tạo file định nghĩa state machine:

```bash
cat > state-machine.json << 'EOL'
{
  "Comment": "ETL Pipeline for team-a dataset-a",
  "StartAt": "Stage A",
  "States": {
    "Stage A": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "team-a-dataset-a-stage-a",
        "Arguments": {
          "--team_name.$": "$.team",
          "--dataset_name.$": "$.dataset",
          "--bucket_name.$": "$.bucket"
        }
      },
      "Next": "Stage B"
    },
    "Stage B": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "team-a-dataset-a-stage-b",
        "Arguments": {
          "--team_name.$": "$.team",
          "--dataset_name.$": "$.dataset",
          "--bucket_name.$": "$.bucket"
        }
      },
      "End": true
    }
  }
}
EOL
```

2. Nhấn Enter để thực hiện lệnh

![Tạo định nghĩa state machine](../../../static/images/5/2/5.2.1_create_state_machine_def.png?width=40pc)

#### Bước 2: Tạo IAM Role cho Step Functions

1. Nhập lệnh sau để tạo IAM role cho Step Functions:

```bash
# Tạo trust policy
cat > step-functions-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-step-functions-role \
    --assume-role-policy-document file://step-functions-trust-policy.json

# Tạo policy cho Step Functions
cat > step-functions-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "glue:StartJobRun",
        "glue:GetJobRun",
        "glue:GetJobRuns",
        "glue:BatchStopJobRun"
      ],
      "Resource": "*"
    }
  ]
}
EOL

# Tạo policy
aws iam create-policy \
    --policy-name sdlf-step-functions-policy \
    --policy-document file://step-functions-policy.json

# Lấy Account ID
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Gán policy cho role
aws iam attach-role-policy \
    --role-name sdlf-step-functions-role \
    --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/sdlf-step-functions-policy
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/5/2/5.2.2_create_iam_role.png?width=40pc)

#### Bước 3: Tạo Step Functions state machine

1. Nhập lệnh sau để tạo Step Functions state machine:

```bash
# Lấy ARN của IAM role
export ROLE_ARN=$(aws iam get-role \
    --role-name sdlf-step-functions-role \
    --query 'Role.Arn' \
    --output text)

# Tạo state machine
aws stepfunctions create-state-machine \
    --name team-a-dataset-a-pipeline \
    --definition file://state-machine.json \
    --role-arn $ROLE_ARN
```

2. Nhấn Enter để thực hiện lệnh

![Tạo state machine](../../../static/images/5/2/5.2.3_create_state_machine.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về state machine đã được tạo, bao gồm ARN của state machine

#### Bước 4: Kiểm tra state machine trong AWS Management Console

1. Mở AWS Management Console và tìm kiếm "Step Functions"
2. Trong danh sách state machines, tìm "team-a-dataset-a-pipeline"
3. Nhấp vào state machine để xem chi tiết

![Kiểm tra state machine](../../../static/images/5/2/5.2.4_check_state_machine.png?width=40pc)

4. Bạn sẽ thấy biểu đồ trực quan của workflow, hiển thị các states và transitions

#### Bước 5: Chạy thử state machine

1. Trong trang chi tiết của state machine, nhấp vào nút "Start execution"
2. Trong hộp thoại "Start execution", nhập input JSON sau:

```json
{
  "team": "team-a",
  "dataset": "dataset-a",
  "bucket": "REPLACE_WITH_YOUR_BUCKET_NAME"
}
```

3. Thay thế "REPLACE_WITH_YOUR_BUCKET_NAME" bằng tên Data Lake bucket của bạn
4. Nhấp vào "Start execution"

![Chạy thử state machine](../../../static/images/5/2/5.2.5_test_execution.png?width=40pc)

5. Bạn sẽ thấy execution đang chạy, với biểu đồ trực quan hiển thị tiến trình

{{% notice note %}}
Execution có thể mất vài phút để hoàn thành. Nếu không có dữ liệu trong thư mục raw/team-a/dataset-a/, Glue job vẫn sẽ chạy nhưng không có dữ liệu nào được xử lý.
{{% /notice %}}

#### Bước 6: Kiểm tra kết quả execution

1. Sau khi execution hoàn thành, bạn sẽ thấy trạng thái của từng state (Succeeded hoặc Failed)
2. Nhấp vào từng state để xem chi tiết
3. Bạn có thể xem input và output của mỗi state

![Kiểm tra kết quả](../../../static/images/5/2/5.2.6_check_results.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi tạo state machine
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo IAM role đã được tạo thành công
3. Kiểm tra trust relationship của IAM role

**Vấn đề**: Execution fails với lỗi "Glue job not found"
**Giải pháp**:
1. Kiểm tra tên Glue job chính xác
2. Đảm bảo Glue job đã được tạo thành công
3. Kiểm tra IAM role của Step Functions có quyền truy cập Glue không

{{% notice tip %}}
Bạn có thể xem logs của Step Functions executions trong CloudWatch Logs để debug nếu có lỗi xảy ra.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Cấu hình EventBridge](../3-configure-eventbridge) để tự động kích hoạt ETL pipeline khi có dữ liệu mới.