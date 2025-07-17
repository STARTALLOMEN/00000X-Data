---
title: "Cấu hình parameters"
date: 2024-01-01
weight: 2
chapter: false
pre: "<b>2.2 </b>"
---

## Cấu hình parameters

Trước khi triển khai SDLF Foundations, chúng ta cần cấu hình các tham số cần thiết để phù hợp với môi trường của bạn.

### Các bước thực hiện

#### Bước 1: Di chuyển đến thư mục sdlf-foundations

1. Trong CloudShell, nhập lệnh sau để di chuyển đến thư mục sdlf-foundations:

```bash
cd ~/environment/sdlf-workshop/aws-serverless-data-lake-framework/sdlf-foundations
```

2. Nhấn Enter để thực hiện lệnh

![Di chuyển đến thư mục sdlf-foundations](../../../static/images/2/2/2.2.1_cd_foundations.png?width=40pc)

#### Bước 2: Xem file parameters mặc định

1. Nhập lệnh sau để xem nội dung file parameters-dev.json:

```bash
cat parameters-dev.json
```

2. Nhấn Enter để thực hiện lệnh

![Xem file parameters mặc định](../../../static/images/2/2/2.2.2_view_parameters.png?width=40pc)

3. Bạn sẽ thấy nội dung của file parameters-dev.json, ví dụ:

```json
{
  "pOrganizationId": "sdlf",
  "pDataLakeName": "sdlf-datalake",
  "pEnvironment": "dev",
  "pRegion": "us-east-1",
  "pAccountId": "123456789012",
  "pLakeFormationAdminRoleName": "AWSLakeFormationServiceRole",
  "pLakeFormationAdminUserName": "admin",
  "pLakeFormationAdminRoleArn": "arn:aws:iam::123456789012:role/AWSLakeFormationServiceRole",
  "pLakeFormationAdminUserArn": "arn:aws:iam::123456789012:user/admin",
  "pChildAccountId": "123456789012",
  "pSharedAccountId": "123456789012",
  "pSharedAccountRoleName": "sdlf-crossaccount-role",
  "pSharedAccountRoleArn": "arn:aws:iam::123456789012:role/sdlf-crossaccount-role",
  "pArtifactsBucket": "sdlf-artifacts-123456789012-us-east-1",
  "pStagingBucket": "sdlf-staging-123456789012-us-east-1",
  "pCentralBucket": "sdlf-central-123456789012-us-east-1",
  "pDataLakeBucket": "sdlf-datalake-123456789012-us-east-1",
  "pKMSKeyId": "12345678-1234-1234-1234-123456789012"
}
```

#### Bước 3: Tạo bản sao của file parameters

1. Nhập lệnh sau để tạo bản sao của file parameters-dev.json:

```bash
cp parameters-dev.json parameters-dev.json.bak
```

2. Nhấn Enter để thực hiện lệnh

![Tạo bản sao của file parameters](../../../static/images/2/2/2.2.3_backup_parameters.png?width=40pc)

#### Bước 4: Lấy thông tin tài khoản AWS

1. Nhập lệnh sau để lấy ID tài khoản AWS của bạn:

```bash
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "AWS Account ID: $AWS_ACCOUNT_ID"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy ID tài khoản AWS](../../../static/images/2/2/2.2.4_get_account_id.png?width=40pc)

3. Nhập lệnh sau để lấy region hiện tại:

```bash
export AWS_REGION=$(aws configure get region)
echo "AWS Region: $AWS_REGION"
```

4. Nhấn Enter để thực hiện lệnh

![Lấy region hiện tại](../../../static/images/2/2/2.2.4_get_region.png?width=40pc)

#### Bước 5: Chỉnh sửa file parameters

1. Nhập lệnh sau để mở file parameters-dev.json trong trình soạn thảo:

```bash
nano parameters-dev.json
```

2. Nhấn Enter để thực hiện lệnh

![Mở file parameters trong trình soạn thảo](../../../static/images/2/2/2.2.5_edit_parameters.png?width=40pc)

3. Chỉnh sửa các tham số sau:
   - `"pOrganizationId"`: Đặt thành "sdlf-workshop"
   - `"pDataLakeName"`: Đặt thành "sdlf-datalake"
   - `"pEnvironment"`: Giữ nguyên "dev"
   - `"pRegion"`: Đặt thành region hiện tại của bạn (ví dụ: "us-east-1")
   - `"pAccountId"`: Đặt thành ID tài khoản AWS của bạn
   - `"pChildAccountId"`: Đặt thành ID tài khoản AWS của bạn
   - `"pSharedAccountId"`: Đặt thành ID tài khoản AWS của bạn

4. Sau khi chỉnh sửa, nhấn Ctrl+X để thoát, nhấn Y để lưu thay đổi, và nhấn Enter để xác nhận tên file

![Lưu thay đổi](../../../static/images/2/2/2.2.5_save_parameters.png?width=40pc)

#### Bước 6: Xác nhận thay đổi

1. Nhập lệnh sau để xem nội dung file parameters-dev.json đã chỉnh sửa:

```bash
cat parameters-dev.json
```

2. Nhấn Enter để thực hiện lệnh

![Xác nhận thay đổi](../../../static/images/2/2/2.2.6_confirm_changes.png?width=40pc)

3. Đảm bảo các tham số đã được cập nhật chính xác

#### Bước 7: Tạo file cấu hình tự động (tùy chọn)

1. Nếu bạn muốn tự động hóa việc cấu hình parameters, bạn có thể sử dụng lệnh sau:

```bash
cat > update_parameters.sh << 'EOL'
#!/bin/bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=$(aws configure get region)

# Tạo bản sao của file parameters
cp parameters-dev.json parameters-dev.json.bak

# Cập nhật file parameters
jq --arg account "$ACCOUNT_ID" --arg region "$REGION" '
  .pOrganizationId = "sdlf-workshop" |
  .pDataLakeName = "sdlf-datalake" |
  .pRegion = $region |
  .pAccountId = $account |
  .pChildAccountId = $account |
  .pSharedAccountId = $account |
  .pArtifactsBucket = "sdlf-artifacts-\($account)-\($region)" |
  .pStagingBucket = "sdlf-staging-\($account)-\($region)" |
  .pCentralBucket = "sdlf-central-\($account)-\($region)" |
  .pDataLakeBucket = "sdlf-datalake-\($account)-\($region)"
' parameters-dev.json.bak > parameters-dev.json

echo "Parameters updated successfully!"
cat parameters-dev.json
EOL

chmod +x update_parameters.sh
./update_parameters.sh
```

2. Nhấn Enter để thực hiện lệnh

![Tạo file cấu hình tự động](../../../static/images/2/2/2.2.7_auto_config.png?width=40pc)

3. Nếu gặp lỗi "jq: command not found", hãy cài đặt jq trước:

```bash
sudo yum install -y jq
```

### Xử lý sự cố

**Vấn đề**: Lỗi khi chỉnh sửa file với nano
**Giải pháp**:
1. Bạn có thể sử dụng trình soạn thảo khác như vim: `vim parameters-dev.json`
2. Hoặc sử dụng lệnh sed để thay thế trực tiếp:
   ```bash
   sed -i "s/\"pOrganizationId\": \"sdlf\"/\"pOrganizationId\": \"sdlf-workshop\"/" parameters-dev.json
   ```

**Vấn đề**: Lỗi "jq: command not found" khi sử dụng script tự động
**Giải pháp**:
1. Cài đặt jq: `sudo yum install -y jq`
2. Hoặc sử dụng phương pháp chỉnh sửa thủ công với nano hoặc vim

{{% notice warning %}}
Đảm bảo bạn đã cập nhật chính xác ID tài khoản AWS và region. Các tham số này rất quan trọng cho việc triển khai SDLF Foundations.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Triển khai CloudFormation](../3-deploy-cloudformation) để tạo cơ sở hạ tầng cho SDLF Foundations.