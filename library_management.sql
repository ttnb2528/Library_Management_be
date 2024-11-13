-- create database if not exists lib_management;
-- use lib_management;

DROP TABLE IF EXISTS ChuDe;
DROP TABLE IF EXISTS NXB;
DROP TABLE IF EXISTS TacGia;
DROP TABLE IF EXISTS Sach;
DROP TABLE IF EXISTS TheThuVien;
DROP TABLE IF EXISTS DocGia;
DROP TABLE IF EXISTS TaiKhoan;
DROP TABLE IF EXISTS NhanVien;
DROP TABLE IF EXISTS TaiKhoanViPham;
DROP TABLE IF EXISTS PhieuMuon;
DROP TABLE IF EXISTS PhieuMuonChiTiet;


-- Bảng ChuDe
CREATE TABLE ChuDe (
    ChuDeID VARCHAR(50) PRIMARY KEY,
    TenChuDe VARCHAR(255)
);

-- Bảng NXB
CREATE TABLE NXB (
    NXB_ID VARCHAR(50) PRIMARY KEY,
    TenNXB VARCHAR(255),
    DiaChi VARCHAR(255),
    Email VARCHAR(255),
    Info_ngDaiDien VARCHAR(255)
);

-- Bảng TacGia
CREATE TABLE TacGia (
    TacGiaID VARCHAR(50) PRIMARY KEY,
    TenTacGia VARCHAR(255),
    Website VARCHAR(255),
    Note VARCHAR(255)
);

-- Bảng Sach
CREATE TABLE Sach (
    ISBN VARCHAR(50) PRIMARY KEY,
    TenSach VARCHAR(255),
    SoTrang INT,
    Soluong INT,
    MoTa VARCHAR(1000),
    ChuDeID VARCHAR(50),
    NXB_ID VARCHAR(50),
    TacGiaID VARCHAR(50),
    NamXB DATE,
    FOREIGN KEY (ChuDeID) REFERENCES ChuDe(ChuDeID),
    FOREIGN KEY (NXB_ID) REFERENCES NXB(NXB_ID),
    FOREIGN KEY (TacGiaID) REFERENCES TacGia(TacGiaID)
);

-- Bảng Thẻ thư viện
CREATE TABLE TheThuVien (
    SoThe VARCHAR(255) PRIMARY KEY,
    Start_date DATE,
    End_date DATE,
    Note VARCHAR(1000)
);

-- Bảng DocGia
CREATE TABLE DocGia (
    DocGiaID VARCHAR(50) PRIMARY KEY,
    TenDocGia VARCHAR(255),
    DiaChi VARCHAR(500),
    SDT VARCHAR(20),
    SoThe VARCHAR(255),
    FOREIGN KEY (SoThe) REFERENCES TheThuVien(SoThe)
);

-- Bang TaiKhoan
CREATE TABLE TaiKhoan (
    ID_TaiKhoan VARCHAR(10) PRIMARY KEY,
    User_Name VARCHAR(20),
    Pass_wd VARCHAR(20),
    Email VARCHAR(25),
    Role VARCHAR(10)
);

-- Bảng NhanVien
CREATE TABLE NhanVien (
    NhanVienID VARCHAR(50) PRIMARY KEY,
    HoTen VARCHAR(255),
    NgaySinh DATE,
    SDT VARCHAR(20),
    ID_TaiKhoan VARCHAR(10),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan)
);

-- Bảng DocGiaViPham
CREATE TABLE TaiKhoanViPham (
    ID VARCHAR(50) PRIMARY KEY,
    NgayKhoa DATE,
    NgayMoKhoa DATE,
    LyDo VARCHAR(255),
    SoThe VARCHAR(50),
    FOREIGN KEY (SoThe) REFERENCES TheThuVien(SoThe)
);

-- Bảng PhieuMuon
CREATE TABLE PhieuMuon (
    PhieuMuonID VARCHAR(50) PRIMARY KEY,
    NhanVienID VARCHAR(50),
    SoThe VARCHAR(50),
    NgayMuon DATE,
    FOREIGN KEY (SoThe) REFERENCES TheThuVien(SoThe),
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);

-- Bảng PhieuMuonChiTiet
CREATE TABLE PhieuMuonChiTiet (
    PhieuMuonID VARCHAR(50) PRIMARY KEY,
    ISBN VARCHAR(50),
    NgayTra DATE,
    DaTra Boolean,
    Note VARCHAR(1000),
    FOREIGN KEY (PhieuMuonID) REFERENCES PhieuMuon(PhieuMuonID),
    FOREIGN KEY (ISBN) REFERENCES Sach(ISBN)
);






-- Trigger
-- Kiểm tra tính hợp lệ user
DROP TRIGGER IF EXISTS trg_check_user_fields
DROP TRIGGER IF EXISTS trg_check_user_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_user_fields
BEFORE INSERT ON TaiKhoan
FOR EACH ROW
BEGIN
    IF NEW.User_Name IS NULL OR NEW.User_Name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username không được để trống';
    END IF;

    IF NEW.Email IS NULL OR NEW.Email = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email không được để trống';
    END IF;

    IF NEW.Pass_wd IS NULL OR NEW.Pass_wd = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password không được để trống';
    END IF;
    
    IF NEW.Role IS NULL OR NEW.Role = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Role không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_user_fields_update
BEFORE UPDATE ON TaiKhoan
FOR EACH ROW
BEGIN
    IF NEW.User_Name IS NULL OR NEW.User_Name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username không được để trống';
    END IF;

    IF NEW.Email IS NULL OR NEW.Email = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email không được để trống';
    END IF;

    IF NEW.Pass_wd IS NULL OR NEW.Pass_wd = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password không được để trống';
    END IF;
    
    IF NEW.Role IS NULL OR NEW.Role = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Role không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ chủ đề
DROP TRIGGER IF EXISTS trg_check_chude_fields
DROP TRIGGER IF EXISTS trg_check_chude_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_chude_fields
BEFORE INSERT ON ChuDe
FOR EACH ROW
BEGIN
    IF NEW.TenChuDe IS NULL OR NEW.TenChuDe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên chủ đề không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_chude_fields_update
BEFORE UPDATE ON ChuDe
FOR EACH ROW
BEGIN
    IF NEW.TenChuDe IS NULL OR NEW.TenChuDe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên chủ đề không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ Nhà xuất bản
DROP TRIGGER IF EXISTS trg_check_publisher_fields
DROP TRIGGER IF EXISTS trg_check_publisher_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_publisher_fields
BEFORE INSERT ON NXB
FOR EACH ROW
BEGIN
    IF NEW.TenNXB IS NULL OR NEW.TenNXB = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhà xuất bản không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_publisher_fields_update
BEFORE UPDATE ON NXB
FOR EACH ROW
BEGIN
    IF NEW.TenNXB IS NULL OR NEW.TenNXB = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhà xuất bản không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ của tác giả
DROP TRIGGER IF EXISTS trg_check_author_fields
DROP TRIGGER IF EXISTS trg_check_author_fields_update

DELIMITER $$
CREATE TRIGGER trg_check_author_fields
BEFORE INSERT ON TacGia
FOR EACH ROW
BEGIN
    IF NEW.TenTacGia IS NULL OR NEW.TenTacGia= '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên tác giả không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_author_fields_update
BEFORE UPDATE ON TacGia
FOR EACH ROW
BEGIN
    IF NEW.TenTacGia IS NULL OR NEW.TenTacGia = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên tác giả không được để trống';
    END IF;
END $$
DELIMITER ;






-- Function
-- kiểm tra user tồn tại?
DROP FUNCTION IF EXISTS check_user_exists
DELIMITER $$
CREATE FUNCTION check_user_exists(field VARCHAR(255), value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE userExists BOOLEAN DEFAULT FALSE;

    IF field = 'email' THEN	
        SET userExists = EXISTS (SELECT 1 FROM TaiKhoan WHERE Email = value);
    -- ELSEIF field = 'username' THEN
--         SET userExists = EXISTS (SELECT 1 FROM TaiKhoan WHERE username = value);
    END IF;

    RETURN userExists;
END$$
DELIMITER ;

-- Kiểm tra thể loại đã có chưa?
DROP FUNCTION IF EXISTS check_genres_exists
DELIMITER $$
CREATE FUNCTION check_genres_exists(value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE genresExists BOOLEAN DEFAULT FALSE;
    
        SET genresExists = EXISTS (SELECT 1 FROM ChuDe WHERE TenChuDe = value);
    
    RETURN genresExists;
END$$
DELIMITER ;

-- Kiểm tra nhà xuất bản có chưa ?
DROP FUNCTION IF EXISTS check_publisher_exists
DELIMITER $$
CREATE FUNCTION check_publisher_exists(value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE publisherExists BOOLEAN DEFAULT FALSE;

        SET publisherExists = EXISTS (SELECT 1 FROM NXB WHERE TenNXB = value);
    
    RETURN publisherExists;
END$$
DELIMITER ;

-- Kiểm tra tác giả tồn tại?
DROP FUNCTION IF EXISTS check_author_exists
DELIMITER $$
CREATE FUNCTION check_author_exists(field VARCHAR(255), value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE authorExists BOOLEAN DEFAULT FALSE;
    
    IF field = 'name' THEN	
        SET authorExists = EXISTS (SELECT 1 FROM TacGia WHERE TenTacGia = value);
    ELSEIF field = 'author_id' THEN
        SET authorExists = EXISTS (SELECT 1 FROM TacGia WHERE TacGiaID = value);
    END IF;
    
    RETURN authorExists;
END$$
DELIMITER ;






-- Procedure
-- Tạo tài khoản
DROP PROCEDURE IF EXISTS create_account;
DELIMITER //

CREATE PROCEDURE create_account (
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_role VARCHAR(20),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
account_label: BEGIN -- Đặt nhãn cho BEGIN...END
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);

    -- Kiểm tra email có tồn tại hay không
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE Email = p_email) THEN
        SET p_status = 1;
        SET p_message = 'Email đã tồn tại!';
        LEAVE account_label; -- Thoát khỏi thủ tục bằng cách dùng nhãn
    END IF;

    -- Xác định tiền tố (prefix) dựa trên role
    SET max_id = (
        SELECT MAX(ID_TaiKhoan) 
        FROM TaiKhoan 
        WHERE ID_TaiKhoan LIKE CONCAT(
            CASE WHEN p_role = 'Admin' THEN 'AD' ELSE 'NV' END, '%'
        )
    );

    -- Tạo ID mới nếu max_id không null, ngược lại dùng mã mặc định AD01 hoặc NV01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT(
            CASE WHEN p_role = 'Admin' THEN 'AD' ELSE 'NV' END,
            LPAD(SUBSTRING(max_id, 3) + 1, 2, '0')
        );
    ELSE
        SET new_id = CONCAT(CASE WHEN p_role = 'Admin' THEN 'AD' ELSE 'NV' END, '01');
    END IF;

    -- Thêm tài khoản mới vào database
    INSERT INTO TaiKhoan (ID_TaiKhoan, User_Name, Pass_wd, Email, Role)
    VALUES (new_id, p_username, p_password, p_email, p_role);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Đăng ký thành công!';
END //

DELIMITER ;

-- Tạo chủ đề
DROP PROCEDURE IF EXISTS create_chude;
DELIMITER //

CREATE PROCEDURE create_chude (
    IN p_tenchude VARCHAR(255),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
chude_label: BEGIN
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);

    -- Kiểm tra chủ đề có tồn tại hay không
    IF EXISTS (SELECT 1 FROM ChuDe WHERE TenChuDe = p_tenchude) THEN
        SET p_status = 1;
        SET p_message = 'Chủ đề đã tồn tại!';
        LEAVE chude_label;
    END IF;

    -- Xác định mã chủ đề lớn nhất hiện tại với tiền tố "CD"
    SET max_id = (
        SELECT MAX(ChuDeID)
        FROM ChuDe
        WHERE ChuDeID LIKE 'CD%'
    );

    -- Tạo mã mới nếu max_id không null, ngược lại dùng mã mặc định CD01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT('CD', LPAD(SUBSTRING(max_id, 3) + 1, 2, '0'));
    ELSE
        SET new_id = 'CD01';
    END IF;

    -- Thêm chủ đề mới vào database
    INSERT INTO ChuDe (ChuDeID, TenChuDe)
    VALUES (new_id, p_tenchude);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo chủ đề thành công!';
END //

DELIMITER ;

-- Tạo nhà xuất bản
DROP PROCEDURE IF EXISTS create_nxb;
DELIMITER //

CREATE PROCEDURE create_nxb (
    IN p_tennxb VARCHAR(255),
    IN p_diachi VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_infonguoidaidien VARCHAR(255),
    
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
nxb_label: BEGIN
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);

    -- Kiểm tra nhà xuất bản có tồn tại hay không
    IF EXISTS (SELECT 1 FROM NXB WHERE TenNXB = p_tennxb) THEN
        SET p_status = 1;
        SET p_message = 'Nhà xuất bản đã tồn tại!';
        LEAVE nxb_label;
    END IF;

    -- Xác định mã nhà xuất bản lớn nhất hiện tại với tiền tố "NXB"
    SET max_id = (
        SELECT MAX(NXB_ID)
        FROM NXB
        WHERE NXB_ID LIKE 'NXB%'
    );

    -- Tạo mã mới nếu max_id không null, ngược lại dùng mã mặc định NXB01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT('NXB', LPAD(SUBSTRING(max_id, 4) + 1, 2, '0'));
    ELSE
        SET new_id = 'NXB01';
    END IF;

    -- Thêm nhà xuất bản mới vào database
    INSERT INTO NXB (NXB_ID, TenNXB, DiaChi, Email, Info_ngDaiDien)
    VALUES (new_id, p_tennxb, p_diachi, p_email, p_infonguoidaidien);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo nhà xuất bản thành công!';
END //

DELIMITER ;

-- Tạo tác giả
DROP PROCEDURE IF EXISTS create_tacgia;
DELIMITER //

CREATE PROCEDURE create_tacgia (
    IN p_tentacgia VARCHAR(255),
    IN p_website VARCHAR(255),
    IN p_note VARCHAR(255),
    
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
tacgia_label: BEGIN
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);

    -- Kiểm tra tác giả có tồn tại hay không
    IF EXISTS (SELECT 1 FROM TacGia WHERE TenTacGia = p_tentacgia) THEN
        SET p_status = 1;
        SET p_message = 'Tác giả đã tồn tại!';
        LEAVE tacgia_label;
    END IF;

    -- Xác định mã tác giả lớn nhất hiện tại với tiền tố "TG"
    SET max_id = (
        SELECT MAX(TacGiaID)
        FROM TacGia
        WHERE TacGiaID LIKE 'TG%'
    );

    -- Tạo mã mới nếu max_id không null, ngược lại dùng mã mặc định TG01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT('TG', LPAD(SUBSTRING(max_id, 3) + 1, 2, '0'));
    ELSE
        SET new_id = 'TG01';
    END IF;

    -- Thêm tác giả mới vào database
    INSERT INTO TacGia (TacGiaID, TenTacGia, Website, Note)
    VALUES (new_id, p_tentacgia, p_website, p_note);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo tác giả thành công!';
END //

DELIMITER ;


