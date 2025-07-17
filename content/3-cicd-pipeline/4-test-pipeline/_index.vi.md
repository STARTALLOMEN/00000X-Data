---
title: "Kiểm tra pipeline"
date: 2024-01-01
weight: 4
chapter: false
pre: "<b>3.4 </b>"
---

## Kiểm tra pipeline

Sau khi đã thiết lập CodePipeline, chúng ta cần kiểm tra để đảm bảo pipeline hoạt động như mong đợi.

### Các bước thực hiện

#### Bước 1: Kiểm tra trạng thái pipeline

1. Trong AWS Management Console, tìm kiếm và chọn "CodePipeline"
2. Bạn sẽ thấy danh sách các pipelines đã tạo
3. Kiểm tra trạng thái của từng pipeline:
   - `sdlf-foundations-pipeline`
   - `sdlf-team-pipeline`
   - `sdlf-dataset-pipeline`

![Kiểm tra trạng thái pipeline](../../../static/images/3/4/3.4.1_check_pipeline_status.png?width=40pc)

4. Nếu pipeline đang chạy, bạn sẽ thấy các stages đang trong trạng thái "In progress" hoặc "Succeeded"
5. Nếu pipeline chưa chạy, bạn có thể nhấp vào "Release change" để kích hoạt pipeline thủ công

#### Bước 2: Kích hoạt pipeline thủ công

1. Trong danh sách pipelines, chọn `sdlf-foundations-pipeline`
2. Nhấp vào nút "Release change" ở góc trên bên phải
3. Xác nhận bằng cách nhấp vào "Release"

![Kích hoạt pipeline](../../../static/images/3/4/3.4.2_release_change.png?width=40pc)

4. Pipeline sẽ bắt đầu chạy, bắt đầu từ stage Source
5. Lặp lại các bước trên cho `sdlf-team-pipeline` và `sdlf-dataset-pipeline`

#### Bước 3: Theo dõi tiến trình pipeline

1. Nhấp vào pipeline `sdlf-foundations-pipeline` để xem chi tiết
2. Bạn sẽ thấy tiến trình của từng stage:
   - Source: Lấy mã nguồn từ CodeCommit
   - Build: Build và triển khai mã nguồn

![Theo dõi tiến trình](../../../static/images/3/4/3.4.3_pipeline_progress.png?width=40pc)

3. Nhấp vào "Details" trong stage Build để xem logs của CodeBuild

![Xem logs](../../../static/images/3/4/3.4.3_view_logs.png?width=40pc)

4. Đợi cho đến khi tất cả các stages chuyển sang trạng thái "Succeeded" (màu xanh lá)

#### Bước 4: Kiểm tra kết quả triển khai

1. Sau khi pipeline hoàn thành, kiểm tra xem các tài nguyên đã được triển khai thành công chưa
2. Trong CloudShell, nhập lệnh sau để kiểm tra CloudFormation stacks:

```bash
aws cloudformation list-stacks \
    --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE \
    --query "StackSummaries[?contains(StackName, 'sdlf')].StackName"
```

3. Nhấn Enter để thực hiện lệnh

![Kiểm tra CloudFormation stacks](../../../static/images/3/4/3.4.4_check_stacks.png?width=40pc)

4. Bạn sẽ thấy danh sách các stacks đã được triển khai

#### Bước 5: Thực hiện thay đổi để kiểm tra tự động hóa

1. Trong CloudShell, nhập các lệnh sau để thực hiện thay đổi trong repository:

```bash
cd ~/environment/sdlf-repos/sdlf-foundations

# Thêm một file mới
echo "# SDLF Workshop" > README.md

# Commit và push thay đổi
git add README.md
git commit -m "Add README file"
git push
```

2. Nhấn Enter để thực hiện từng lệnh

![Thực hiện thay đổi](../../../static/images/3/4/3.4.5_make_change.png?width=40pc)

#### Bước 6: Kiểm tra pipeline tự động chạy

1. Quay lại AWS Management Console, trang CodePipeline
2. Chọn `sdlf-foundations-pipeline`
3. Bạn sẽ thấy pipeline đã tự động bắt đầu chạy sau khi có thay đổi trong repository

![Pipeline tự động chạy](../../../static/images/3/4/3.4.6_auto_trigger.png?width=40pc)

4. Đợi cho đến khi pipeline hoàn thành

#### Bước 7: Kiểm tra lịch sử thực thi

1. Trong trang chi tiết của pipeline, nhấp vào tab "History"
2. Bạn sẽ thấy lịch sử các lần thực thi của pipeline, bao gồm cả lần thực thi tự động vừa rồi

![Lịch sử thực thi](../../../static/images/3/4/3.4.7_execution_history.png?width=40pc)

3. Nhấp vào một execution để xem chi tiết

### Xử lý sự cố

**Vấn đề**: Pipeline không tự động chạy khi có thay đổi
**Giải pháp**:
1. Kiểm tra cấu hình source stage của pipeline
2. Đảm bảo webhook đã được thiết lập đúng
3. Thử kích hoạt pipeline thủ công

**Vấn đề**: Build stage fails
**Giải pháp**:
1. Kiểm tra logs của CodeBuild để xác định lỗi
2. Đảm bảo buildspec.yml đã được cấu hình đúng
3. Kiểm tra IAM permissions của CodeBuild role

{{% notice tip %}}
Bạn có thể sử dụng CloudWatch Logs để xem logs chi tiết của CodeBuild. Nhấp vào "Details" trong stage Build và sau đó nhấp vào "View logs in CloudWatch".
{{% /notice %}}

## Tổng kết

Chúc mừng! Bạn đã thiết lập thành công CI/CD pipeline cho SDLF, bao gồm:

1. Tạo CodeCommit repositories để lưu trữ mã nguồn
2. Cấu hình CodeBuild để build và test mã nguồn
3. Thiết lập CodePipeline để tự động hóa quy trình CI/CD
4. Kiểm tra pipeline hoạt động như mong đợi

Với CI/CD pipeline này, bạn có thể dễ dàng triển khai và cập nhật các thành phần của SDLF mỗi khi có thay đổi trong mã nguồn.

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Đăng ký Team và Dataset](../../4-team-dataset) để thiết lập cấu trúc dữ liệu và quyền truy cập.