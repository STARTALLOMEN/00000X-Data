---
title: "Đăng nhập vào AWS Management Console"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>1.1 </b>"
---

## Đăng nhập vào AWS Management Console

Bước đầu tiên là đăng nhập vào AWS Management Console để bắt đầu workshop.

### Các bước thực hiện

#### Bước 1: Mở trình duyệt web

1. Mở trình duyệt web của bạn (Chrome, Firefox, Safari hoặc Edge)
2. Nhập địa chỉ: [https://console.aws.amazon.com](https://console.aws.amazon.com)

![Mở trình duyệt web](../../../static/images/1/1/1.1.1_open_browser.png?width=40pc)

#### Bước 2: Nhập thông tin đăng nhập

1. Nếu bạn đã có tài khoản AWS:
   - Nhập địa chỉ email hoặc ID tài khoản AWS
   - Nhấp vào nút **Tiếp theo**
   - Nhập mật khẩu của bạn
   - Nhấp vào nút **Đăng nhập**

2. Nếu bạn là người dùng IAM:
   - Nhập ID tài khoản AWS hoặc alias
   - Nhấp vào nút **Tiếp theo**
   - Nhập tên người dùng IAM
   - Nhập mật khẩu
   - Nhấp vào nút **Đăng nhập**

![Nhập thông tin đăng nhập](../../../static/images/1/1/1.1.2_login_screen.png?width=40pc)

#### Bước 3: Xác minh đăng nhập thành công

Sau khi đăng nhập thành công, bạn sẽ thấy:
- AWS Management Console hiển thị với các dịch vụ AWS
- Tên tài khoản của bạn ở góc trên bên phải
- Region hiện tại ở góc trên bên phải

![AWS Management Console](../../../static/images/1/1/1.1.3_aws_console.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Không thể đăng nhập vào AWS Console
**Giải pháp**: 
1. Kiểm tra lại email/ID tài khoản và mật khẩu
2. Sử dụng tùy chọn "Quên mật khẩu" nếu cần
3. Liên hệ với quản trị viên AWS của bạn nếu vẫn gặp vấn đề

**Vấn đề**: Thông báo "Bạn không có quyền truy cập vào trang này"
**Giải pháp**:
1. Đảm bảo bạn đang sử dụng tài khoản có quyền AdministratorAccess
2. Kiểm tra IAM permissions của bạn
3. Liên hệ với quản trị viên AWS để được cấp thêm quyền

{{% notice note %}}
Nếu bạn đang sử dụng AWS Organizations, có thể bạn cần chọn đúng tài khoản hoặc role trước khi tiếp tục.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Mở AWS CloudShell](../2-cloudshell) để thực hiện các lệnh AWS CLI.