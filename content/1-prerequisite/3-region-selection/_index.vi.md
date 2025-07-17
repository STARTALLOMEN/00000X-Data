---
title: "Chọn region phù hợp"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>1.3 </b>"
---

## Chọn region phù hợp

Việc chọn đúng AWS region là rất quan trọng để đảm bảo tất cả các dịch vụ cần thiết đều có sẵn và để tối ưu hóa hiệu suất cũng như chi phí.

### Các bước thực hiện

#### Bước 1: Xác định region hiện tại

1. Nhìn vào góc trên bên phải của AWS Management Console
2. Bạn sẽ thấy region hiện tại được hiển thị (ví dụ: "N. Virginia" hoặc "us-east-1")

![Xác định region hiện tại](../../../static/images/1/3/1.3.1_current_region.png?width=40pc)

#### Bước 2: Thay đổi region (nếu cần)

1. Nhấp vào menu dropdown hiển thị region hiện tại
2. Một danh sách các region sẽ hiện ra
3. Chọn một trong các region được khuyến nghị:
   - **US East (N. Virginia)** - us-east-1
   - **US West (Oregon)** - us-west-2
   - **Europe (Ireland)** - eu-west-1
   - **Asia Pacific (Singapore)** - ap-southeast-1

![Thay đổi region](../../../static/images/1/3/1.3.2_change_region.png?width=40pc)

#### Bước 3: Xác nhận region trong CloudShell

1. Trong CloudShell, nhập lệnh sau để xác nhận region hiện tại:

```bash
aws configure get region
```

2. Nhấn Enter để thực hiện lệnh

![Xác nhận region trong CloudShell](../../../static/images/1/3/1.3.3_verify_region.png?width=40pc)

3. Kết quả sẽ hiển thị region hiện tại, ví dụ:

```
us-east-1
```

#### Bước 4: Thiết lập region mặc định (nếu cần)

1. Nếu region hiển thị không phải là region bạn muốn sử dụng, hãy thiết lập region mặc định bằng lệnh:

```bash
aws configure set region us-east-1
```

2. Thay thế `us-east-1` bằng region bạn muốn sử dụng
3. Nhấn Enter để thực hiện lệnh

![Thiết lập region mặc định](../../../static/images/1/3/1.3.4_set_default_region.png?width=40pc)

4. Kiểm tra lại region đã được thiết lập:

```bash
aws configure get region
```

### Các region được khuyến nghị

| Tên region | Mã region | Vị trí |
|------------|-----------|--------|
| US East (N. Virginia) | us-east-1 | Bắc Virginia, Hoa Kỳ |
| US West (Oregon) | us-west-2 | Oregon, Hoa Kỳ |
| Europe (Ireland) | eu-west-1 | Ireland |
| Asia Pacific (Singapore) | ap-southeast-1 | Singapore |

### Xử lý sự cố

**Vấn đề**: Region không thay đổi trong CloudShell sau khi thay đổi trong Console
**Giải pháp**:
1. Đóng và mở lại CloudShell
2. Sử dụng lệnh `aws configure set region` như hướng dẫn ở trên

**Vấn đề**: Một số dịch vụ không có sẵn trong region đã chọn
**Giải pháp**:
1. Chuyển sang region khác được khuyến nghị
2. Ưu tiên sử dụng us-east-1 (N. Virginia) vì đây là region có đầy đủ nhất các dịch vụ AWS

{{% notice warning %}}
Đảm bảo bạn sử dụng cùng một region cho toàn bộ workshop. Việc thay đổi region giữa chừng có thể gây ra lỗi và tăng chi phí do chuyển dữ liệu giữa các region.
{{% /notice %}}

{{% notice tip %}}
Nếu bạn đang ở khu vực châu Á - Thái Bình Dương, hãy cân nhắc sử dụng region ap-southeast-1 (Singapore) để giảm độ trễ. Tuy nhiên, hãy đảm bảo tất cả các dịch vụ cần thiết đều có sẵn trong region này.
{{% /notice %}}

## Bước tiếp theo

Bây giờ bạn đã hoàn thành các bước chuẩn bị, chúng ta sẽ tiếp tục với [Triển khai SDLF Foundations](../../2-foundations) để bắt đầu xây dựng data lake.