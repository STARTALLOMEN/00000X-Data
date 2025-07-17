# Hướng dẫn Workshop SDLF

## 1. Cấu trúc cho mỗi phần

```markdown
---
title: "Tên phần"
date: 2024-01-01
weight: 10
chapter: false
pre: "<b>X. </b>"
---

## Tổng quan

Mô tả ngắn gọn về phần này. [Tài liệu chính thức](https://github.com/awslabs/aws-serverless-data-lake-framework)

![Kiến trúc phần X](../../../static/images/X/architecture.png?width=40pc)

## Các bước thực hiện

### Bước 1: Tên bước

Mô tả chi tiết với hình ảnh minh họa.

![Mô tả hình ảnh](../../../static/images/X/step1.png?width=40pc)

```bash
# Mã lệnh mẫu
command --parameter value
```

Sau khi thực hiện, bạn sẽ thấy:
- Kết quả A xuất hiện trong console
- Resource B được tạo trong AWS

### Bước 2: Tên bước

...

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Tên phần tiếp theo](link-to-next-section).
```

## 2. Nội dung cho từng phần

### 2.1. Các bước chuẩn bị

- Đăng nhập vào AWS Management Console
- Mở AWS CloudShell
- Chọn region phù hợp

### 2.2. Triển khai SDLF Foundations

- Clone repository SDLF trên CloudShell
- Cấu hình parameters
- Triển khai CloudFormation
- Xem kết quả triển khai

### 2.3. Thiết lập CI/CD Pipeline

- Tạo CodeCommit repositories
- Cấu hình CodeBuild
- Thiết lập CodePipeline
- Chạy pipeline

### 2.4. Đăng ký Team và Dataset

- Đăng ký team
- Tạo dataset
- Thiết lập quyền truy cập

### 2.5. Triển khai ETL Pipeline

- Tạo Glue jobs
- Cấu hình Step Functions
- Thiết lập EventBridge

### 2.6. Nạp và xử lý dữ liệu

- Chuẩn bị dữ liệu mẫu
- Upload dữ liệu
- Theo dõi quá trình xử lý

### 2.7. Truy vấn dữ liệu với Athena

- Thiết lập workgroup
- Thực hiện các truy vấn
- Export kết quả

### 2.8. Giám sát và xử lý sự cố

- Thiết lập CloudWatch
- Tạo dashboards
- Thiết lập cảnh báo

### 2.9. Clean-up Resources

- Xóa CloudFormation stacks
- Xóa S3 buckets
- Xóa các resources khác

## 3. Xử lý sự cố thường gặp

```markdown
**Vấn đề**: CloudFormation stack creation fails
**Giải pháp**: Kiểm tra IAM permissions và CloudWatch logs

**Vấn đề**: Glue job không chạy
**Giải pháp**: Kiểm tra IAM role và S3 permissions
```

## 4. Lưu ý quan trọng

```markdown
{{% notice note %}}
Đảm bảo sử dụng cùng một region cho toàn bộ workshop.
{{% /notice %}}

{{% notice warning %}}
Nhớ xóa tất cả resources sau khi hoàn thành để tránh phát sinh chi phí.
{{% /notice %}}
```

## 5. Hướng dẫn sử dụng

1. Tập trung vào hướng dẫn thực hành trực tiếp trên CloudShell hoặc Console
2. Tích hợp kiểm tra vào từng bước
3. Giữ phần giới thiệu ngắn gọn với liên kết đến tài liệu chính thức
4. Thêm hình ảnh minh họa cho mỗi bước
5. Đảm bảo có phần Clean-up Resources chi tiết ở cuối workshop
00000X-Data/
├── content/                           # Nội dung chính của workshop
│   ├── _index.md                      # Trang chủ tiếng Anh
│   ├── _index.vi.md                   # Trang chủ tiếng Việt
│   ├── 1-prerequisite/                # Phần 1: Chuẩn bị
│   │   ├── _index.vi.md               # Tổng quan phần 1
│   │   └── 1-aws-console/             # Bước 1.1: Đăng nhập AWS Console
│   │       └── _index.vi.md           # Chi tiết bước 1.1
│   ├── 2-foundations/                 # Phần 2: SDLF Foundations
│   │   ├── _index.vi.md               # Tổng quan phần 2
│   │   ├── 1-clone-repository/        # Bước 2.1: Clone repository
│   │   │   └── _index.vi.md           # Chi tiết bước 2.1
│   │   ├── 2-configure-parameters/    # Bước 2.2: Cấu hình parameters
│   │   │   └── _index.vi.md           # Chi tiết bước 2.2
│   │   └── 3-deploy-cloudformation/   # Bước 2.3: Triển khai CloudFormation
│   │       └── _index.vi.md           # Chi tiết bước 2.3
│   ├── 3-cicd-pipeline/               # Phần 3: CI/CD Pipeline
│   │   ├── _index.vi.md               # Tổng quan phần 3
│   │   ├── 1-create-repositories/     # Bước 3.1: Tạo repositories
│   │   │   └── _index.vi.md           # Chi tiết bước 3.1
│   │   ├── 2-configure-codebuild/     # Bước 3.2: Cấu hình CodeBuild
│   │   │   └── _index.vi.md           # Chi tiết bước 3.2
│   │   └── 3-setup-pipeline/          # Bước 3.3: Thiết lập pipeline
│   │       └── _index.vi.md           # Chi tiết bước 3.3
│   ├── 4-team-dataset/                # Phần 4: Team và Dataset
│   │   ├── _index.vi.md               # Tổng quan phần 4
│   │   ├── 1-register-team/           # Bước 4.1: Đăng ký team
│   │   │   └── _index.vi.md           # Chi tiết bước 4.1
│   │   └── 2-create-dataset/          # Bước 4.2: Tạo dataset
│   │       └── _index.vi.md           # Chi tiết bước 4.2
│   ├── 5-etl-pipeline/                # Phần 5: ETL Pipeline
│   │   ├── _index.vi.md               # Tổng quan phần 5
│   │   ├── 1-create-glue-jobs/        # Bước 5.1: Tạo Glue jobs
│   │   │   └── _index.vi.md           # Chi tiết bước 5.1
│   │   ├── 2-setup-step-functions/    # Bước 5.2: Thiết lập Step Functions
│   │   │   └── _index.vi.md           # Chi tiết bước 5.2
│   │   └── 3-configure-eventbridge/   # Bước 5.3: Cấu hình EventBridge
│   │       └── _index.vi.md           # Chi tiết bước 5.3
│   ├── 6-data-ingestion/              # Phần 6: Nạp dữ liệu
│   │   ├── _index.vi.md               # Tổng quan phần 6
│   │   ├── 1-prepare-data/            # Bước 6.1: Chuẩn bị dữ liệu
│   │   │   └── _index.vi.md           # Chi tiết bước 6.1
│   │   └── 2-upload-data/             # Bước 6.2: Upload dữ liệu
│   │       └── _index.vi.md           # Chi tiết bước 6.2
│   ├── 7-athena-query/                # Phần 7: Truy vấn Athena
│   │   ├── _index.vi.md               # Tổng quan phần 7
│   │   ├── 1-setup-workgroup/         # Bước 7.1: Thiết lập workgroup
│   │   │   └── _index.vi.md           # Chi tiết bước 7.1
│   │   └── 2-run-queries/             # Bước 7.2: Chạy truy vấn
│   │       └── _index.vi.md           # Chi tiết bước 7.2
│   ├── 8-monitoring/                  # Phần 8: Giám sát
│   │   ├── _index.vi.md              
│   └── 9-cleanup/                     # Phần 9: Dọn dẹp
│       ├── _index.vi.md               
├── static/                            # Tài nguyên tĩnh
│   └── images/                        # Hình ảnh minh họa
│       ├── 0/                         # Hình ảnh cho trang chủ
│       ├── 1/                         # Hình ảnh cho phần 1
│       ├── 2/                         # Hình ảnh cho phần 2
│       └── ...                        # Hình ảnh cho các phần khác
└── workshop-enhancement-guide.md      # Hướng dẫn nâng cao workshop (file nội bộ)
