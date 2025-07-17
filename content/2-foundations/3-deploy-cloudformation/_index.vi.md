---
title: "Triển khai CloudFormation"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>2.3 </b>"
---

## Triển khai CloudFormation

Sau khi đã cấu hình parameters, chúng ta sẽ triển khai SDLF Foundations bằng AWS CloudFormation.

### Các bước thực hiện

#### Bước 1: Kiểm tra script triển khai

1. Trong CloudShell, đảm bảo bạn đang ở thư mục sdlf-foundations:

```bash
cd ~/environment/sdlf-workshop/aws-serverless-data-lake-framework/sdlf-foundations
```

2. Nhập lệnh sau để xem nội dung script triển khai:

```bash
cat deploy.sh
```

3. Nhấn Enter để thực hiện lệnh

![Kiểm tra script triển khai](../../../static/images/2/3/2.3.1_check_deploy_script.png?width=40pc)

4. Bạn sẽ thấy nội dung của script deploy.sh, đây là script sẽ triển khai SDLF Foundations thông qua CloudFormation

#### Bước 2: Cấp quyền thực thi cho script

1. Nhập lệnh sau để cấp quyền thực thi cho script deploy.sh:

```bash
chmod +x deploy.sh
```

2. Nhấn Enter để thực hiện lệnh

![Cấp quyền thực thi](../../../static/images/2/3/2.3.2_chmod_script.png?width=40pc)

#### Bước 3: Chạy script triển khai

1. Nhập lệnh sau để chạy script triển khai:

```bash
./deploy.sh
```

2. Nhấn Enter để thực hiện lệnh

![Chạy script triển khai](../../../static/images/2/3/2.3.3_run_deploy_script.png?width=40pc)

3. Script sẽ bắt đầu triển khai SDLF Foundations. Quá trình này có thể mất khoảng 15-20 phút.

4. Bạn sẽ thấy các thông báo về tiến trình triển khai, ví dụ:

```
Deploying SDLF Foundations...
Creating CloudFormation stack: sdlf-foundations-stack
Waiting for stack creation to complete...
```

#### Bước 4: Theo dõi tiến trình triển khai

1. Trong khi đợi script hoàn thành, bạn có thể mở tab mới trong CloudShell để theo dõi tiến trình triển khai:

```bash
aws cloudformation describe-stacks --stack-name sdlf-foundations-stack --query 'Stacks[0].StackStatus'
```

2. Nhấn Enter để thực hiện lệnh

![Theo dõi tiến trình](../../../static/images/2/3/2.3.4_check_progress.png?width=40pc)

3. Bạn sẽ thấy trạng thái hiện tại của stack, ví dụ:
   - `"CREATE_IN_PROGRESS"`: Stack đang được tạo
   - `"CREATE_COMPLETE"`: Stack đã được tạo thành công

4. Bạn cũng có thể theo dõi tiến trình triển khai thông qua AWS Management Console:
   - Mở tab mới trong trình duyệt
   - Truy cập AWS Management Console
   - Tìm kiếm và chọn "CloudFormation"
   - Chọn stack "sdlf-foundations-stack" trong danh sách
   - Xem tab "Events" để theo dõi các sự kiện triển khai

![Theo dõi trong Console](../../../static/images/2/3/2.3.4_console_progress.png?width=40pc)

#### Bước 5: Xác nhận triển khai thành công

1. Sau khi script hoàn thành, bạn sẽ thấy thông báo thành công:

```
SDLF Foundations deployment completed successfully!
```

2. Để xác nhận stack đã được tạo thành công, nhập lệnh:

```bash
aws cloudformation describe-stacks --stack-name sdlf-foundations-stack --query 'Stacks[0].StackStatus'
```

3. Nhấn Enter để thực hiện lệnh

![Xác nhận triển khai thành công](../../../static/images/2/3/2.3.5_confirm_success.png?width=40pc)

4. Kết quả sẽ hiển thị `"CREATE_COMPLETE"` nếu stack đã được tạo thành công

### Xử lý sự cố

**Vấn đề**: Stack creation fails với lỗi "Access Denied"
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo bạn đang sử dụng tài khoản có quyền AdministratorAccess
3. Kiểm tra lại region và account ID trong file parameters-dev.json

**Vấn đề**: Stack creation fails với lỗi "Resource already exists"
**Giải pháp**:
1. Kiểm tra xem bạn đã có stack với tên tương tự chưa
2. Thay đổi tên bucket trong file parameters-dev.json vì bucket names phải là duy nhất trên toàn cầu
3. Xóa stack hiện tại (nếu có) và thử lại

**Vấn đề**: Script deploy.sh không thực thi
**Giải pháp**:
1. Đảm bảo bạn đã cấp quyền thực thi: `chmod +x deploy.sh`
2. Thử chạy với bash: `bash deploy.sh`

{{% notice warning %}}
Quá trình triển khai có thể mất khoảng 15-20 phút. Đừng dừng script giữa chừng vì điều này có thể dẫn đến tình trạng stack không hoàn chỉnh.
{{% /notice %}}

{{% notice tip %}}
Nếu bạn gặp lỗi trong quá trình triển khai, hãy kiểm tra CloudWatch Logs để biết thêm chi tiết. Các logs thường được lưu trong log group có tên bắt đầu bằng "/aws/cloudformation/".
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Kiểm tra kết quả triển khai](../4-verify-deployment) để đảm bảo SDLF Foundations đã được triển khai thành công.