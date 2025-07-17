---
title: "Mở AWS CloudShell"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>1.2 </b>"
---

## Mở AWS CloudShell

AWS CloudShell là một shell dựa trên trình duyệt, được tích hợp sẵn các công cụ AWS CLI, giúp bạn thực hiện các lệnh AWS mà không cần cài đặt thêm công cụ trên máy tính cá nhân.

### Các bước thực hiện

#### Bước 1: Tìm biểu tượng CloudShell

1. Trong AWS Management Console, nhìn vào thanh điều hướng phía trên
2. Tìm biểu tượng CloudShell (biểu tượng terminal) ở góc trên bên phải, bên cạnh tên tài khoản của bạn
3. Nhấp vào biểu tượng CloudShell

![Tìm biểu tượng CloudShell](../../../static/images/1/2/1.2.1_find_cloudshell.png?width=40pc)

#### Bước 2: Đợi CloudShell khởi động

1. Một cửa sổ mới sẽ mở ra ở phần dưới của màn hình
2. Đợi CloudShell khởi động (có thể mất vài giây)
3. Bạn sẽ thấy thông báo chào mừng và dấu nhắc lệnh

![CloudShell đang khởi động](../../../static/images/1/2/1.2.2_cloudshell_starting.png?width=40pc)

#### Bước 3: Kiểm tra AWS CLI

1. Khi CloudShell đã sẵn sàng, hãy nhập lệnh sau để kiểm tra phiên bản AWS CLI:

```bash
aws --version
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra phiên bản AWS CLI](../../../static/images/1/2/1.2.3_check_aws_cli.png?width=40pc)

3. Bạn sẽ thấy kết quả hiển thị phiên bản AWS CLI, ví dụ:

```
aws-cli/2.13.5 Python/3.11.6 Linux/4.14.326-250.539.amzn2.x86_64 exe/x86_64.amzn.2
```

#### Bước 4: Kiểm tra quyền truy cập

1. Nhập lệnh sau để xác nhận bạn có quyền truy cập cần thiết:

```bash
aws sts get-caller-identity
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra quyền truy cập](../../../static/images/1/2/1.2.4_check_permissions.png?width=40pc)

3. Bạn sẽ thấy kết quả hiển thị thông tin về tài khoản AWS của bạn, ví dụ:

```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/your-username"
}
```

### Các tính năng hữu ích của CloudShell

1. **Tải lên và tải xuống file**:
   - Nhấp vào biểu tượng "Actions" (ba dấu chấm) ở góc trên bên phải của CloudShell
   - Chọn "Upload" để tải file lên hoặc "Download" để tải file xuống

2. **Thay đổi kích thước cửa sổ**:
   - Nhấp vào biểu tượng "Resize" (hai mũi tên) để thay đổi kích thước cửa sổ CloudShell
   - Bạn có thể chọn "Full screen" để mở rộng toàn màn hình

3. **Mở tab mới**:
   - Nhấp vào biểu tượng "New tab" (dấu +) để mở một tab CloudShell mới

![Các tính năng của CloudShell](../../../static/images/1/2/1.2.5_cloudshell_features.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: CloudShell không khởi động
**Giải pháp**:
1. Làm mới trang web
2. Đảm bảo bạn có quyền truy cập vào dịch vụ CloudShell
3. Thử đăng xuất và đăng nhập lại

**Vấn đề**: Lệnh AWS CLI báo lỗi "Access Denied"
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo bạn đang sử dụng tài khoản có quyền AdministratorAccess
3. Kiểm tra lại region hiện tại

{{% notice note %}}
CloudShell có sẵn trong hầu hết các region AWS, nhưng không phải tất cả. Nếu bạn không thấy biểu tượng CloudShell, hãy thử chuyển sang region khác.
{{% /notice %}}

{{% notice tip %}}
CloudShell lưu trữ các file của bạn trong một thư mục home có dung lượng 1GB. Dữ liệu này được giữ lại giữa các phiên làm việc nhưng có thể bị xóa sau một thời gian không hoạt động.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Chọn region phù hợp](../3-region-selection) để thực hiện workshop.