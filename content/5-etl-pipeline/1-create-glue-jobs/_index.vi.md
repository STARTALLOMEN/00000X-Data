---
title: "Tạo Glue jobs"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>5.1 </b>"
---

## Tạo Glue jobs

Bước đầu tiên trong việc triển khai ETL Pipeline là tạo các Glue jobs để xử lý và chuyển đổi dữ liệu.

### Các bước thực hiện

#### Bước 1: Tạo thư mục cho Glue scripts

1. Trong CloudShell, nhập các lệnh sau để tạo thư mục cho Glue scripts:

```bash
mkdir -p ~/environment/glue-scripts
cd ~/environment/glue-scripts
```

2. Nhấn Enter để thực hiện lệnh

![Tạo thư mục](../../../static/images/5/1/5.1.1_create_directory.png?width=40pc)

#### Bước 2: Tạo script cho stage-a

1. Nhập lệnh sau để tạo script cho stage-a:

```bash
cat > stage_a_job.py << 'EOL'
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# Lấy parameters
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'team_name', 'dataset_name', 'bucket_name'])

# Khởi tạo Spark và Glue context
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Đường dẫn input và output
input_path = f"s3://{args['bucket_name']}/raw/{args['team_name']}/{args['dataset_name']}/"
output_path = f"s3://{args['bucket_name']}/stage/{args['team_name']}/{args['dataset_name']}/"

print(f"Input path: {input_path}")
print(f"Output path: {output_path}")

# Đọc dữ liệu từ raw layer
try:
    # Đọc dữ liệu JSON
    datasource = glueContext.create_dynamic_frame.from_options(
        "s3", {"paths": [input_path]}, format="json"
    )
    
    # Chuyển đổi sang DataFrame để dễ xử lý
    dataframe = datasource.toDF()
    
    # Thực hiện transform đơn giản
    # Ví dụ: Thêm timestamp
    from pyspark.sql.functions import current_timestamp
    dataframe = dataframe.withColumn("processing_time", current_timestamp())
    
    # Ghi dữ liệu ra stage layer
    dataframe.write.mode("append").json(output_path)
    
    print(f"Processed {dataframe.count()} records")
    
except Exception as e:
    print(f"Error processing data: {str(e)}")
    raise e

job.commit()
EOL
```

2. Nhấn Enter để thực hiện lệnh

![Tạo script stage-a](../../../static/images/5/1/5.1.2_create_stage_a_script.png?width=40pc)

#### Bước 3: Tạo script cho stage-b

1. Nhập lệnh sau để tạo script cho stage-b:

```bash
cat > stage_b_job.py << 'EOL'
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# Lấy parameters
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'team_name', 'dataset_name', 'bucket_name'])

# Khởi tạo Spark và Glue context
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Đường dẫn input và output
input_path = f"s3://{args['bucket_name']}/stage/{args['team_name']}/{args['dataset_name']}/"
output_path = f"s3://{args['bucket_name']}/analytics/{args['team_name']}/{args['dataset_name']}/"

print(f"Input path: {input_path}")
print(f"Output path: {output_path}")

# Đọc dữ liệu từ stage layer
try:
    # Đọc dữ liệu JSON
    datasource = glueContext.create_dynamic_frame.from_options(
        "s3", {"paths": [input_path]}, format="json"
    )
    
    # Chuyển đổi sang DataFrame để dễ xử lý
    dataframe = datasource.toDF()
    
    # Thực hiện transform nâng cao
    # Ví dụ: Thêm partition columns
    from pyspark.sql.functions import year, month, dayofmonth, col
    
    # Giả sử có cột transaction_date với định dạng yyyy-MM-dd
    if "transaction_date" in dataframe.columns:
        dataframe = dataframe.withColumn("year", year(col("transaction_date")))
        dataframe = dataframe.withColumn("month", month(col("transaction_date")))
        dataframe = dataframe.withColumn("day", dayofmonth(col("transaction_date")))
    
    # Ghi dữ liệu ra analytics layer
    dataframe.write.partitionBy("year", "month", "day").mode("append").parquet(output_path)
    
    print(f"Processed {dataframe.count()} records")
    
except Exception as e:
    print(f"Error processing data: {str(e)}")
    raise e

job.commit()
EOL
```

2. Nhấn Enter để thực hiện lệnh

![Tạo script stage-b](../../../static/images/5/1/5.1.3_create_stage_b_script.png?width=40pc)

#### Bước 4: Lấy thông tin Data Lake Bucket

1. Nhập lệnh sau để lấy tên của Data Lake bucket:

```bash
export DATA_LAKE_BUCKET=$(aws cloudformation describe-stacks \
    --stack-name sdlf-foundations-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`DataLakeBucketName`].OutputValue' \
    --output text)

echo "Data Lake Bucket: $DATA_LAKE_BUCKET"
```

2. Nhấn Enter để thực hiện lệnh

![Lấy tên Data Lake bucket](../../../static/images/5/1/5.1.4_get_bucket_name.png?width=40pc)

#### Bước 5: Upload scripts lên S3

1. Nhập lệnh sau để tạo thư mục artifacts/glue-scripts trong S3 bucket:

```bash
aws s3api put-object --bucket $DATA_LAKE_BUCKET --key artifacts/glue-scripts/
```

2. Nhấn Enter để thực hiện lệnh

3. Nhập lệnh sau để upload scripts lên S3:

```bash
aws s3 cp stage_a_job.py s3://$DATA_LAKE_BUCKET/artifacts/glue-scripts/
aws s3 cp stage_b_job.py s3://$DATA_LAKE_BUCKET/artifacts/glue-scripts/
```

4. Nhấn Enter để thực hiện lệnh

![Upload scripts](../../../static/images/5/1/5.1.5_upload_scripts.png?width=40pc)

#### Bước 6: Tạo IAM Role cho Glue

1. Nhập lệnh sau để tạo IAM role cho Glue:

```bash
# Tạo trust policy
cat > glue-trust-policy.json << 'EOL'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOL

# Tạo IAM role
aws iam create-role \
    --role-name sdlf-glue-role \
    --assume-role-policy-document file://glue-trust-policy.json

# Gán AmazonS3FullAccess policy
aws iam attach-role-policy \
    --role-name sdlf-glue-role \
    --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

# Gán AWSGlueServiceRole policy
aws iam attach-role-policy \
    --role-name sdlf-glue-role \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole
```

2. Nhấn Enter để thực hiện từng lệnh

![Tạo IAM Role](../../../static/images/5/1/5.1.6_create_iam_role.png?width=40pc)

#### Bước 7: Tạo Glue job cho stage-a

1. Mở AWS Management Console và tìm kiếm "Glue"
2. Trong menu bên trái, chọn "ETL" > "Jobs"
3. Nhấp vào nút "Create job"
4. Chọn "Spark script editor"
5. Nhập thông tin cơ bản:
   - Name: team-a-dataset-a-stage-a
   - IAM role: sdlf-glue-role
   - Glue version: Spark 3.1, Python 3
   - Worker type: G.1X
   - Number of workers: 2
   - Job timeout: 30 minutes

![Tạo Glue job](../../../static/images/5/1/5.1.7_create_glue_job.png?width=40pc)

6. Trong phần "Script", chọn "S3" và nhập đường dẫn:
   ```
   s3://$DATA_LAKE_BUCKET/artifacts/glue-scripts/stage_a_job.py
   ```

7. Trong phần "Job parameters", thêm các parameters sau:
   - Key: --team_name, Value: team-a
   - Key: --dataset_name, Value: dataset-a
   - Key: --bucket_name, Value: $DATA_LAKE_BUCKET

8. Nhấp vào "Save" để lưu job

![Cấu hình Glue job](../../../static/images/5/1/5.1.7_configure_glue_job.png?width=40pc)

#### Bước 8: Tạo Glue job cho stage-b

1. Lặp lại các bước 3-8 ở trên, nhưng với các thông tin sau:
   - Name: team-a-dataset-a-stage-b
   - Script: s3://$DATA_LAKE_BUCKET/artifacts/glue-scripts/stage_b_job.py
   - Các parameters khác giữ nguyên

![Tạo Glue job stage-b](../../../static/images/5/1/5.1.8_create_stage_b_job.png?width=40pc)

#### Bước 9: Kiểm tra Glue jobs

1. Trong AWS Management Console, trang Glue, chọn "Jobs" từ menu bên trái
2. Bạn sẽ thấy hai jobs đã tạo:
   - team-a-dataset-a-stage-a
   - team-a-dataset-a-stage-b

![Kiểm tra Glue jobs](../../../static/images/5/1/5.1.9_check_glue_jobs.png?width=40pc)

### Xử lý sự cố

**Vấn đề**: Lỗi "AccessDeniedException" khi tạo Glue job
**Giải pháp**:
1. Kiểm tra IAM permissions của bạn
2. Đảm bảo IAM role đã được tạo thành công
3. Kiểm tra trust relationship của IAM role

**Vấn đề**: Lỗi khi upload scripts lên S3
**Giải pháp**:
1. Kiểm tra tên bucket chính xác
2. Đảm bảo bạn có quyền truy cập vào S3 bucket
3. Kiểm tra nội dung của scripts

{{% notice tip %}}
Bạn có thể kiểm tra logs của Glue jobs trong CloudWatch Logs để debug nếu có lỗi xảy ra khi chạy jobs.
{{% /notice %}}

## Bước tiếp theo

Tiếp theo, chúng ta sẽ [Thiết lập Step Functions](../2-setup-step-functions) để orchestrate workflow của ETL pipeline.