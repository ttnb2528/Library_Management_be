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
    FOREIGN KEY (SoThe) REFERENCES TheThuVien(SoThe) ON DELETE CASCADE
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
    PhieuMuonID VARCHAR(50),
    ISBN VARCHAR(50),
    NgayTra DATE,
    DaTra BOOLEAN,
    Note VARCHAR(1000),
    PRIMARY KEY (PhieuMuonID, ISBN), -- Khóa chính là cặp (PhieuMuonID, ISBN)
    FOREIGN KEY (PhieuMuonID) REFERENCES PhieuMuon(PhieuMuonID),
    FOREIGN KEY (ISBN) REFERENCES Sach(ISBN)
)



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

-- Kiểm tra tính hợp lệ sách
DROP TRIGGER IF EXISTS trg_check_book_fields
DROP TRIGGER IF EXISTS trg_check_book_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_book_fields
BEFORE INSERT ON Sach
FOR EACH ROW
BEGIN
    IF NEW.TenSach IS NULL OR NEW.TenSach = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên sách không được để trống';
    END IF;

    IF NEW.SoTrang IS NULL OR NEW.SoTrang = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số trang không được để trống';
    END IF;

    IF NEW.Soluong IS NULL OR NEW.Soluong = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được để trống';
    END IF;
    
    IF NEW.MoTa IS NULL OR NEW.MoTa = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mô tả không được để trống';
    END IF;
    
    IF NEW.ChuDeID IS NULL OR NEW.ChuDeID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chủ đề không được để trống';
    END IF;
    
    IF NEW.NXB_ID IS NULL OR NEW.NXB_ID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhà xuất bản không được để trống';
    END IF;
    
    IF NEW.TacGiaID IS NULL OR NEW.TacGiaID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tác giả không được để trống';
    END IF;
    
    IF NEW.NamXB IS NULL OR NEW.NamXB = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Năm xuất bản không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_book_fields_update
BEFORE UPDATE ON Sach
FOR EACH ROW
BEGIN
    IF NEW.TenSach IS NULL OR NEW.TenSach = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên sách không được để trống';
    END IF;

    IF NEW.SoTrang IS NULL OR NEW.SoTrang = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số trang không được để trống';
    END IF;

    IF NEW.Soluong IS NULL OR NEW.Soluong = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được để trống';
    END IF;
    
    IF NEW.MoTa IS NULL OR NEW.MoTa = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mô tả không được để trống';
    END IF;
    
    IF NEW.ChuDeID IS NULL OR NEW.ChuDeID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chủ đề không được để trống';
    END IF;
    
    IF NEW.NXB_ID IS NULL OR NEW.NXB_ID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhà xuất bản không được để trống';
    END IF;
    
    IF NEW.TacGiaID IS NULL OR NEW.TacGiaID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tác giả không được để trống';
    END IF;
    
    IF NEW.NamXB IS NULL OR NEW.NamXB = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Năm xuất bản không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ độc giả
DROP TRIGGER IF EXISTS trg_check_reader_fields
DROP TRIGGER IF EXISTS trg_check_reader_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_reader_fields
BEFORE INSERT ON DocGia
FOR EACH ROW
BEGIN
    IF NEW.TenDocGia IS NULL OR NEW.TenDocGia = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên độc giả không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_reader_fields_update
BEFORE UPDATE ON DocGia
FOR EACH ROW
BEGIN
    IF NEW.TenDocGia IS NULL OR NEW.TenDocGia = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên độc giả không được để trống';
    END IF;
END $$
DELIMITER ;

-- Tính hợp lệ nhân viên
DROP TRIGGER IF EXISTS trg_check_employee_fields
DROP TRIGGER IF EXISTS trg_check_employee_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_employee_fields
BEFORE INSERT ON NhanVien
FOR EACH ROW
BEGIN
    IF NEW.HoTen IS NULL OR NEW.HoTen = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhân viên không được để trống';
    END IF;
    
    IF NEW.SDT IS NULL OR NEW.SDT = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_employee_fields_update
BEFORE UPDATE ON NhanVien
FOR EACH ROW
BEGIN
    IF NEW.HoTen IS NULL OR NEW.HoTen = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhân viên không được để trống';
    END IF;
    
    IF NEW.SDT IS NULL OR NEW.SDT = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ phiếu mượn
DROP TRIGGER IF EXISTS trg_check_phieu_muon_fields
DROP TRIGGER IF EXISTS trg_check_phieu_muon_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_phieu_muon_fields
BEFORE INSERT ON PhieuMuon
FOR EACH ROW
BEGIN
    IF NEW.NhanVienID IS NULL OR NEW.NhanVienID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;
    
    IF NEW.SoThe IS NULL OR NEW.SoThe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số thẻ không được để trống';
    END IF;
    
    -- IF NEW.NgayMuon IS NULL OR NEW.NgayMuon = '' THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Ngày mượn không được để trống';
--     END IF;
END $$

CREATE TRIGGER trg_check_phieu_muon_fields_update
BEFORE UPDATE ON PhieuMuon
FOR EACH ROW
BEGIN
    IF NEW.NhanVienID IS NULL OR NEW.NhanVienID = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;
    
    IF NEW.SoThe IS NULL OR NEW.SoThe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số thẻ không được để trống';
    END IF;
    
    -- IF NEW.NgayMuon IS NULL OR NEW.NgayMuon = '' THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Ngày mượn không được để trống';
--     END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ chi tiết phiếu mượn
DROP TRIGGER IF EXISTS trg_check_ct_phieu_muon_fields
DROP TRIGGER IF EXISTS trg_check_ct_phieu_muon_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_ct_phieu_muon_fields
BEFORE INSERT ON PhieuMuonChiTiet
FOR EACH ROW
BEGIN
    IF NEW.ISBN IS NULL OR NEW.ISBN = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã sách không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_ct_phieu_muon_fields_update
BEFORE UPDATE ON PhieuMuonChiTiet
FOR EACH ROW
BEGIN
    IF NEW.ISBN IS NULL OR NEW.ISBN = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã sách không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ tài khoản vi phạm
DROP TRIGGER IF EXISTS trg_check_vipham_fields
DROP TRIGGER IF EXISTS trg_check_vipham_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_vipham_fields
BEFORE INSERT ON TaiKhoanViPham
FOR EACH ROW
BEGIN
    
    IF NEW.LyDo IS NULL OR NEW.LyDo = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lý do không được để trống';
    END IF;
    
    IF NEW.SoThe IS NULL OR NEW.SoThe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số thẻ không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_vipham_fields_update
BEFORE UPDATE ON TaiKhoanViPham
FOR EACH ROW
BEGIN
    
    IF NEW.LyDo IS NULL OR NEW.LyDo = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lý do không được để trống';
    END IF;
    
    IF NEW.SoThe IS NULL OR NEW.SoThe = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số thẻ không được để trống';
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

-- kiểm tra có sách chưa
DROP FUNCTION IF EXISTS check_book_exists
DELIMITER $$
CREATE FUNCTION check_book_exists(field VARCHAR(255), value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE bookExists BOOLEAN DEFAULT FALSE;

    IF field = 'TenSach' THEN	
        SET bookExists = EXISTS (SELECT 1 FROM Sach WHERE TenSach = value);
    ELSEIF field = 'ISBN' THEN
       SET bookExists = EXISTS (SELECT 1 FROM Sach WHERE ISBN = value);
    END IF;

    RETURN bookExists;
END$$
DELIMITER ;

-- Kiểm tra thẻ thư viện có tồn tại không ?
DROP FUNCTION IF EXISTS check_card_exists
DELIMITER $$
CREATE FUNCTION check_card_exists(value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE cardExists BOOLEAN DEFAULT FALSE;

        SET cardExists = EXISTS (SELECT 1 FROM TheThuVien WHERE SoThe = value);
    
    RETURN cardExists;
END$$
DELIMITER ;

-- Kiểm tra độc giả có tồn tại không ?
DROP FUNCTION IF EXISTS check_reader_exists
DELIMITER $$
CREATE FUNCTION check_reader_exists(field VARCHAR(255), value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE readerExists BOOLEAN DEFAULT FALSE;

		IF field = 'name' THEN	
			SET readerExists = EXISTS (SELECT 1 FROM DocGia WHERE TenDocGia = value);
		ELSEIF field = 'reader_id' THEN
			SET readerExists = EXISTS (SELECT 1 FROM DocGia WHERE DocGiaID = value);
		END IF;
    
    RETURN readerExists;
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
    IN p_full_name VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
account_label: BEGIN -- Đặt nhãn cho BEGIN...END
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);
    DECLARE new_nv_id VARCHAR(50); -- Khai báo biến new_nv_id ngoài IF

    -- Kiểm tra email có tồn tại hay không
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE Email = p_email) THEN
        SET p_status = 1;
        SET p_message = 'Email đã tồn tại!';
        LEAVE account_label; -- Thoát khỏi thủ tục nếu email đã tồn tại
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

    -- Nếu role là 'Admin', chỉ tạo tài khoản
    IF p_role = 'Admin' THEN
        -- Thêm tài khoản mới vào database
        INSERT INTO TaiKhoan (ID_TaiKhoan, User_Name, Pass_wd, Email, Role)
        VALUES (new_id, p_username, p_password, p_email, p_role);
        SET p_status = 0;
        SET p_message = 'Đăng ký tài khoản Admin thành công!';
        LEAVE account_label;
    END IF;

    -- Nếu role là 'NhanVien', vừa tạo tài khoản vừa thêm thông tin nhân viên
    IF p_role = 'NhanVien' THEN
        -- Thêm tài khoản mới vào database
        INSERT INTO TaiKhoan (ID_TaiKhoan, User_Name, Pass_wd, Email, Role)
        VALUES (new_id, p_username, p_password, p_email, p_role);

        -- Tạo mã nhân viên
        SET new_nv_id = CONCAT('NV', LPAD(SUBSTRING(new_id, 3) + 1, 2, '0'));

        -- Thêm thông tin nhân viên vào bảng NhanVien
        INSERT INTO NhanVien (NhanVienID, HoTen, SDT, ID_TaiKhoan)
        VALUES (new_nv_id, p_full_name, p_phone_number, new_id); -- Các trường khác như HoTen, NgaySinh, SDT có thể được cập nhật sau

        SET p_status = 0;
        SET p_message = 'Đăng ký tài khoản và nhân viên thành công!';
    END IF;

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

-- Tạo Sách
DROP PROCEDURE IF EXISTS create_sach;
DELIMITER //

CREATE PROCEDURE create_sach (
    IN p_tensach VARCHAR(255),
    IN p_sotrang INT,
    IN p_soluong INT,
    IN p_mota VARCHAR(255),
    IN p_chudeid VARCHAR(255),
    IN p_nxbid VARCHAR(255),
    IN p_tacgiaid VARCHAR(255),
    IN p_namxb DATE,
    
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
sach_label: BEGIN
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);

    -- Kiểm tra sách có tồn tại hay không
    IF EXISTS (SELECT 1 FROM Sach WHERE TenSach = p_tensach) THEN
        SET p_status = 1;
        SET p_message = 'Sách đã tồn tại!';
        LEAVE sach_label;
    END IF;

    -- Xác định mã sách lớn nhất hiện tại với tiền tố "ISBN"
    SET max_id = (
        SELECT MAX(ISBN)
        FROM Sach
        WHERE ISBN LIKE 'ISBN%'
    );

    -- Tạo mã mới nếu max_id không null, ngược lại dùng mã mặc định ISBN01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT('ISBN', LPAD(SUBSTRING(max_id, 5) + 1, 2, '0'));
    ELSE
        SET new_id = 'ISBN01';
    END IF;

    -- Thêm sách mới vào database
    INSERT INTO Sach (ISBN, TenSach, SoTrang, Soluong, MoTa, ChuDeID, NXB_ID, TacGiaID, NamXB)
    VALUES (new_id, p_tensach, p_sotrang, p_soluong, p_mota, p_chudeid, p_nxbid, p_tacgiaid, p_namxb);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo sách thành công!';
END //

DELIMITER ;


-- tạo đọc giả và thẻ
DROP PROCEDURE IF EXISTS create_reader_with_card;
DELIMITER //

CREATE PROCEDURE create_reader_with_card(
    IN reader_name VARCHAR(255),
    IN reader_address VARCHAR(255),
    IN reader_phone VARCHAR(20),
    IN card_start_date DATE,
    IN card_end_date DATE,
    IN card_note VARCHAR(1000),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
create_reader_with_card_label: BEGIN
    DECLARE max_reader_id VARCHAR(10);
    DECLARE new_reader_id VARCHAR(10);
    DECLARE max_card_id VARCHAR(10);
    DECLARE new_card_id VARCHAR(10);

    -- Xử lý lỗi: nếu có lỗi, rollback và gán thông báo lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET p_status = 1;
        SET p_message = 'Đã xảy ra lỗi khi tạo độc giả hoặc thẻ thư viện!';
    END;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Kiểm tra xem độc giả với tên này đã tồn tại chưa
    IF EXISTS (
        SELECT 1 
        FROM DocGia 
        WHERE TenDocGia = reader_name
    ) THEN
        SET p_status = 1;
        SET p_message = 'Độc giả đã tồn tại!';
        ROLLBACK;
        -- Kết thúc thủ tục nếu đã tồn tại độc giả
        LEAVE create_reader_with_card_label;
    END IF;

    -- Kiểm tra xem mã thẻ thư viện đã tồn tại chưa
    IF EXISTS (
        SELECT 1 
        FROM TheThuVien 
        WHERE SoThe = new_card_id
    ) THEN
        SET p_status = 1;
        SET p_message = 'Thẻ thư viện đã tồn tại!';
        ROLLBACK;
        -- Kết thúc thủ tục nếu đã tồn tại thẻ thư viện
        LEAVE create_reader_with_card_label;
    END IF;

    -- Xác định mã độc giả lớn nhất hiện tại với tiền tố "DG"
    SET max_reader_id = (
    SELECT MAX(DocGiaID)
    FROM DocGia
    WHERE DocGiaID LIKE 'DG%'
);

-- Tạo mã độc giả mới nếu max_reader_id không null, ngược lại dùng mã mặc định DG01
IF max_reader_id IS NOT NULL THEN
    SET new_reader_id = CONCAT('DG', LPAD(CAST(SUBSTRING(max_reader_id, 3) AS UNSIGNED) + 1, 2, '0'));
ELSE
    SET new_reader_id = 'DG01';
END IF;

-- Xác định mã thẻ thư viện lớn nhất hiện tại với tiền tố "ST"
SET max_card_id = (
    SELECT MAX(SoThe)
    FROM TheThuVien
    WHERE SoThe LIKE 'ST%'
);

-- Tạo mã thẻ thư viện mới nếu max_card_id không null, ngược lại dùng mã mặc định ST01
IF max_card_id IS NOT NULL THEN
    SET new_card_id = CONCAT('ST', LPAD(CAST(SUBSTRING(max_card_id, 3) AS UNSIGNED) + 1, 2, '0'));
ELSE
    SET new_card_id = 'ST01';
END IF;

    -- Thêm thẻ thư viện mới vào bảng TheThuVien
    INSERT INTO TheThuVien (SoThe, Start_date, End_date, Note)
    VALUES (new_card_id, card_start_date, card_end_date, card_note);

    -- Thêm độc giả mới vào bảng DocGia và liên kết với mã thẻ thư viện
    INSERT INTO DocGia (DocGiaID, TenDocGia, DiaChi, SDT, SoThe)
    VALUES (new_reader_id, reader_name, reader_address, reader_phone, new_card_id);

    -- Commit nếu tất cả các lệnh đều thành công
    COMMIT;

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo độc giả và thẻ thư viện thành công!';
END //

DELIMITER ;

-- Xóa độc giả và thẻ
DROP PROCEDURE IF EXISTS delete_reader_with_card;
DELIMITER //

CREATE PROCEDURE delete_reader_with_card(
    IN reader_id VARCHAR(10),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    -- Xử lý lỗi: nếu có lỗi, rollback và gán thông báo lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_status = 1;
        SET p_message = 'Đã xảy ra lỗi khi xóa độc giả và thẻ thư viện!';
    END;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Xóa thẻ thư viện khỏi bảng TheThuVien trước khi xóa độc giả
    DELETE FROM TheThuVien WHERE SoThe = (SELECT SoThe FROM DocGia WHERE DocGiaID = reader_id LIMIT 1);

    -- Xóa độc giả khỏi bảng DocGia
    DELETE FROM DocGia WHERE DocGiaID = reader_id;

    -- Commit nếu không có lỗi
    COMMIT;

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Xóa độc giả và thẻ thư viện thành công!';
END //

DELIMITER ;

-- Xóa nhân viên và tài khoản
DROP PROCEDURE IF EXISTS delete_employee_with_account;
DELIMITER //

CREATE PROCEDURE delete_employee_with_account(
    IN account_id VARCHAR(10),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    -- Xử lý lỗi: nếu có lỗi, rollback và gán thông báo lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_status = 1;
        SET p_message = 'Đã xảy ra lỗi khi xóa nhân viên và tài khoản!';
    END;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Xóa nhân viên bảng NhanVien trước khi xóa tài khoản
    DELETE FROM NhanVien WHERE ID_TaiKhoan = account_id;
    -- Xóa tài khoản khỏi bảng TaiKhoan
    DELETE FROM TaiKhoan WHERE ID_TaiKhoan = account_id;

    -- Commit nếu không có lỗi
    COMMIT;

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Xóa nhân viên và tài khoản thành công!';
END //

DELIMITER ;

-- Tạo Phiếu mượn
DROP PROCEDURE IF EXISTS create_loan_with_details;
DELIMITER //

CREATE PROCEDURE create_loan_with_details(
    IN staff_id VARCHAR(50),
    IN card_id VARCHAR(50),
    IN loan_date DATE,
    IN book_isbns TEXT, -- Danh sách ISBN của sách được mượn (dùng ',' để ngăn cách)
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE max_loan_id VARCHAR(10);
    DECLARE new_loan_id VARCHAR(10);
    DECLARE isbn_value VARCHAR(50);
    DECLARE pos INT DEFAULT 1;
    DECLARE isbn_count INT;
    DECLARE clean_isbns TEXT;

    -- Xử lý lỗi: nếu có lỗi, rollback và gán thông báo lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET p_status = 1;
        SET p_message = 'Đã xảy ra lỗi khi tạo phiếu mượn hoặc chi tiết phiếu mượn!';
    END;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Xác định mã phiếu mượn lớn nhất hiện tại với tiền tố "PM"
    SET max_loan_id = (
        SELECT MAX(PhieuMuonID)
        FROM PhieuMuon
        WHERE PhieuMuonID LIKE 'PM%'
    );

    -- Tạo mã phiếu mượn mới nếu max_loan_id không null, ngược lại dùng mã mặc định PM01
    IF max_loan_id IS NOT NULL THEN
        SET new_loan_id = CONCAT('PM', LPAD(CAST(SUBSTRING(max_loan_id, 3) AS UNSIGNED) + 1, 2, '0'));
    ELSE
        SET new_loan_id = 'PM01';
    END IF;

    -- Thêm phiếu mượn mới vào bảng PhieuMuon
    INSERT INTO PhieuMuon (PhieuMuonID, NhanVienID, SoThe, NgayMuon)
    VALUES (new_loan_id, staff_id, card_id, loan_date);
    
     -- Loại bỏ khoảng trắng thừa trong chuỗi ISBN
    SET clean_isbns = REPLACE(book_isbns, ' ', '');

    -- Tính số lượng ISBN trong chuỗi sau khi đã loại bỏ khoảng trắng
    SET isbn_count = LENGTH(clean_isbns) - LENGTH(REPLACE(clean_isbns, ',', '')) + 1;

    -- Thêm chi tiết phiếu mượn vào bảng PhieuMuonChiTiet cho mỗi ISBN trong danh sách
    WHILE pos <= isbn_count DO
        SET isbn_value = SUBSTRING_INDEX(SUBSTRING_INDEX(clean_isbns, ',', pos), ',', -1);
        INSERT INTO PhieuMuonChiTiet (PhieuMuonID, ISBN, DaTra)
        VALUES (new_loan_id, isbn_value, FALSE);
        SET pos = pos + 1;
    END WHILE;

    -- Commit nếu tất cả các lệnh đều thành công
    COMMIT;

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo phiếu mượn và chi tiết phiếu mượn thành công!';
END //

DELIMITER ;

-- Xóa độc phiếu mượn và chi tiết phiếu mượn
DROP PROCEDURE IF EXISTS delete_loan_and_detail;
DELIMITER //

CREATE PROCEDURE delete_loan_and_detail(
    IN phieumuon_id VARCHAR(10),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    -- Xử lý lỗi: nếu có lỗi, rollback và gán thông báo lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_status = 1;
        SET p_message = 'Đã xảy ra lỗi khi xóa phiếu mượn và chi tiết phiếu mượn!';
    END;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Xóa thẻ thư viện khỏi bảng TheThuVien trước khi xóa độc giả
    DELETE FROM PhieuMuonChiTiet WHERE PhieuMuonID = phieumuon_id;

    -- Xóa độc giả khỏi bảng DocGia
    DELETE FROM PhieuMuon WHERE PhieuMuonID = phieumuon_id;

    -- Commit nếu không có lỗi
    COMMIT;

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Xóa phiếu mượn và chi tiết phiếu mượn thành công!';
END //

DELIMITER ;


-- Tạo tài khoản vi phạm
DROP PROCEDURE IF EXISTS create_vipham;
DELIMITER //

CREATE PROCEDURE create_vipham (
    IN p_ngaykhoa DATE,
    IN p_ngaymokhoa DATE,
    IN p_lydo VARCHAR(255),
    IN p_sothe VARCHAR(255),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
vipham_label: BEGIN
    DECLARE max_id VARCHAR(10);
    DECLARE new_id VARCHAR(10);
    DECLARE latest_ngaymokhoa DATE;
    
    -- select p_ngaykhoa as ngaykhoa,
-- 			p_ngaymokhoa as ngaymokhoa;

    -- Kiểm tra thẻ có bị khóa trước đó không
    IF EXISTS (SELECT 1 FROM TaiKhoanViPham WHERE SoThe = p_sothe) THEN

        -- Lấy NgayMoKhoa của lần vi phạm gần nhất
        SELECT NgayMoKhoa INTO latest_ngaymokhoa
        FROM TaiKhoanViPham
        WHERE SoThe = p_sothe
        ORDER BY NgayKhoa DESC
        LIMIT 1;

        -- Kiểm tra nếu NgayMoKhoa chưa đến hạn mở
        IF latest_ngaymokhoa > CURDATE() THEN
            SET p_status = 1;
            SET p_message = 'Thẻ vẫn đang bị khóa! Không thể tạo vi phạm mới.';
            LEAVE vipham_label;
        END IF;
    END IF;

    -- Xác định mã vi phạm lớn nhất hiện tại với tiền tố "TVP"
    SET max_id = (
        SELECT MAX(ID)
        FROM TaiKhoanViPham
        WHERE ID LIKE 'TVP%'
    );

    -- Tạo mã mới nếu max_id không null, ngược lại dùng mã mặc định TVP01
    IF max_id IS NOT NULL THEN
        SET new_id = CONCAT('TVP', LPAD(SUBSTRING(max_id, 4) + 1, 2, '0'));
    ELSE
        SET new_id = 'TVP01';
    END IF;

    -- Thêm thẻ vi phạm mới vào database
    INSERT INTO TaiKhoanViPham (ID, NgayKhoa, NgayMoKhoa, LyDo, SoThe)
    VALUES (new_id, p_ngaykhoa, p_ngaymokhoa, p_lydo, p_sothe);

    -- Trả về kết quả thành công
    SET p_status = 0;
    SET p_message = 'Tạo thẻ vi phạm thành công!';
END //

DELIMITER ;

-- thống kê mượn sách

DELIMITER //

CREATE PROCEDURE ThongKeMuonSach(
    IN so_thang INT,
    OUT so_lan_muon INT,
    OUT so_cuon_sach_muon INT
)
BEGIN
    SELECT 
        COUNT(DISTINCT pm.PhieuMuonID) INTO so_lan_muon,
        COUNT(DISTINCT pmct.ISBN) INTO so_cuon_sach_muon
    FROM 
        PhieuMuon pm
    JOIN 
        PhieuMuonChiTiet pmct ON pm.PhieuMuonID = pmct.PhieuMuonID
    WHERE 
        pm.NgayMuon >= DATE_SUB(CURDATE(), INTERVAL so_thang MONTH);
END //

DELIMITER ;