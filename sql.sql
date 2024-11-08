CREATE DATABASE library_management;

USE library_management;

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
    address text,
    email VARCHAR(255),
    representative_info TEXT
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address text,
    card_number INT,
    FOREIGN KEY (card_number) REFERENCES LibraryCards(card_number)
);

CREATE TABLE LibraryCards (
    card_number INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    notes TEXT
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
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);