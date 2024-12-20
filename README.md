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

## Employee Management

- **POST** `/employee/add` - Thêm nhân viên mới
- **GET** `/employee/get` - Lấy danh sách tất cả các nhân viên
- **GET** `/employee/get/:id` - Lấy thông tin nhân viên theo ID
- **PUT** `/employee/update/:id` - Cập nhật thông tin nhân viên theo ID
- **DELETE** `/employee/delete/:id` - Xóa nhân viên theo ID

---

## LibraryCard Management

- **POST** `/libraryCard/add` - Thêm thẻ thư viện mới
- **GET** `/libraryCard/get` - Lấy danh sách tất cả các thẻ thư viện
- **GET** `/libraryCard/get/:id` - Lấy thông tin thẻ thư viện theo ID
- **PUT** `/libraryCard/update/:id` - Cập nhật thông tin thẻ thư viện theo ID
- **DELETE** `/libraryCard/delete/:id` - Xóa thẻ thư viện theo ID

---

## Reader Management

- **POST** `/reader/add` - Thêm thẻ thư viện mới
- **POST** `/reader/assignLibraryCard/:readerId` - Gán Thẻ thư viện vào độc giả
- **POST** `/reader/addReaderWithCard` - Vừa thêm thẻ thư viện mới vừa thêm thẻ thư viện
- **GET** `/reader/get` - Lấy danh sách tất cả các thẻ thư viện
- **GET** `/reader/get/:id` - Lấy thông tin thẻ thư viện theo ID
- **PUT** `/reader/update/:id` - Cập nhật thông tin thẻ thư viện theo ID
- **DELETE** `/reader/delete/:id` - Xóa thẻ thư viện theo ID

---
