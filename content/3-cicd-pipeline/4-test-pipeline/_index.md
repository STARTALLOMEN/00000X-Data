---
title: "3.4 Test Pipeline"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>3.4 </b>"
---

## Test CI/CD Pipeline

Trong bước này, bạn sẽ test pipeline để đảm bảo quy trình CI/CD hoạt động đúng.

### 1. Truy cập CodePipeline
1. Đăng nhập AWS Console
2. Tìm kiếm **CodePipeline** trong thanh tìm kiếm dịch vụ
3. Click **CodePipeline**

![Mở CodePipeline](../../../static/images/3/3.21_OpenCodePipeline.png?width=90pc)

### 2. Chọn Pipeline để test
1. Chọn pipeline `sdlf-workshop-foundations-pipeline`
2. Kiểm tra trạng thái hiện tại

![Chọn Pipeline](../../../static/images/3/3.22_SelectPipeline.png?width=90pc)

### 3. Trigger Pipeline manually
1. Click **Release change**
2. Xác nhận trigger pipeline
3. Theo dõi tiến trình

![Trigger Pipeline](../../../static/images/3/3.23_TriggerPipeline.png?width=90pc)

### 4. Theo dõi Source stage
1. Kiểm tra Source stage chuyển sang màu xanh
2. Xác nhận code được lấy từ repository
3. Kiểm tra commit message và author

![Source Stage](../../../static/images/3/3.24_SourceStage.png?width=90pc)

### 5. Theo dõi Build stage
1. Kiểm tra Build stage bắt đầu
2. Click vào build để xem logs
3. Đảm bảo build thành công

![Build Stage](../../../static/images/3/3.25_BuildStage.png?width=90pc)

### 6. Theo dõi Deploy stage
1. Kiểm tra Deploy stage bắt đầu
2. Theo dõi CloudFormation stack creation
3. Đảm bảo deployment thành công

![Deploy Stage](../../../static/images/3/3.26_DeployStage.png?width=90pc)

### 7. Kiểm tra kết quả
1. Vào **CloudFormation Console**
2. Kiểm tra stack được tạo/update
3. Xác nhận resources được tạo đúng

![Kiểm tra CloudFormation](../../../static/images/3/3.27_CheckCloudFormation.png?width=90pc)

### 8. Test Pipeline thứ hai
1. Chọn pipeline `sdlf-workshop-pipelines-pipeline`
2. Lặp lại các bước 3-7

### 9. Test Pipeline thứ ba
1. Chọn pipeline `sdlf-workshop-teams-pipeline`
2. Lặp lại các bước 3-7

### 10. Kiểm tra logs và troubleshooting
1. Nếu pipeline failed, click vào stage để xem logs
2. Kiểm tra error messages
3. Sửa lỗi và trigger lại

![Troubleshooting](../../../static/images/3/3.28_Troubleshooting.png?width=90pc)

### 11. Xác minh automation
1. Push code changes vào repository
2. Kiểm tra pipeline tự động trigger
3. Xác nhận end-to-end automation

{{% notice note %}}
**Lưu ý**:
- Pipeline sẽ tự động trigger khi có code changes
- Kiểm tra CloudWatch logs nếu có lỗi
- Đảm bảo service roles có đủ quyền
{{% /notice %}} 