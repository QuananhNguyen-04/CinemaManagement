--PHẦN 1: TẠO CSDL
--I. Tạo bảng dữ liệu
--Tạo cơ sở dữ liệu
LANGUAGE plpgsql
CREATE DATABASE CinemaManagement;
USE CinemaManagement;

--Tạo bảng Employee (Nhân viên)
CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gmail VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Position VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    Salary DECIMAL(10, 2),
    Specialization VARCHAR(100),
    EmploymentType VARCHAR(20),
    HourlyRate DECIMAL(10, 2),
    LeaveDay INT CHECK (LeaveDay >= 0),
    CHECK (Position IN ('Manager', 'Technical', 'Ticket Seller', 'Food Seller', 'Cleaning Staff', 'Ticket Checker'))
);

--Tạo bảng Cinema (Rạp chiếu phim)
CREATE TABLE Cinema (
    CinemaID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL,
    PhoneNumber VARCHAR(15),
    Revenue DECIMAL(15, 2) DEFAULT 0 CHECK (Revenue >= 0)
);

--Tạo bảng Room (Phòng chiếu)
CREATE TABLE Room (
    RoomID VARCHAR(10) PRIMARY KEY,
    CinemaID VARCHAR(10) NOT NULL,
    NumberOfSeats INT NOT NULL CHECK (NumberOfSeats > 0),
    BrokenItems INT DEFAULT 0 CHECK (BrokenItems >= 0),
    FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

--Tạo bảng Seats (Ghế)
CREATE TABLE Seats (
    SeatID VARCHAR(10) PRIMARY KEY,
    RoomID VARCHAR(10) NOT NULL,
    RowNumber INT NOT NULL CHECK (RowNumber > 0),
    SeatNumber INT NOT NULL CHECK (SeatNumber > 0),
    SeatStatus VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    CHECK (SeatStatus IN ('Available', 'Broken', 'Reserved'))
);

--Tạo bảng Movie (Phim)
CREATE TABLE Movie (
    MovieID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    Director VARCHAR(100),
    ReleaseDate DATE,
    Duration INT NOT NULL CHECK (Duration > 0),
    Trailer VARCHAR(255)
);

--Tạo bảng Screening (Lịch chiếu)
CREATE TABLE Screening (
    ScreeningID VARCHAR(10) PRIMARY KEY,
    RoomID VARCHAR(10) NOT NULL,
    MovieID VARCHAR(10) NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    Quantity INT DEFAULT 0 CHECK (Quantity >= 0),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    CHECK (StartTime < EndTime)
);

--Tạo bảng Ticket (Vé)
CREATE TABLE Ticket (
    TicketID SERIAL PRIMARY KEY,
    ScreeningID VARCHAR(10) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    SeatNumber VARCHAR(10) NOT NULL,
    Age INT CHECK (Age >= 0),
    OnOffline BOOLEAN NOT NULL,
    SeatID VARCHAR(10),
    FOREIGN KEY (ScreeningID) REFERENCES Screening(ScreeningID)
);

--Tạo bảng Customer (Khách hàng)
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15)
);

--Tạo bảng FoodItem (Đồ ăn)
CREATE TABLE FoodItem (
    FoodItemID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0)
);

--Tạo bảng Revenue (Doanh thu)
CREATE TABLE Revenue (
    RevenueID SERIAL PRIMARY KEY,
    CinemaID VARCHAR(10) NOT NULL,
    RevenueDate DATE NOT NULL,
    Source VARCHAR(50) NOT NULL,
    Total DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID),
    CHECK (Source IN ('Ticket Sales', 'Food Sales', 'Other'))
);

--II. Nhập dữ liệu
--Bảng Employee
INSERT INTO Employee (EmployeeID, FirstName, LastName, Gmail, Address, PhoneNumber, Position, StartDate, Salary, Specialization, EmploymentType, HourlyRate, LeaveDay)
VALUES
('EMP001', 'John', 'Doe', 'john.doe@gmail.com', '123 Main St', '1234567890', 'Manager', '2020-01-01', 5000.00, NULL, NULL, NULL, NULL),
('EMP002', 'Alice', 'Smith', 'alice.smith@gmail.com', '456 Oak Ave', '0987654321', 'Technical', '2021-02-01', 3500.00, 'Projector Maintenance', NULL, NULL, NULL),
('EMP003', 'Bob', 'Johnson', 'bob.johnson@gmail.com', '789 Pine Rd', '1122334455', 'Ticket Seller', '2022-03-01', NULL, NULL, 'Full-Time', 15.00, 2),
('EMP004', 'Jane', 'Davis', 'jane.davis@gmail.com', '321 Maple Dr', '2233445566', 'Food Seller', '2023-04-01', NULL, NULL, 'Seasonal', 12.00, 1),
('EMP005', 'Chris', 'Brown', 'chris.brown@gmail.com', '654 Elm St', '3344556677', 'Cleaning Staff', '2022-05-01', NULL, NULL, 'Full-Time', 10.00, 3);

--Bảng Cinema
INSERT INTO Cinema (CinemaID, Name, Address, PhoneNumber, Revenue)
VALUES
('CIN001', 'BK Cinema', '1 Nguyen Hue Street', '0555123456', 150000.50),
('CIN002', 'BK Cinema', '22 Hai Ba Trung Road', '0555654321', 200000.00),
('CIN003', 'BK Cinema', '3 Dien Bien Phu Square', '0555789123', 250000.75);

--Bảng Room
INSERT INTO Room (RoomID, CinemaID, NumberOfSeats, BrokenItems)
VALUES
('R001', 'CIN001', 120, 2),
('R002', 'CIN001', 100, 0),
('R003', 'CIN002', 150, 3),
('R004', 'CIN003', 200, 1);

--Bảng Movie
INSERT INTO Movie (MovieID, Name, Genre, Director, ReleaseDate, Duration, Trailer)
VALUES
('MOV001', 'Avatar', 'Sci-Fi', 'James Cameron', '2009-12-18', 162, 'avatar-trailer.com'),
('MOV002', 'Inception', 'Action', 'Christopher Nolan', '2010-07-16', 148, 'inception-trailer.com'),
('MOV003', 'Titanic', 'Drama', 'James Cameron', '1997-12-19', 195, 'titanic-trailer.com'),
('MOV004', 'Interstellar', 'Sci-Fi', 'Christopher Nolan', '2014-11-07', 169, 'interstellar-trailer.com');

--Bảng Seats
INSERT INTO Seats (SeatID, RoomID, RowNumber, SeatNumber, SeatStatus)
VALUES
('S001', 'R001', 1, 1, 'Available'),
('S002', 'R001', 1, 2, 'Reserved'),
('S003', 'R001', 2, 1, 'Available'),
('S004', 'R001', 2, 2, 'Broken'),
('S005', 'R002', 1, 1, 'Available'),
('S006', 'R002', 1, 2, 'Available'),
('S007', 'R002', 2, 1, 'Reserved'),
('S008', 'R002', 2, 2, 'Broken');

--Bảng Screening
INSERT INTO Screening (ScreeningID, RoomID, MovieID, StartTime, EndTime, Quantity)
VALUES
('SCR001', 'R001', 'MOV001', '2024-12-10 14:00:00', '2024-12-10 16:42:00', 100),
('SCR002', 'R002', 'MOV002', '2024-12-11 18:00:00', '2024-12-11 20:28:00', 90),
('SCR003', 'R003', 'MOV003', '2024-12-12 15:00:00', '2024-12-12 18:15:00', 120),
('SCR004', 'R004', 'MOV004', '2024-12-13 19:00:00', '2024-12-13 21:49:00', 150);

--Bảng Ticket
INSERT INTO Ticket (ScreeningID, Price, SeatNumber, Age, OnOffline, SeatID)
VALUES
('SCR001', 100.00, 'A1', 25, TRUE, 'S001'),
('SCR001', 100.00, 'A2', 30, FALSE, 'S002'),
('SCR002', 120.00, 'B1', 18, TRUE, 'S005'),
('SCR003', 150.00, 'C1', 40, FALSE, 'S007');

--Bảng Customer
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber)
VALUES
('Quan Hai', 'Ho', 'hohai@gmail.com', '0900111222'),
('Dang Quang', 'Nguyen', 'quang.ng@gmail.com', '0900333444'),
('Ha Phuc', 'Le', 'phuc.le@gmail.com', '0900555666'),
('Minh Quan', 'Pham', 'quanpham@gmail.com', '0900777888');

--Bảng FoodItem
INSERT INTO FoodItem (FoodItemID, Name, Price)
VALUES
('F001', 'Sweet Popcorn', 4.00),
('F002', 'Cheese Popcorn', 4.50),
('F003', 'Caramel Popcorn', 5.00),
('F004', 'Fanta', 3.00),
('F005', 'Cocacola', 3.00),
('F006', 'Spire', 2.50);

--Bảng Revenue
INSERT INTO Revenue (CinemaID, RevenueDate, Source, Total)
VALUES
('CIN001', '2024-12-01', 'Ticket Sales', 5000.00),
('CIN002', '2024-12-01', 'Ticket Sales', 4500.00),
('CIN001', '2024-12-01', 'Food Sales', 1500.00),
('CIN002', '2024-12-01', 'Food Sales', 1200.00),
('CIN001', '2024-12-01', 'Other', 300.00),
('CIN002', '2024-12-01', 'Other', 200.00);

CREATE OR REPLACE FUNCTION validate_rooms(movie_id TEXT, screening_date DATE, start_time TIME)
RETURNS TABLE(roomid TEXT, capacity Integer) AS $$
BEGIN
    RETURN QUERY
    SELECT r.roomid, r.numberofseats
    FROM Room r
    WHERE r.roomid NOT IN (
        SELECT s.roomid
        FROM Screening s
        JOIN Movie m ON s.movieid = m.movieid
        WHERE (
              -- Use the duration from the Movies table
              (s.starttime, s.endtime) OVERLAPS
              ('' + start_time, screening_date + start_time + (SELECT duration FROM Movie WHERE movieid = movie_id) * INTERVAL '1 minute')
            )
    );  
END;
$$ LANGUAGE plpgsql;

--III. Kiểm tra dữ liệu
SELECT * FROM Employee;
SELECT * FROM Cinema;
SELECT * FROM Room;
SELECT * FROM Seats;
SELECT * FROM Movie;
SELECT * FROM Screening;
SELECT * FROM Ticket;
SELECT * FROM Customer;
SELECT * FROM FoodItem;
SELECT * FROM Revenue;

