CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Xóa bảng nếu nó tồn tại
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

-- Tạo lại bảng
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    website VARCHAR(255),
    notes TEXT
);

CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(150) NOT NULL,
    address TEXT,
    email VARCHAR(255),
    representative_info TEXT
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    genre_id INT NOT NULL,
    publisher_id INT NOT NULL,
    publish_year YEAR,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

CREATE TABLE LibraryCards (
    card_number INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE NOT NULL,
    end_date DATE,
    notes TEXT
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    card_number INT NOT NULL UNIQUE,
    FOREIGN KEY (card_number) REFERENCES LibraryCards(card_number) ON DELETE CASCADE
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    phone_number VARCHAR(20)
);

CREATE TABLE Borrows (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    card_number INT NOT NULL,
    employee_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    FOREIGN KEY (card_number) REFERENCES LibraryCards(card_number) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE BorrowDetails (
    borrow_id INT NOT NULL,
    book_id INT NOT NULL,
    notes TEXT,
    return_date DATE DEFAULT NULL,
    PRIMARY KEY (borrow_id, book_id),
    FOREIGN KEY (borrow_id) REFERENCES Borrows(borrow_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);