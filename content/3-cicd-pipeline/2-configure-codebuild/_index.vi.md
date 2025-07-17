---
title: "Cấu hình CodeBuild"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>3.2 </b>"
---

## Cấu hình CodeBuild

Sau khi tạo các CodeCommit repositories, chúng ta cần cấu hình CodeBuild để tự động build và test mã nguồn.

### Các bước thực hiện

#### Bước 1: Tạo buildspec file cho sdlf-foundations

1. Trong CloudShell, nhập các lệnh sau để tạo buildspec file:

```bash
cd ~/environment/sdlf-repos/sdlf-foundations
cat > buildspec.yml << 'EOL'
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.8
  pre_build:
    commands:
      - echo "Starting pre-build phase"
      - pip install -r requirements.txt
  build:
    commands:
      - echo "Starting build phase"
      - chmod +x deploy.sh
      - ./deploy.sh
  post_build:
    commands:
      - echo "Build completed successfully"

artifacts:
  files:
    - parameters-*.json
    - deploy.sh
    - template.yaml
  discard-paths: no
EOL

# Commit và push buildspec file
git add buildspec.yml
git commit -m "Add buildspec.yml for CodeBuild"
git push
```

2. Nhấn Enter để thực hiện lệnh

![Tạo buildspec file](../../../static/images/3/2/3.2.1_create_buildspec.png?width=40pc)

#### Bước 2: Tạo IAM Role cho CodeBuild

1. Nhập lệnh sau để tạo IAM role cho CodeBuild:

```bash
# Tạo trust policy
cat > codebuild-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-codebuild-role \
    --assume-role-policy-document file://codebuild-trust-policy.json

# Gán AdministratorAccess policy (chỉ cho workshop, không khuyến nghị cho production)
aws iam attach-role-policy \
    --role-name sdlf-codebuild-role \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/3/2/3.2.2_create_iam_role.png?width=40pc)

#### Bước 3: Tạo CodeBuild project cho sdlf-foundations

1. Nhập lệnh sau để tạo CodeBuild project:

```bash
# Lấy account ID và region
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION=$(aws configure get region)

# Tạo CodeBuild project
aws codebuild create-project \
    --name sdlf-foundations-build \
    --description "Build project for SDLF Foundations" \
    --source type=CODECOMMIT,location=https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-foundations \
    --artifacts type=NO_ARTIFACTS \
    --environment type=LINUX_CONTAINER,image=aws/codebuild/amazonlinux2-x86_64-standard:3.0,computeType=BUILD_GENERAL1_SMALL \
    --service-role arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codebuild-role
```

2. Nhấn Enter để thực hiện lệnh

![Tạo CodeBuild project](../../../static/images/3/2/3.2.3_create_codebuild_project.png?width=40pc)

3. Bạn sẽ thấy kết quả JSON với thông tin về CodeBuild project đã được tạo

#### Bước 4: Tạo buildspec file cho sdlf-team

1. Nhập các lệnh sau để tạo buildspec file cho sdlf-team:

```bash
cd ~/environment/sdlf-repos/sdlf-team
cat > buildspec.yml << 'EOL'
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.8
  pre_build:
    commands:
      - echo "Starting pre-build phase"
      - pip install -r requirements.txt
  build:
    commands:
      - echo "Starting build phase"
      - chmod +x deploy.sh
      - ./deploy.sh
  post_build:
    commands:
      - echo "Build completed successfully"

artifacts:
  files:
    - parameters-*.json
    - deploy.sh
    - template.yaml
  discard-paths: no
EOL

# Commit và push buildspec file
git add buildspec.yml
git commit -m "Add buildspec.yml for CodeBuild"
git push
```

2. Nhấn Enter để thực hiện lệnh

![Tạo buildspec file cho sdlf-team](../../../static/images/3/2/3.2.4_create_team_buildspec.png?width=40pc)

#### Bước 5: Tạo CodeBuild project cho sdlf-team

1. Nhập lệnh sau để tạo CodeBuild project cho sdlf-team:

```bash
aws codebuild create-project \
    --name sdlf-team-build \
    --description "Build project for SDLF Team" \
    --source type=CODECOMMIT,location=https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-team \
    --artifacts type=NO_ARTIFACTS \
    --environment type=LINUX_CONTAINER,image=aws/codebuild/amazonlinux2-x86_64-standard:3.0,computeType=BUILD_GENERAL1_SMALL \
    --service-role arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codebuild-role
```

2. Nhấn Enter để thực hiện lệnh

![Tạo CodeBuild project cho sdlf-team](../../../static/images/3/2/3.2.5_create_team_codebuild.png?width=40pc)

#### Bước 6: Tạo buildspec file và CodeBuild project cho sdlf-dataset

1. Nhập các lệnh sau để tạo buildspec file và CodeBuild project cho sdlf-dataset:

```bash
cd ~/environment/sdlf-repos/sdlf-dataset
cat > buildspec.yml << 'EOL'
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.8
  pre_build:
    commands:
      - echo "Starting pre-build phase"
      - pip install -r requirements.txt
  build:
    commands:
      - echo "Starting build phase"
      - chmod +x deploy.sh
      - ./deploy.sh
  post_build:
    commands:
      - echo "Build completed successfully"

artifacts:
  files:
    - parameters-*.json
    - deploy.sh
    - template.yaml
  discard-paths: no
EOL

# Commit và push buildspec file
git add buildspec.yml
git commit -m "Add buildspec.yml for CodeBuild"
git push

# Tạo CodeBuild project
aws codebuild create-project \
    --name sdlf-dataset-build \
    --description "Build project for SDLF Dataset" \
    --source type=CODECOMMIT,location=https://git-codecommit.$AWS_REGION.amazonaws.com/v1/repos/sdlf-dataset \
    --artifacts type=NO_ARTIFACTS \
    --environment type=LINUX_CONTAINER,image=aws/codebuild/amazonlinux2-x86_64-standard:3.0,computeType=BUILD_GENERAL1_SMALL \
    --service-role arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codebuild-role
```

2. Nhấn Enter để thực hiện lệnh

![Tạo buildspec và CodeBuild cho sdlf-dataset](../../../static/images/3/2/3.2.6_create_dataset_codebuild.png?width=40pc)

#### Bước 7: Kiểm tra CodeBuild projects trong AWS Management Console

1. Mở tab mới trong trình duyệt (hoặc sử dụng tab đã mở)
2. Truy cập AWS Management Console
3. Tìm kiếm và chọn "CodeBuild"
4. Bạn sẽ thấy danh sách các CodeBuild projects đã tạo:
   - `sdlf-foundations-build`
   - `sdlf-team-build`
   - `sdlf-dataset-build`
5. Nhấp vào từng project để xem chi tiết cấu hình

![Kiểm tra CodeBuild projects](../../../static/images/3/2/3.2.7_check_codebuild_console.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi tạo CodeBuild project
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo IAM role đã được tạo thành công
3. Kiểm tra trust relationship của IAM role

**Vấn đề**: Lỗi "ResourceAlreadyExistsException" khi tạo CodeBuild project
**Giải pháp**:
1. Kiểm tra xem project đã tồn tại chưa
2. Sử dụng tên project khác hoặc xóa project hiện tại

{{% notice warning %}}
Trong môi trường production, bạn nên sử dụng IAM role với quyền hạn chế hơn thay vì AdministratorAccess. Chúng ta sử dụng AdministratorAccess trong workshop này để đơn giản hóa quá trình.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Thiết lập CodePipeline](../3-setup-pipeline) để tự động hóa toàn bộ quy trình CI/CD.