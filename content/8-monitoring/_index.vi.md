---
title: "Giám sát và xử lý sự cố"
date: 2024-01-01
weight: 80
chapter: false
pre: "<b>8. </b>"
---

## Thiết lập CloudWatch Dashboard

### Bước 1: Tạo CloudWatch Dashboard

1. Đăng nhập vào AWS Management Console
2. Tìm kiếm "CloudWatch" và chọn dịch vụ CloudWatch
3. Trong menu bên trái, chọn "Dashboards"
4. Nhấp vào "Create dashboard"
5. Nhập tên dashboard: `SDLF-Monitoring-Dashboard`
6. Nhấp vào "Create dashboard"

### Bước 2: Thêm widget giám sát S3

1. Trong màn hình "Add to this dashboard", chọn "Line"
2. Tìm kiếm "S3" trong danh sách metrics
3. Chọn "BucketSizeBytes" và "NumberOfObjects"
4. Chọn bucket data lake của bạn
5. Nhấp vào "Create widget"

### Bước 3: Thêm widget giám sát Lambda

1. Nhấp vào "Add widget"
2. Chọn "Line"
3. Tìm kiếm "Lambda" trong danh sách metrics
4. Chọn "Invocations", "Errors", "Duration" và "Throttles"
5. Chọn tất cả các hàm Lambda có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Create widget"

### Bước 4: Thêm widget giám sát Glue

1. Nhấp vào "Add widget"
2. Chọn "Line"
3. Tìm kiếm "Glue" trong danh sách metrics
4. Chọn "glue.driver.aggregate.numCompletedTasks" và "glue.driver.aggregate.numFailedTasks"
5. Chọn tất cả các Glue jobs có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Create widget"

### Bước 5: Thêm widget giám sát Step Functions

1. Nhấp vào "Add widget"
2. Chọn "Line"
3. Tìm kiếm "Step Functions" trong danh sách metrics
4. Chọn "ExecutionsFailed", "ExecutionsStarted" và "ExecutionsSucceeded"
5. Chọn tất cả các state machines có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Create widget"

### Bước 6: Thêm widget logs

1. Nhấp vào "Add widget"
2. Chọn "Logs"
3. Chọn "Create logs widget"
4. Trong "Select log group(s)", tìm và chọn các log groups có tên bắt đầu bằng "/aws/lambda/sdlf-"
5. Trong "Log query", nhập:
   ```
   fields @timestamp, @message
   | filter @message like "ERROR" or @message like "FAILED"
   | sort @timestamp desc
   | limit 100
   ```
6. Nhấp vào "Create widget"

### Bước 7: Lưu dashboard

1. Nhấp vào "Save dashboard" ở góc trên bên phải
2. Xác nhận lưu dashboard

## Thiết lập CloudWatch Alarms

### Bước 1: Tạo alarm cho Lambda errors

1. Trong CloudWatch, chọn "Alarms" từ menu bên trái
2. Nhấp vào "Create alarm"
3. Nhấp vào "Select metric"
4. Tìm kiếm "Lambda" và chọn "By Function Name"
5. Chọn metric "Errors" cho các hàm Lambda có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Select metric"
7. Cấu hình điều kiện:
   - Chọn "Static"
   - Chọn "Greater than or equal to"
   - Nhập "1" cho threshold
8. Cấu hình Actions:
   - Chọn "In alarm"
   - Chọn "Create new topic"
   - Nhập tên topic: `SDLF-Alerts`
   - Nhập email của bạn
   - Nhấp vào "Create topic"
9. Nhập tên alarm: `SDLF-Lambda-Errors`
10. Nhấp vào "Create alarm"

### Bước 2: Tạo alarm cho Glue job failures

1. Trong CloudWatch, chọn "Alarms" từ menu bên trái
2. Nhấp vào "Create alarm"
3. Nhấp vào "Select metric"
4. Tìm kiếm "Glue" và chọn "Job Metrics"
5. Chọn metric "glue.driver.aggregate.numFailedTasks" cho các Glue jobs có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Select metric"
7. Cấu hình điều kiện:
   - Chọn "Static"
   - Chọn "Greater than or equal to"
   - Nhập "1" cho threshold
8. Cấu hình Actions:
   - Chọn "In alarm"
   - Chọn topic "SDLF-Alerts" đã tạo ở bước trước
9. Nhập tên alarm: `SDLF-Glue-Failures`
10. Nhấp vào "Create alarm"

### Bước 3: Tạo alarm cho Step Functions failures

1. Trong CloudWatch, chọn "Alarms" từ menu bên trái
2. Nhấp vào "Create alarm"
3. Nhấp vào "Select metric"
4. Tìm kiếm "Step Functions" và chọn "Execution Metrics"
5. Chọn metric "ExecutionsFailed" cho các state machines có tên bắt đầu bằng "sdlf-"
6. Nhấp vào "Select metric"
7. Cấu hình điều kiện:
   - Chọn "Static"
   - Chọn "Greater than or equal to"
   - Nhập "1" cho threshold
8. Cấu hình Actions:
   - Chọn "In alarm"
   - Chọn topic "SDLF-Alerts" đã tạo ở bước trước
9. Nhập tên alarm: `SDLF-StepFunctions-Failures`
10. Nhấp vào "Create alarm"

## Thiết lập CloudWatch Logs Insights

### Bước 1: Tạo truy vấn để phân tích lỗi Lambda

1. Trong CloudWatch, chọn "Logs Insights" từ menu bên trái
2. Trong "Select log group(s)", tìm và chọn các log groups có tên bắt đầu bằng "/aws/lambda/sdlf-"
3. Trong trường truy vấn, nhập:
   ```
   fields @timestamp, @message
   | filter @message like "ERROR" or @message like "Exception"
   | parse @message "ERROR * " as error_message
   | stats count(*) as error_count by error_message
   | sort error_count desc
   ```
4. Chọn khoảng thời gian phù hợp (ví dụ: 1 giờ qua)
5. Nhấp vào "Run query"
6. Xem kết quả phân tích lỗi

### Bước 2: Tạo truy vấn để theo dõi thời gian xử lý

1. Trong CloudWatch, chọn "Logs Insights" từ menu bên trái
2. Trong "Select log group(s)", tìm và chọn các log groups có tên bắt đầu bằng "/aws/lambda/sdlf-"
3. Trong trường truy vấn, nhập:
   ```
   fields @timestamp, @message
   | filter @message like "Processing time"
   | parse @message "Processing time: * ms" as processing_time
   | stats avg(processing_time) as avg_time, max(processing_time) as max_time by bin(30m)
   | sort @timestamp desc
   ```
4. Chọn khoảng thời gian phù hợp (ví dụ: 24 giờ qua)
5. Nhấp vào "Run query"
6. Xem kết quả phân tích thời gian xử lý

## Thiết lập EventBridge Rule cho thông báo

### Bước 1: Tạo EventBridge Rule

1. Mở AWS Management Console và tìm kiếm "EventBridge"
2. Chọn "Amazon EventBridge" từ kết quả tìm kiếm
3. Trong menu bên trái, chọn "Rules"
4. Nhấp vào "Create rule"
5. Nhập tên rule: `SDLF-Pipeline-Notifications`
6. Chọn "Rule with an event pattern"
7. Nhấp vào "Next"
8. Trong "Event pattern", chọn "Custom pattern"
9. Nhập pattern sau:
   ```json
   {
     "source": ["aws.states"],
     "detail-type": ["Step Functions Execution Status Change"],
     "detail": {
       "status": ["FAILED", "SUCCEEDED"],
       "stateMachineArn": [{
         "prefix": "arn:aws:states:YOUR_REGION:YOUR_ACCOUNT_ID:stateMachine:sdlf-"
       }]
     }
   }
   ```
   (Thay YOUR_REGION và YOUR_ACCOUNT_ID bằng giá trị thực tế)
10. Nhấp vào "Next"
11. Trong "Target 1", chọn "SNS topic"
12. Chọn topic "SDLF-Alerts" đã tạo trước đó
13. Nhấp vào "Next"
14. Nhấp vào "Next" trong màn hình tags
15. Nhấp vào "Create rule"

## Xử lý sự cố thường gặp

### Sự cố 1: Lambda timeout

1. Mở AWS Management Console và tìm kiếm "Lambda"
2. Chọn hàm Lambda đang gặp sự cố
3. Chọn tab "Configuration"
4. Chọn "General configuration"
5. Nhấp vào "Edit"
6. Tăng giá trị "Timeout" (ví dụ: từ 3 phút lên 5 phút)
7. Nhấp vào "Save"

### Sự cố 2: Glue job fails

1. Mở AWS Management Console và tìm kiếm "Glue"
2. Chọn "Jobs" từ menu bên trái
3. Tìm và chọn Glue job đang gặp sự cố
4. Chọn tab "History"
5. Chọn lần chạy gần nhất bị lỗi
6. Xem "Error logs" để xác định nguyên nhân
7. Dựa vào lỗi, thực hiện các biện pháp khắc phục:
   - Nếu lỗi "Memory limit exceeded": Tăng memory cho job
   - Nếu lỗi "Access denied": Kiểm tra IAM permissions
   - Nếu lỗi "Schema mismatch": Kiểm tra schema của dữ liệu

### Sự cố 3: Step Functions execution fails

1. Mở AWS Management Console và tìm kiếm "Step Functions"
2. Chọn state machine đang gặp sự cố
3. Tìm và chọn execution bị lỗi
4. Xem "Execution event history" để xác định bước bị lỗi
5. Nhấp vào bước bị lỗi để xem chi tiết
6. Dựa vào lỗi, thực hiện các biện pháp khắc phục:
   - Nếu lỗi từ Lambda: Kiểm tra CloudWatch Logs của Lambda
   - Nếu lỗi từ Glue: Kiểm tra Glue job logs
   - Nếu lỗi từ S3: Kiểm tra quyền truy cập S3

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Dọn dẹp tài nguyên](../9-cleanup) để tránh phát sinh chi phí không cần thiết.