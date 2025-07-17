---
title: "Tạo CodeCommit repositories"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>3.1 </b>"
---

## Tạo CodeCommit repositories

Bước đầu tiên để thiết lập CI/CD Pipeline là tạo các CodeCommit repositories để lưu trữ mã nguồn của SDLF.

### Các bước thực hiện

#### Bước 1: Tạo repositories trong CloudShell

1. Trong CloudShell, nhập các lệnh sau để tạo các CodeCommit repositories:

```bash
# Tạo repository cho SDLF Foundations
aws codecommit create-repository \
    --repository-name sdlf-foundations \
    --repository-description "SDLF Foundations Repository"

# Tạo repository cho SDLF Team
aws codecommit create-repository \
    --repository-name sdlf-team \
    --repository-description "SDLF Team Repository"

# Tạo repository cho SDLF Dataset
aws codecommit create-repository \
    --repository-name sdlf-dataset \
    --repository-description "SDLF Dataset Repository"
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo CodeCommit repositories](../../../static/images/3/1/3.1.1_create_repositories.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON cho mỗi lệnh, hiển thị thông tin về repository đã được tạo, bao gồm:
   - `repositoryName`: Tên repository
   - `repositoryId`: ID của repository
   - `cloneUrlHttp`: URL để clone repository qua HTTP
   - `cloneUrlSsh`: URL để clone repository qua SSH

#### Bước 2: Kiểm tra repositories đã tạo

1. Nhập lệnh sau để liệt kê các repositories đã tạo:

```bash
aws codecommit list-repositories
```

2. Nhấn Enter để thực hiện lệnh

![Kiểm tra repositories](../../../static/images/3/1/3.1.2_list_repositories.png?width=40pc)

3. Bạn sẽ thấy danh sách các repositories đã tạo, bao gồm:
   - `sdlf-foundations`
   - `sdlf-team`
   - `sdlf-dataset`

#### Bước 3: Cấu hình Git trong CloudShell

1. Nhập các lệnh sau để cấu hình Git:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

2. Thay thế "Your Name" và "your.email@example.com" bằng tên và email của bạn
3. Nhấn Enter để thực hiện từng lệnh

![Cấu hình Git](../../../static/images/3/1/3.1.3_configure_git.png?width=40pc)

#### Bước 4: Chuẩn bị mã nguồn cho sdlf-foundations

1. Nhập các lệnh sau để chuẩn bị mã nguồn cho sdlf-foundations:

```bash
# Tạo thư mục làm việc
mkdir -p ~/environment/sdlf-repos/sdlf-foundations
cd ~/environment/sdlf-repos/sdlf-foundations

# Sao chép mã nguồn từ repository gốc
cp -r ~/environment/sdlf-workshop/aws-serverless-data-lake-framework/sdlf-foundations/* .

# Khởi tạo Git repository
git init
git add .
git commit -m "Initial commit for sdlf-foundations"
```

2. Nhấn Enter để thực hiện từng lệnh

![Chuẩn bị mã nguồn](../../../static/images/3/1/3.1.4_prepare_code.png?width=40pc)

#### Bước 5: Đẩy mã nguồn lên CodeCommit

1. Nhập các lệnh sau để đẩy mã nguồn lên CodeCommit:

```bash
# Lấy region hiện tại
export AWS_REGION=$(aws configure get region)

# Thêm remote repository
git remote add origin https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-foundations

# Đẩy mã nguồn lên
git push -u origin master
```

2. Nhấn Enter để thực hiện từng lệnh

![Đẩy mã nguồn](../../../static/images/3/1/3.1.5_push_code.png?width=40pc)

3. Nếu được yêu cầu nhập thông tin đăng nhập, hãy sử dụng AWS credentials của bạn

#### Bước 6: Chuẩn bị và đẩy mã nguồn cho sdlf-team

1. Nhập các lệnh sau để chuẩn bị và đẩy mã nguồn cho sdlf-team:

```bash
# Tạo thư mục làm việc
mkdir -p ~/environment/sdlf-repos/sdlf-team
cd ~/environment/sdlf-repos/sdlf-team

# Sao chép mã nguồn từ repository gốc
cp -r ~/environment/sdlf-workshop/aws-serverless-data-lake-framework/sdlf-team/* .

# Khởi tạo Git repository
git init
git add .
git commit -m "Initial commit for sdlf-team"

# Thêm remote repository và đẩy mã nguồn
git remote add origin https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-team
git push -u origin master
```

2. Nhấn Enter để thực hiện từng lệnh

![Đẩy mã nguồn sdlf-team](../../../static/images/3/1/3.1.6_push_team_code.png?width=40pc)

#### Bước 7: Chuẩn bị và đẩy mã nguồn cho sdlf-dataset

1. Nhập các lệnh sau để chuẩn bị và đẩy mã nguồn cho sdlf-dataset:

```bash
# Tạo thư mục làm việc
mkdir -p ~/environment/sdlf-repos/sdlf-dataset
cd ~/environment/sdlf-repos/sdlf-dataset

# Sao chép mã nguồn từ repository gốc
cp -r ~/environment/sdlf-workshop/aws-serverless-data-lake-framework/sdlf-dataset/* .

# Khởi tạo Git repository
git init
git add .
git commit -m "Initial commit for sdlf-dataset"

# Thêm remote repository và đẩy mã nguồn
git remote add origin https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-dataset
git push -u origin master
```

2. Nhấn Enter để thực hiện từng lệnh

![Đẩy mã nguồn sdlf-dataset](../../../static/images/3/1/3.1.7_push_dataset_code.png?width=40pc)

#### Bước 8: Kiểm tra repositories trong AWS Management Console

1. Mở tab mới trong trình duyệt
2. Truy cập AWS Management Console
3. Tìm kiếm và chọn "CodeCommit"
4. Bạn sẽ thấy danh sách các repositories đã tạo
5. Nhấp vào từng repository để xem mã nguồn đã được đẩy lên

![Kiểm tra trong Console](../../../static/images/3/1/3.1.8_check_console.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "fatal: unable to access" khi đẩy mã nguồn
**Giải pháp**:
1. Kiểm tra kết nối internet
2. Đảm bảo AWS credentials của bạn có quyền truy cập CodeCommit
3. Kiểm tra region trong URL repository

**Vấn đề**: Lỗi "fatal: repository not found" khi đẩy mã nguồn
**Giải pháp**:
1. Kiểm tra tên repository đã chính xác chưa
2. Đảm bảo repository đã được tạo thành công
3. Kiểm tra URL remote repository

{{% notice tip %}}
Nếu bạn gặp vấn đề với xác thực Git, bạn có thể sử dụng AWS CLI credential helper bằng cách chạy lệnh: `git config --global credential.helper '!aws codecommit credential-helper $@'`
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Cấu hình CodeBuild](../2-configure-codebuild) để tự động build và test mã nguồn.