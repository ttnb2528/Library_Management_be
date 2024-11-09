CREATE DATABASE IF NOT EXISTS library_management;

USE library_management;

DROP TABLE IF EXISTS BorrowDetails;
DROP TABLE IF EXISTS Borrows;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Readers;
DROP TABLE IF EXISTS LibraryCards;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Publishers;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Users;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    website VARCHAR(255),
    notes TEXT
);

CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(150),
    address text,
    email VARCHAR(255),
    representative_info TEXT
);

CREATE TABLE LibraryCards (
    card_number INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    notes TEXT
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    address text,
    card_number INT NULL,
    FOREIGN KEY (card_number) REFERENCES LibraryCards(card_number)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    phone_number VARCHAR(20)
);

CREATE TABLE Borrows (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    card_number INT,
    employee_id INT,
    borrow_date DATE,
    FOREIGN KEY (card_number) REFERENCES LibraryCards(card_number),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre_id INT,
    publisher_id INT,
    publish_year YEAR,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

CREATE TABLE BorrowDetails (
    borrow_id INT,
    book_id INT,
    notes TEXT,
    returned BOOLEAN DEFAULT FALSE,
    return_date DATE,
    PRIMARY KEY (borrow_id, book_id),
    FOREIGN KEY (borrow_id) REFERENCES Borrows(borrow_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger
-- Kiểm tra tính hợp lệ user
DROP TRIGGER IF EXISTS trg_check_user_fields
DELIMITER $$
CREATE TRIGGER trg_check_user_fields
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    IF NEW.username IS NULL OR NEW.username = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username không được để trống';
    END IF;

    IF NEW.email IS NULL OR NEW.email = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email không được để trống';
    END IF;

    IF NEW.password IS NULL OR NEW.password = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password không được để trống';
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_check_author_fields
DROP TRIGGER IF EXISTS trg_check_author_fields_update

DELIMITER $$
CREATE TRIGGER trg_check_author_fields
BEFORE INSERT ON Authors
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR NEW.name= '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Name không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_author_fields_update
BEFORE UPDATE ON Authors
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR NEW.name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Name không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ Genres
DROP TRIGGER IF EXISTS trg_check_genres_fields
DROP TRIGGER IF EXISTS trg_check_genres_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_genres_fields
BEFORE INSERT ON Genres
FOR EACH ROW
BEGIN
    IF NEW.genre_name IS NULL OR NEW.genre_name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên thể loại không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_genres_fields_update
BEFORE UPDATE ON Genres
FOR EACH ROW
BEGIN
    IF NEW.genre_name IS NULL OR NEW.genre_name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên thể loại không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ Publishers
DROP TRIGGER IF EXISTS trg_check_publisher_fields
DROP TRIGGER IF EXISTS trg_check_publisher_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_publisher_fields
BEFORE INSERT ON Publishers
FOR EACH ROW
BEGIN
    IF NEW.publisher_name IS NULL OR NEW.publisher_name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhà xuất bản không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_publisher_fields_update
BEFORE UPDATE ON Publishers
FOR EACH ROW
BEGIN
    IF NEW.publisher_name IS NULL OR NEW.publisher_name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhà xuất bản không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ employee
DROP TRIGGER IF EXISTS trg_check_employee_fields
DELIMITER $$
CREATE TRIGGER trg_check_employee_fields
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.full_name IS NULL OR NEW.full_name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhân viên không được để trống';
    END IF;
END $$
DELIMITER ;

-- Kiểm tra tính hợp lệ reader
DROP TRIGGER IF EXISTS trg_check_reader_fields
DROP TRIGGER IF EXISTS trg_check_reader_fields_update
DELIMITER $$
CREATE TRIGGER trg_check_reader_fields
BEFORE INSERT ON Readers
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR NEW.name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên độc giả không được để trống';
    END IF;
END $$

CREATE TRIGGER trg_check_reader_fields_update
BEFORE UPDATE ON Readers
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR NEW.name = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên độc giả không được để trống';
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
        SET userExists = EXISTS (SELECT 1 FROM Users WHERE email = value);
    ELSEIF field = 'username' THEN
        SET userExists = EXISTS (SELECT 1 FROM Users WHERE username = value);
    END IF;

    RETURN userExists;
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
        SET authorExists = EXISTS (SELECT 1 FROM Authors WHERE name = value);
    ELSEIF field = 'author_id' THEN
        SET authorExists = EXISTS (SELECT 1 FROM Authors WHERE author_id = CAST(value AS UNSIGNED));
    END IF;
    
    RETURN authorExists;
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
    
        SET genresExists = EXISTS (SELECT 1 FROM Genres WHERE genre_name = value);
    
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

        SET publisherExists = EXISTS (SELECT 1 FROM Publishers WHERE publisher_name = value);
    
    RETURN publisherExists;
END$$
DELIMITER ;

-- Kiểm tra nhân viên có chưa ?
DROP FUNCTION IF EXISTS check_employee_exists
DELIMITER $$
CREATE FUNCTION check_employee_exists(value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE employeeExists BOOLEAN DEFAULT FALSE;

        SET employeeExists = EXISTS (SELECT 1 FROM Employees WHERE full_name = value);
    
    RETURN employeeExists;
END$$
DELIMITER ;

-- Kiểm tra nhân viên có tồn tại không ?
DROP FUNCTION IF EXISTS check_card_exists
DELIMITER $$
CREATE FUNCTION check_card_exists(value VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE cardExists BOOLEAN DEFAULT FALSE;

        SET cardExists = EXISTS (SELECT 1 FROM LibraryCards WHERE card_number = value);
    
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
			SET readerExists = EXISTS (SELECT 1 FROM Readers WHERE name = value);
		ELSEIF field = 'reader_id' THEN
			SET readerExists = EXISTS (SELECT 1 FROM Readers WHERE reader_id = value);
		END IF;
    
    RETURN readerExists;
END$$
DELIMITER ;

-- Procedure
-- vừa tạo độc giả vừa tạo thẻ

DROP PROCEDURE IF EXISTS create_reader_with_card
DELIMITER //
CREATE PROCEDURE create_reader_with_card(
    IN reader_name VARCHAR(255),
    IN reader_address VARCHAR(255),
    IN card_start_date DATE,
    IN card_end_date DATE
)
BEGIN
    DECLARE readerId INT;
    DECLARE cardId INT;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Tạo độc giả mới
    INSERT INTO Readers (name, address) VALUES (reader_name, reader_address);
    SET readerId = LAST_INSERT_ID();

    -- Tạo thẻ thư viện mới
    INSERT INTO LibraryCards (start_date, end_date) VALUES (card_start_date, card_end_date);
    SET cardId = LAST_INSERT_ID();

    -- Cập nhật ID thẻ thư viện vào bảng Readers để liên kết độc giả và thẻ
    UPDATE Readers SET card_number = cardId WHERE reader_id = readerId;

    -- Commit nếu tất cả các lệnh đều thành công
    COMMIT;
END //
DELIMITER ;

-- Thêm độc giả rồi, thêm thẻ sau
DROP PROCEDURE IF EXISTS AssignLibraryCardToReader
DELIMITER //
CREATE PROCEDURE AssignLibraryCardToReader(
    IN readerId INT,
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    DECLARE newCardId INT;

    -- Bắt đầu transaction
    START TRANSACTION;

    -- Bước 1: Tạo thẻ thư viện mới
    INSERT INTO LibraryCards (start_date, end_date) VALUES (startDate, endDate);
    SET newCardId = LAST_INSERT_ID();

    -- Bước 2: Liên kết thẻ với độc giả
    UPDATE Readers SET card_number = newCardId WHERE reader_id = readerId;

    -- Kiểm tra và Commit nếu thành công, Rollback nếu có lỗi
    IF ROW_COUNT() > 0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END //
DELIMITER ;

