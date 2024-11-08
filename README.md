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

## Genres Management

- **POST** `/genres/add` - Thêm thể loại mới
- **GET** `/genres/get` - Lấy danh sách tất cả các thể loại
- **GET** `/genres/get/:id` - Lấy thông tin thể loại theo ID
- **PUT** `/genres/update/:id` - Cập nhật thông tin thể loại theo ID
- **DELETE** `/genres/delete/:id` - Xóa thể loại theo ID

---

## Publisher Management

- **POST** `/publisher/add` - Thêm nhà xuất bản mới
- **GET** `/publisher/get` - Lấy danh sách tất cả các nhà xuất bản
- **GET** `/publisher/get/:id` - Lấy thông tin nhà xuất bản theo ID
- **PUT** `/publisher/update/:id` - Cập nhật thông tin nhà xuất bản theo ID
- **DELETE** `/publisher/delete/:id` - Xóa nhà xuất bản theo ID

---
