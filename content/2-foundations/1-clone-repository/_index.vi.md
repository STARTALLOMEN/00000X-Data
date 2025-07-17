---
title: "Clone repository SDLF"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>2.1 </b>"
---

## Clone repository SDLF

Bước đầu tiên để triển khai SDLF Foundations là clone repository chính thức của SDLF từ GitHub.

### Các bước thực hiện

#### Bước 1: Tạo thư mục làm việc trong CloudShell

1. Trong CloudShell, nhập các lệnh sau để tạo và di chuyển đến thư mục làm việc:

```bash
mkdir -p ~/environment/sdlf-workshop
cd ~/environment/sdlf-workshop
```

2. Nhấn Enter để thực hiện lệnh

![Tạo thư mục làm việc](../../../static/images/2/1/2.1.1_create_directory.png?width=40pc)

#### Bước 2: Clone repository SDLF từ GitHub

1. Nhập lệnh sau để clone repository SDLF:

```bash
git clone https://github.com/awslabs/aws-serverless-data-lake-framework.git
```

2. Nhấn Enter để thực hiện lệnh

![Clone repository](../../../static/images/2/1/2.1.2_clone_repository.png?width=40pc)

3. Đợi quá trình clone hoàn tất. Bạn sẽ thấy thông báo tương tự như sau:

```
Cloning into 'aws-serverless-data-lake-framework'...
remote: Enumerating objects: 3397, done.
remote: Counting objects: 100% (1180/1180), done.
remote: Compressing objects: 100% (578/578), done.
remote: Total 3397 (delta 695), reused 926 (delta 544), pack-reused 2217
Receiving objects: 100% (3397/3397), 2.30 MiB | 5.66 MiB/s, done.
Resolving deltas: 100% (2018/2018), done.
```

#### Bước 3: Di chuyển vào thư mục SDLF

1. Nhập lệnh sau để di chuyển vào thư mục SDLF:

```bash
cd aws-serverless-data-lake-framework
```

2. Nhấn Enter để thực hiện lệnh

![Di chuyển vào thư mục SDLF](../../../static/images/2/1/2.1.3_cd_sdlf.png?width=40pc)

#### Bước 4: Kiểm tra cấu trúc thư mục

1. Nhập lệnh sau để xem cấu trúc thư mục:

```bash
ls -la
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra cấu trúc thư mục](../../../static/images/2/1/2.1.4_check_structure.png?width=40pc)

3. Bạn sẽ thấy danh sách các thư mục và file trong repository, bao gồm:
   - `sdlf-foundations/`: Chứa mã nguồn cho SDLF Foundations
   - `sdlf-team/`: Chứa mã nguồn cho quản lý team
   - `sdlf-dataset/`: Chứa mã nguồn cho quản lý dataset
   - `sdlf-pipelines/`: Chứa mã nguồn cho các ETL pipeline
   - `sdlf-utils/`: Chứa các công cụ tiện ích
   - `sdlf-cicd/`: Chứa mã nguồn cho CI/CD pipeline

#### Bước 5: Kiểm tra phiên bản SDLF

1. Nhập lệnh sau để xem phiên bản SDLF:

```bash
cat VERSION
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra phiên bản](../../../static/images/2/1/2.1.5_check_version.png?width=40pc)

3. Bạn sẽ thấy phiên bản hiện tại của SDLF, ví dụ:

```
2.0.0
```

### Xử lý sự cố

**Vấn đề**: Lỗi "git command not found"
**Giải pháp**:
1. Git đã được cài đặt sẵn trong CloudShell
2. Nếu gặp lỗi này, hãy thử đóng và mở lại CloudShell

**Vấn đề**: Lỗi khi clone repository
**Giải pháp**:
1. Kiểm tra kết nối internet
2. Đảm bảo URL repository là chính xác
3. Thử lại sau vài phút

{{% notice tip %}}
Nếu bạn muốn tìm hiểu thêm về cấu trúc của SDLF, hãy dành thời gian để khám phá các thư mục con và đọc các file README.md trong mỗi thư mục.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Cấu hình parameters](../2-configure-parameters) để chuẩn bị cho việc triển khai SDLF Foundations.