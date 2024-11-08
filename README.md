# Library_Management_be
# API Documentation

# API Endpoints

**Base URL**: `http://localhost:3000/api/v1`

---

## Authentication

- **POST** `/auth/register` - Đăng ký người dùng mới
- **POST** `/auth/login` - Đăng nhập và lấy token

## Author Management

- **POST** `/author/add` - Thêm tác giả mới
- **GET** `/author/get` - Lấy danh sách tất cả các tác giả
- **GET** `/author/get/:id` - Lấy thông tin tác giả theo ID
- **PUT** `/author/update/:id` - Cập nhật thông tin tác giả theo ID
- **DELETE** `/author/delete/:id` - Xóa tác giả theo ID

---
