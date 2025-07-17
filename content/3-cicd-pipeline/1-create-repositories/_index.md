---
title: "3.1 Tạo CodeCommit Repositories"
date: 2024-01-01
weight: 1
chapter: false
pre: "<b>3.1 </b>"
---

## Tạo CodeCommit Repositories

Trong bước này, bạn sẽ tạo các CodeCommit repositories để lưu trữ mã nguồn cho SDLF components.

### 1. Truy cập CodeCommit
1. Đăng nhập AWS Console
2. Tìm kiếm **CodeCommit** trong thanh tìm kiếm dịch vụ
3. Click **CodeCommit**

![Mở CodeCommit](../../../static/images/3/3.2_OpenCodeCommit.png?width=90pc)

### 2. Tạo repository đầu tiên
1. Click **Create repository**
2. Nhập **Repository name**: `sdlf-workshop-foundations`
3. Nhập **Description**: `SDLF Foundations infrastructure code`
4. Click **Create repository**

![Tạo repository foundations](../../../static/images/3/3.3_CreateFoundationRepo.png?width=90pc)

### 3. Tạo repository thứ hai
1. Click **Create repository** (lần nữa)
2. Nhập **Repository name**: `sdlf-workshop-pipelines`
3. Nhập **Description**: `SDLF Pipeline configurations`
4. Click **Create repository**

![Tạo repository pipelines](../../../static/images/3/3.4_CreatePipelineRepo.png?width=90pc)

### 4. Tạo repository thứ ba
1. Click **Create repository**
2. Nhập **Repository name**: `sdlf-workshop-teams`
3. Nhập **Description**: `SDLF Team and dataset configurations`
4. Click **Create repository**

![Tạo repository teams](../../../static/images/3/3.5_CreateTeamRepo.png?width=90pc)

### 5. Kiểm tra repositories đã tạo
1. Trong danh sách repositories, xác nhận có 3 repositories:
   - `sdlf-workshop-foundations`
   - `sdlf-workshop-pipelines`
   - `sdlf-workshop-teams`

![Danh sách repositories](../../../static/images/3/3.6_RepositoryList.png?width=90pc)

### 6. Chuẩn bị cho bước tiếp theo
- Ghi lại tên các repositories
- Chuẩn bị code để push vào repositories
- Đảm bảo có quyền truy cập repositories

{{% notice note %}}
**Lưu ý**:
- Repository names phải unique trong region
- Có thể thêm tags để quản lý
- Xóa repositories khi không còn sử dụng
{{% /notice %}}