---
title: "Thiết lập CodePipeline"
date: 2024-01-01
weight: 3
chapter: false
pre: "<b>3.3 </b>"
---

## Thiết lập CodePipeline

Sau khi đã cấu hình CodeBuild, chúng ta sẽ thiết lập CodePipeline để tự động hóa toàn bộ quy trình CI/CD.

### Các bước thực hiện

#### Bước 1: Tạo S3 bucket cho artifacts

1. Trong CloudShell, nhập lệnh sau để tạo S3 bucket cho artifacts:

```bash
# Lấy account ID và region
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION=$(aws configure get region)

# Tạo S3 bucket
aws s3 mb s3://sdlf-codepipeline-artifacts-$AWS_ACCOUNT_ID-$AWS_REGION --region $AWS_REGION

# Bật versioning cho bucket
aws s3api put-bucket-versioning \
    --bucket sdlf-codepipeline-artifacts-$AWS_ACCOUNT_ID-$AWS_REGION \
    --versioning-configuration Status=Enabled
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo S3 bucket](../../../static/images/3/3/3.3.1_create_s3_bucket.png?width=40pc)

#### Bước 2: Tạo IAM Role cho CodePipeline

1. Nhập lệnh sau để tạo IAM role cho CodePipeline:

```bash
# Tạo trust policy
cat > codepipeline-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-codepipeline-role \
    --assume-role-policy-document file://codepipeline-trust-policy.json

# Gán AdministratorAccess policy (chỉ cho workshop, không khuyến nghị cho production)
aws iam attach-role-policy \
    --role-name sdlf-codepipeline-role \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/3/3/3.3.2_create_iam_role.png?width=40pc)

#### Bước 3: Tạo CodePipeline cho sdlf-foundations

1. Nhập lệnh sau để tạo file cấu hình pipeline:

```bash
cat > sdlf-foundations-pipeline.json << EOL
{
  "pipeline": {
    "name": "sdlf-foundations-pipeline",
    "roleArn": "arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codepipeline-role",
    "artifactStore": {
      "type": "S3",
      "location": "sdlf-codepipeline-artifacts-$AWS_ACCOUNT_ID-$AWS_REGION"
    },
    "stages": [
      {
        "name": "Source",
        "actions": [
          {
            "name": "Source",
            "actionTypeId": {
              "category": "Source",
              "owner": "AWS",
              "provider": "CodeCommit",
              "version": "1"
            },
            "configuration": {
              "RepositoryName": "sdlf-foundations",
              "BranchName": "master"
            },
            "outputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      },
      {
        "name": "Build",
        "actions": [
          {
            "name": "BuildAction",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "configuration": {
              "ProjectName": "sdlf-foundations-build"
            },
            "inputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      }
    ]
  }
}
EOL
```

2. Nhấn Enter để thực hiện lệnh

![Tạo file cấu hình pipeline](../../../static/images/3/3/3.3.3_create_pipeline_config.png?width=40pc)

3. Nhập lệnh sau để tạo CodePipeline:

```bash
aws codepipeline create-pipeline --cli-input-json file://sdlf-foundations-pipeline.json
```

4. Nhấn Enter để thực hiện lệnh

![Tạo CodePipeline](../../../static/images/3/3/3.3.3_create_pipeline.png?width=40pc)

5. Bạn sẽ thấy kết quả JSON với thông tin về pipeline đã được tạo

#### Bước 4: Tạo CodePipeline cho sdlf-team

1. Nhập lệnh sau để tạo file cấu hình pipeline cho sdlf-team:

```bash
cat > sdlf-team-pipeline.json << EOL
{
  "pipeline": {
    "name": "sdlf-team-pipeline",
    "roleArn": "arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codepipeline-role",
    "artifactStore": {
      "type": "S3",
      "location": "sdlf-codepipeline-artifacts-$AWS_ACCOUNT_ID-$AWS_REGION"
    },
    "stages": [
      {
        "name": "Source",
        "actions": [
          {
            "name": "Source",
            "actionTypeId": {
              "category": "Source",
              "owner": "AWS",
              "provider": "CodeCommit",
              "version": "1"
            },
            "configuration": {
              "RepositoryName": "sdlf-team",
              "BranchName": "master"
            },
            "outputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      },
      {
        "name": "Build",
        "actions": [
          {
            "name": "BuildAction",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "configuration": {
              "ProjectName": "sdlf-team-build"
            },
            "inputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      }
    ]
  }
}
EOL

# Tạo CodePipeline
aws codepipeline create-pipeline --cli-input-json file://sdlf-team-pipeline.json
```

2. Nhấn Enter để thực hiện lệnh

![Tạo CodePipeline cho sdlf-team](../../../static/images/3/3/3.3.4_create_team_pipeline.png?width=40pc)

#### Bước 5: Tạo CodePipeline cho sdlf-dataset

1. Nhập lệnh sau để tạo file cấu hình pipeline cho sdlf-dataset:

```bash
cat > sdlf-dataset-pipeline.json << EOL
{
  "pipeline": {
    "name": "sdlf-dataset-pipeline",
    "roleArn": "arn:aws:iam::$AWS_ACCOUNT_ID:role/sdlf-codepipeline-role",
    "artifactStore": {
      "type": "S3",
      "location": "sdlf-codepipeline-artifacts-$AWS_ACCOUNT_ID-$AWS_REGION"
    },
    "stages": [
      {
        "name": "Source",
        "actions": [
          {
            "name": "Source",
            "actionTypeId": {
              "category": "Source",
              "owner": "AWS",
              "provider": "CodeCommit",
              "version": "1"
            },
            "configuration": {
              "RepositoryName": "sdlf-dataset",
              "BranchName": "master"
            },
            "outputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      },
      {
        "name": "Build",
        "actions": [
          {
            "name": "BuildAction",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "configuration": {
              "ProjectName": "sdlf-dataset-build"
            },
            "inputArtifacts": [
              {
                "name": "SourceCode"
              }
            ],
            "region": "$AWS_REGION"
          }
        ]
      }
    ]
  }
}
EOL

# Tạo CodePipeline
aws codepipeline create-pipeline --cli-input-json file://sdlf-dataset-pipeline.json
```

2. Nhấn Enter để thực hiện lệnh

![Tạo CodePipeline cho sdlf-dataset](../../../static/images/3/3/3.3.5_create_dataset_pipeline.png?width=40pc)

#### Bước 6: Kiểm tra CodePipeline trong AWS Management Console

1. Mở tab mới trong trình duyệt (hoặc sử dụng tab đã mở)
2. Truy cập AWS Management Console
3. Tìm kiếm và chọn "CodePipeline"
4. Bạn sẽ thấy danh sách các pipelines đã tạo:
   - `sdlf-foundations-pipeline`
   - `sdlf-team-pipeline`
   - `sdlf-dataset-pipeline`
5. Nhấp vào từng pipeline để xem chi tiết

![Kiểm tra CodePipeline](../../../static/images/3/3/3.3.6_check_pipeline_console.png?width=40pc)

6. Bạn sẽ thấy các stages của pipeline (Source và Build) và trạng thái của chúng

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi tạo CodePipeline
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo IAM role đã được tạo thành công
3. Kiểm tra trust relationship của IAM role

**Vấn đề**: Lỗi "InvalidS3LocationException" khi tạo CodePipeline
**Giải pháp**:
1. Kiểm tra xem S3 bucket đã được tạo thành công chưa
2. Đảm bảo tên bucket chính xác
3. Kiểm tra region của bucket

{{% notice tip %}}
Bạn có thể theo dõi tiến trình của pipeline bằng cách nhấp vào pipeline trong AWS Management Console. Mỗi khi có thay đổi trong repository, pipeline sẽ tự động chạy.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Kiểm tra pipeline](../4-test-pipeline) để đảm bảo CI/CD pipeline hoạt động như mong đợi.