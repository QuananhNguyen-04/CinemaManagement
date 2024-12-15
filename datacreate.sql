--PHẦN 1: TẠO CSDL
--I. Tạo bảng dữ liệu
--Tạo cơ sở dữ liệu
CREATE DATABASE CinemaManagement;
\c cinemamanagement;

--Tạo bảng Employee (Nhân viên)
CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
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
    SeatID VARCHAR(20) PRIMARY KEY,
    RoomID VARCHAR(10) NOT NULL,
    RowNumber INT NOT NULL CHECK (RowNumber > 0),
    SeatNumber INT NOT NULL CHECK (SeatNumber > 0),
    SeatStatus VARCHAR(20) NOT NULL DEFAULT 'Available',
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
    Age INT CHECK (Age >= 0),
    OnOffline BOOLEAN NOT NULL,
    SeatID VARCHAR(20),
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
INSERT INTO Employee (EmployeeID, FirstName, LastName, Email, Address, PhoneNumber, Position, StartDate, Salary, Specialization, EmploymentType, HourlyRate, LeaveDay)
VALUES
('EMP001', 'Nhat Minh', 'Duong', 'minh.duong@gmail.com', '12 Ta Quang Buu', '0900123456', 'Manager', '2020-01-01', 5000.00, NULL, NULL, NULL, NULL),
('EMP002', 'Gia Bao', 'Phan', 'giabao@gmail.com', '43 Nguyen Van Troi', '0912345678', 'Technical', '2021-02-01', 3500.00, 'Projector Maintenance', NULL, NULL, NULL),
('EMP003', 'Van Nam', 'Nguyen', 'namnguyen123@gmail.com', '94 Pham Van Dong', '0911223344', 'Ticket Seller', '2022-03-01', NULL, NULL, 'Full-Time', 15.00, 2),
('EMP004', 'Viet Hoang', 'Le', 'leviethoang@gmail.com', '316 Tan Ki Tan Quy', '0902334455', 'Food Seller', '2023-04-01', NULL, NULL, 'Seasonal', 12.00, 1),
('EMP005', 'Thanh Danh', 'Pham', 'danhthanhpham@gmail.com', '503 Hai Ba Trung', '0914253647', 'Cleaning Staff', '2022-05-01', NULL, NULL, 'Full-Time', 10.00, 3),
('EMP006', 'Quoc Huy', 'Tran', 'huytran@gmail.com', '27 Ly Thuong Kiet', '0915273648', 'Ticket Checker', '2021-06-01', NULL, NULL, 'Part-Time', 13.00, 1),
('EMP007', 'Minh Chau', 'Nguyen', 'chau.nguyen@gmail.com', '198 Hoang Hoa Tham', '0906347895', 'Technical', '2020-08-15', 3600.00, 'Sound System Maintenance', NULL, NULL, NULL),
('EMP008', 'Bao Han', 'Vo', 'baohan.vo@gmail.com', '301 Binh Tan', '0908472649', 'Food Seller', '2023-07-20', NULL, NULL, 'Seasonal', 11.50, 2),
('EMP009', 'Hai Yen', 'Pham', 'yenpham@gmail.com', '72 Cong Quynh', '0913457865', 'Cleaning Staff', '2022-09-10', NULL, NULL, 'Full-Time', 10.50, 4),
('EMP010', 'Ngoc Minh', 'Le', 'minhle.ngoc@gmail.com', '10 Mai Chi Tho', '0901123456', 'Manager', '2019-12-01', 5200.00, NULL, NULL, NULL, NULL),
('EMP011', 'Hoang Linh', 'Do', 'hoanglinh@gmail.com', '55 Dong Khoi', '0912643790', 'Ticket Seller', '2022-10-01', NULL, NULL, 'Part-Time', 14.00, 2),
('EMP012', 'Tien Phong', 'Vu', 'tienphong@gmail.com', '8 Le Van Sy', '0903892746', 'Technical', '2021-11-05', 3400.00, 'Screen Calibration', NULL, NULL, NULL),
('EMP013', 'Van Khanh', 'Nguyen', 'khanhvan@gmail.com', '11 Ngo Gia Tu', '0913475629', 'Ticket Checker', '2020-03-12', NULL, NULL, 'Full-Time', 13.50, 3),
('EMP014', 'Thi An', 'Vo', 'anthi.vo@gmail.com', '62 Bach Dang', '0907568392', 'Food Seller', '2023-01-15', NULL, NULL, 'Part-Time', 11.00, 1),
('EMP015', 'Nguyen Quoc', 'Pham', 'quoc.pham@gmail.com', '5 Tran Binh Trong', '0914823657', 'Cleaning Staff', '2022-12-05', NULL, NULL, 'Seasonal', 9.50, 2);

--Bảng Cinema
INSERT INTO Cinema (CinemaID, Name, Address, PhoneNumber, Revenue)
VALUES
('CIN01', 'BK Cinema', '1 Nguyen Hue St', '0555123456', 150000.50),
('CIN02', 'BK Cinema', '22 Hai Ba Trung St', '0555654321', 200000.00),
('CIN03', 'BK Cinema', '3 Dien Bien Phu St', '0555789123', 250000.75);

--Bảng Room
INSERT INTO Room (RoomID, CinemaID, NumberOfSeats, BrokenItems)
VALUES
('R01', 'CIN01', 120, 2),
('R02', 'CIN01', 100, 0),
('R03', 'CIN02', 150, 3),
('R04', 'CIN03', 200, 1);

--Bảng Movie
INSERT INTO Movie (MovieID, Name, Genre, Director, ReleaseDate, Duration, Trailer)
VALUES
('MOV001', 'Avatar', 'Sci-Fi', 'James Cameron', '2009-12-18', 162, 'avatar-trailer.com'),
('MOV002', 'Inception', 'Action', 'Christopher Nolan', '2010-07-16', 148, 'inception-trailer.com'),
('MOV003', 'Titanic', 'Drama', 'James Cameron', '1997-12-19', 195, 'titanic-trailer.com'),
('MOV004', 'Interstellar', 'Sci-Fi', 'Christopher Nolan', '2014-11-07', 169, 'interstellar-trailer.com'),
('MOV005', 'The Matrix', 'Sci-Fi', 'Wachowski Sisters', '1999-03-31', 136, 'matrix-trailer.com'),
('MOV006', 'Pulp Fiction', 'Crime', 'Quentin Tarantino', '1994-10-14', 154, 'pulpfiction-trailer.com'),
('MOV007', 'The Dark Knight', 'Action', 'Christopher Nolan', '2008-07-18', 152, 'darkknight-trailer.com');

--Bảng Seats
INSERT INTO Seats (SeatID, RoomID, RowNumber, SeatNumber, SeatStatus)
VALUES
--Phòng 1
--Hàng A
('CIN01_R01_A01', 'R01', 1, 1, 'Available'),
('CIN01_R01_A02', 'R01', 1, 2, 'Available'),
('CIN01_R01_A03', 'R01', 1, 3, 'Available'),
('CIN01_R01_A04', 'R01', 1, 4, 'Available'),
('CIN01_R01_A05', 'R01', 1, 5, 'Available'),
('CIN01_R01_A06', 'R01', 1, 6, 'Available'),
('CIN01_R01_A07', 'R01', 1, 7, 'Available'),
('CIN01_R01_A08', 'R01', 1, 8, 'Available'),
('CIN01_R01_A09', 'R01', 1, 9, 'Available'),
('CIN01_R01_A10', 'R01', 1, 10, 'Available'),
('CIN01_R01_A11', 'R01', 1, 11, 'Available'),
('CIN01_R01_A12', 'R01', 1, 12, 'Available'),
--Hàng B
('CIN01_R01_B01', 'R01', 2, 1, 'Available'),
('CIN01_R01_B02', 'R01', 2, 2, 'Available'),
('CIN01_R01_B03', 'R01', 2, 3, 'Available'),
('CIN01_R01_B04', 'R01', 2, 4, 'Available'),
('CIN01_R01_B05', 'R01', 2, 5, 'Available'),
('CIN01_R01_B06', 'R01', 2, 6, 'Available'),
('CIN01_R01_B07', 'R01', 2, 7, 'Available'),
('CIN01_R01_B08', 'R01', 2, 8, 'Available'),
('CIN01_R01_B09', 'R01', 2, 9, 'Available'),
('CIN01_R01_B10', 'R01', 2, 10, 'Available'),
('CIN01_R01_B11', 'R01', 2, 11, 'Available'),
('CIN01_R01_B12', 'R01', 2, 12, 'Available'),
--Hàng C
('CIN01_R01_C01', 'R01', 3, 1, 'Available'),
('CIN01_R01_C02', 'R01', 3, 2, 'Available'),
('CIN01_R01_C03', 'R01', 3, 3, 'Available'),
('CIN01_R01_C04', 'R01', 3, 4, 'Available'),
('CIN01_R01_C05', 'R01', 3, 5, 'Available'),
('CIN01_R01_C06', 'R01', 3, 6, 'Available'),
('CIN01_R01_C07', 'R01', 3, 7, 'Available'),
('CIN01_R01_C08', 'R01', 3, 8, 'Available'),
('CIN01_R01_C09', 'R01', 3, 9, 'Available'),
('CIN01_R01_C10', 'R01', 3, 10, 'Available'),
('CIN01_R01_C11', 'R01', 3, 11, 'Available'),
('CIN01_R01_C12', 'R01', 3, 12, 'Available'),
--Hàng D
('CIN01_R01_D01', 'R01', 4, 1, 'Available'),
('CIN01_R01_D02', 'R01', 4, 2, 'Available'),
('CIN01_R01_D03', 'R01', 4, 3, 'Available'),
('CIN01_R01_D04', 'R01', 4, 4, 'Available'),
('CIN01_R01_D05', 'R01', 4, 5, 'Available'),
('CIN01_R01_D06', 'R01', 4, 6, 'Available'),
('CIN01_R01_D07', 'R01', 4, 7, 'Available'),
('CIN01_R01_D08', 'R01', 4, 8, 'Available'),
('CIN01_R01_D09', 'R01', 4, 9, 'Available'),
('CIN01_R01_D10', 'R01', 4, 10, 'Available'),
('CIN01_R01_D11', 'R01', 4, 11, 'Available'),
('CIN01_R01_D12', 'R01', 4, 12, 'Available'),
-- Hàng E
('CIN01_R01_E01', 'R01', 5, 1, 'Available'),
('CIN01_R01_E02', 'R01', 5, 2, 'Available'),
('CIN01_R01_E03', 'R01', 5, 3, 'Available'),
('CIN01_R01_E04', 'R01', 5, 4, 'Available'),
('CIN01_R01_E05', 'R01', 5, 5, 'Available'),
('CIN01_R01_E06', 'R01', 5, 6, 'Available'),
('CIN01_R01_E07', 'R01', 5, 7, 'Available'),
('CIN01_R01_E08', 'R01', 5, 8, 'Available'),
('CIN01_R01_E09', 'R01', 5, 9, 'Available'),
('CIN01_R01_E10', 'R01', 5, 10, 'Available'),
('CIN01_R01_E11', 'R01', 5, 11, 'Available'),
('CIN01_R01_E12', 'R01', 5, 12, 'Available'),
-- Hàng F
('CIN01_R01_F01', 'R01', 6, 1, 'Available'),
('CIN01_R01_F02', 'R01', 6, 2, 'Available'),
('CIN01_R01_F03', 'R01', 6, 3, 'Available'),
('CIN01_R01_F04', 'R01', 6, 4, 'Available'),
('CIN01_R01_F05', 'R01', 6, 5, 'Available'),
('CIN01_R01_F06', 'R01', 6, 6, 'Available'),
('CIN01_R01_F07', 'R01', 6, 7, 'Available'),
('CIN01_R01_F08', 'R01', 6, 8, 'Available'),
('CIN01_R01_F09', 'R01', 6, 9, 'Available'),
('CIN01_R01_F10', 'R01', 6, 10, 'Available'),
('CIN01_R01_F11', 'R01', 6, 11, 'Available'),
('CIN01_R01_F12', 'R01', 6, 12, 'Available'),
-- Hàng G
('CIN01_R01_G01', 'R01', 7, 1, 'Available'),
('CIN01_R01_G02', 'R01', 7, 2, 'Available'),
('CIN01_R01_G03', 'R01', 7, 3, 'Available'),
('CIN01_R01_G04', 'R01', 7, 4, 'Available'),
('CIN01_R01_G05', 'R01', 7, 5, 'Available'),
('CIN01_R01_G06', 'R01', 7, 6, 'Available'),
('CIN01_R01_G07', 'R01', 7, 7, 'Available'),
('CIN01_R01_G08', 'R01', 7, 8, 'Available'),
('CIN01_R01_G09', 'R01', 7, 9, 'Available'),
('CIN01_R01_G10', 'R01', 7, 10, 'Available'),
('CIN01_R01_G11', 'R01', 7, 11, 'Available'),
('CIN01_R01_G12', 'R01', 7, 12, 'Available'),
-- Hàng H
('CIN01_R01_H01', 'R01', 8, 1, 'Available'),
('CIN01_R01_H02', 'R01', 8, 2, 'Available'),
('CIN01_R01_H03', 'R01', 8, 3, 'Available'),
('CIN01_R01_H04', 'R01', 8, 4, 'Available'),
('CIN01_R01_H05', 'R01', 8, 5, 'Available'),
('CIN01_R01_H06', 'R01', 8, 6, 'Available'),
('CIN01_R01_H07', 'R01', 8, 7, 'Available'),
('CIN01_R01_H08', 'R01', 8, 8, 'Available'),
('CIN01_R01_H09', 'R01', 8, 9, 'Available'),
('CIN01_R01_H10', 'R01', 8, 10, 'Available'),
('CIN01_R01_H11', 'R01', 8, 11, 'Available'),
('CIN01_R01_H12', 'R01', 8, 12, 'Available'),
--Phòng 2
--Hàng A
('CIN01_R02_A01', 'R02', 1, 1, 'Available'),
('CIN01_R02_A02', 'R02', 1, 2, 'Available'),
('CIN01_R02_A03', 'R02', 1, 3, 'Available'),
('CIN01_R02_A04', 'R02', 1, 4, 'Available'),
('CIN01_R02_A05', 'R02', 1, 5, 'Available'),
('CIN01_R02_A06', 'R02', 1, 6, 'Available'),
('CIN01_R02_A07', 'R02', 1, 7, 'Available'),
('CIN01_R02_A08', 'R02', 1, 8, 'Available'),
('CIN01_R02_A09', 'R02', 1, 9, 'Available'),
('CIN01_R02_A10', 'R02', 1, 10, 'Available'),
('CIN01_R02_A11', 'R02', 1, 11, 'Available'),
('CIN01_R02_A12', 'R02', 1, 12, 'Available'),
--Hàng B
('CIN01_R02_B01', 'R02', 2, 1, 'Available'),
('CIN01_R02_B02', 'R02', 2, 2, 'Available'),
('CIN01_R02_B03', 'R02', 2, 3, 'Available'),
('CIN01_R02_B04', 'R02', 2, 4, 'Available'),
('CIN01_R02_B05', 'R02', 2, 5, 'Available'),
('CIN01_R02_B06', 'R02', 2, 6, 'Available'),
('CIN01_R02_B07', 'R02', 2, 7, 'Available'),
('CIN01_R02_B08', 'R02', 2, 8, 'Available'),
('CIN01_R02_B09', 'R02', 2, 9, 'Available'),
('CIN01_R02_B10', 'R02', 2, 10, 'Available'),
('CIN01_R02_B11', 'R02', 2, 11, 'Available'),
('CIN01_R02_B12', 'R02', 2, 12, 'Available'),
--Hàng C
('CIN01_R02_C01', 'R02', 3, 1, 'Available'),
('CIN01_R02_C02', 'R02', 3, 2, 'Available'),
('CIN01_R02_C03', 'R02', 3, 3, 'Available'),
('CIN01_R02_C04', 'R02', 3, 4, 'Available'),
('CIN01_R02_C05', 'R02', 3, 5, 'Available'),
('CIN01_R02_C06', 'R02', 3, 6, 'Available'),
('CIN01_R02_C07', 'R02', 3, 7, 'Available'),
('CIN01_R02_C08', 'R02', 3, 8, 'Available'),
('CIN01_R02_C09', 'R02', 3, 9, 'Available'),
('CIN01_R02_C10', 'R02', 3, 10, 'Available'),
('CIN01_R02_C11', 'R02', 3, 11, 'Available'),
('CIN01_R02_C12', 'R02', 3, 12, 'Available'),
--Hàng D
('CIN01_R02_D01', 'R02', 4, 1, 'Available'),
('CIN01_R02_D02', 'R02', 4, 2, 'Available'),
('CIN01_R02_D03', 'R02', 4, 3, 'Available'),
('CIN01_R02_D04', 'R02', 4, 4, 'Available'),
('CIN01_R02_D05', 'R02', 4, 5, 'Available'),
('CIN01_R02_D06', 'R02', 4, 6, 'Available'),
('CIN01_R02_D07', 'R02', 4, 7, 'Available'),
('CIN01_R02_D08', 'R02', 4, 8, 'Available'),
('CIN01_R02_D09', 'R02', 4, 9, 'Available'),
('CIN01_R02_D10', 'R02', 4, 10, 'Available'),
('CIN01_R02_D11', 'R02', 4, 11, 'Available'),
('CIN01_R02_D12', 'R02', 4, 12, 'Available'),
-- Hàng E
('CIN01_R02_E01', 'R02', 5, 1, 'Available'),
('CIN01_R02_E02', 'R02', 5, 2, 'Available'),
('CIN01_R02_E03', 'R02', 5, 3, 'Available'),
('CIN01_R02_E04', 'R02', 5, 4, 'Available'),
('CIN01_R02_E05', 'R02', 5, 5, 'Available'),
('CIN01_R02_E06', 'R02', 5, 6, 'Available'),
('CIN01_R02_E07', 'R02', 5, 7, 'Available'),
('CIN01_R02_E08', 'R02', 5, 8, 'Available'),
('CIN01_R02_E09', 'R02', 5, 9, 'Available'),
('CIN01_R02_E10', 'R02', 5, 10, 'Available'),
('CIN01_R02_E11', 'R02', 5, 11, 'Available'),
('CIN01_R02_E12', 'R02', 5, 12, 'Available'),
-- Hàng F
('CIN01_R02_F01', 'R02', 6, 1, 'Available'),
('CIN01_R02_F02', 'R02', 6, 2, 'Available'),
('CIN01_R02_F03', 'R02', 6, 3, 'Available'),
('CIN01_R02_F04', 'R02', 6, 4, 'Available'),
('CIN01_R02_F05', 'R02', 6, 5, 'Available'),
('CIN01_R02_F06', 'R02', 6, 6, 'Available'),
('CIN01_R02_F07', 'R02', 6, 7, 'Available'),
('CIN01_R02_F08', 'R02', 6, 8, 'Available'),
('CIN01_R02_F09', 'R02', 6, 9, 'Available'),
('CIN01_R02_F10', 'R02', 6, 10, 'Available'),
('CIN01_R02_F11', 'R02', 6, 11, 'Available'),
('CIN01_R02_F12', 'R02', 6, 12, 'Available'),
-- Hàng G
('CIN01_R02_G01', 'R02', 7, 1, 'Available'),
('CIN01_R02_G02', 'R02', 7, 2, 'Available'),
('CIN01_R02_G03', 'R02', 7, 3, 'Available'),
('CIN01_R02_G04', 'R02', 7, 4, 'Available'),
('CIN01_R02_G05', 'R02', 7, 5, 'Available'),
('CIN01_R02_G06', 'R02', 7, 6, 'Available'),
('CIN01_R02_G07', 'R02', 7, 7, 'Available'),
('CIN01_R02_G08', 'R02', 7, 8, 'Available'),
('CIN01_R02_G09', 'R02', 7, 9, 'Available'),
('CIN01_R02_G10', 'R02', 7, 10, 'Available'),
('CIN01_R02_G11', 'R02', 7, 11, 'Available'),
('CIN01_R02_G12', 'R02', 7, 12, 'Available'),
-- Hàng H
('CIN01_R02_H01', 'R02', 8, 1, 'Available'),
('CIN01_R02_H02', 'R02', 8, 2, 'Available'),
('CIN01_R02_H03', 'R02', 8, 3, 'Available'),
('CIN01_R02_H04', 'R02', 8, 4, 'Available'),
('CIN01_R02_H05', 'R02', 8, 5, 'Available'),
('CIN01_R02_H06', 'R02', 8, 6, 'Available'),
('CIN01_R02_H07', 'R02', 8, 7, 'Available'),
('CIN01_R02_H08', 'R02', 8, 8, 'Available'),
('CIN01_R02_H09', 'R02', 8, 9, 'Available'),
('CIN01_R02_H10', 'R02', 8, 10, 'Available'),
('CIN01_R02_H11', 'R02', 8, 11, 'Available'),
('CIN01_R02_H12', 'R02', 8, 12, 'Available'),
--Phòng 3
--Hàng A
('CIN01_R03_A01', 'R03', 1, 1, 'Available'),
('CIN01_R03_A02', 'R03', 1, 2, 'Available'),
('CIN01_R03_A03', 'R03', 1, 3, 'Available'),
('CIN01_R03_A04', 'R03', 1, 4, 'Available'),
('CIN01_R03_A05', 'R03', 1, 5, 'Available'),
('CIN01_R03_A06', 'R03', 1, 6, 'Available'),
('CIN01_R03_A07', 'R03', 1, 7, 'Available'),
('CIN01_R03_A08', 'R03', 1, 8, 'Available'),
('CIN01_R03_A09', 'R03', 1, 9, 'Available'),
('CIN01_R03_A10', 'R03', 1, 10, 'Available'),
('CIN01_R03_A11', 'R03', 1, 11, 'Available'),
('CIN01_R03_A12', 'R03', 1, 12, 'Available'),
--Hàng B
('CIN01_R03_B01', 'R03', 2, 1, 'Available'),
('CIN01_R03_B02', 'R03', 2, 2, 'Available'),
('CIN01_R03_B03', 'R03', 2, 3, 'Available'),
('CIN01_R03_B04', 'R03', 2, 4, 'Available'),
('CIN01_R03_B05', 'R03', 2, 5, 'Available'),
('CIN01_R03_B06', 'R03', 2, 6, 'Available'),
('CIN01_R03_B07', 'R03', 2, 7, 'Available'),
('CIN01_R03_B08', 'R03', 2, 8, 'Available'),
('CIN01_R03_B09', 'R03', 2, 9, 'Available'),
('CIN01_R03_B10', 'R03', 2, 10, 'Available'),
('CIN01_R03_B11', 'R03', 2, 11, 'Available'),
('CIN01_R03_B12', 'R03', 2, 12, 'Available'),
--Hàng C
('CIN01_R03_C01', 'R03', 3, 1, 'Available'),
('CIN01_R03_C02', 'R03', 3, 2, 'Available'),
('CIN01_R03_C03', 'R03', 3, 3, 'Available'),
('CIN01_R03_C04', 'R03', 3, 4, 'Available'),
('CIN01_R03_C05', 'R03', 3, 5, 'Available'),
('CIN01_R03_C06', 'R03', 3, 6, 'Available'),
('CIN01_R03_C07', 'R03', 3, 7, 'Available'),
('CIN01_R03_C08', 'R03', 3, 8, 'Available'),
('CIN01_R03_C09', 'R03', 3, 9, 'Available'),
('CIN01_R03_C10', 'R03', 3, 10, 'Available'),
('CIN01_R03_C11', 'R03', 3, 11, 'Available'),
('CIN01_R03_C12', 'R03', 3, 12, 'Available'),
--Hàng D
('CIN01_R03_D01', 'R03', 4, 1, 'Available'),
('CIN01_R03_D02', 'R03', 4, 2, 'Available'),
('CIN01_R03_D03', 'R03', 4, 3, 'Available'),
('CIN01_R03_D04', 'R03', 4, 4, 'Available'),
('CIN01_R03_D05', 'R03', 4, 5, 'Available'),
('CIN01_R03_D06', 'R03', 4, 6, 'Available'),
('CIN01_R03_D07', 'R03', 4, 7, 'Available'),
('CIN01_R03_D08', 'R03', 4, 8, 'Available'),
('CIN01_R03_D09', 'R03', 4, 9, 'Available'),
('CIN01_R03_D10', 'R03', 4, 10, 'Available'),
('CIN01_R03_D11', 'R03', 4, 11, 'Available'),
('CIN01_R03_D12', 'R03', 4, 12, 'Available'),
-- Hàng E
('CIN01_R03_E01', 'R03', 5, 1, 'Available'),
('CIN01_R03_E02', 'R03', 5, 2, 'Available'),
('CIN01_R03_E03', 'R03', 5, 3, 'Available'),
('CIN01_R03_E04', 'R03', 5, 4, 'Available'),
('CIN01_R03_E05', 'R03', 5, 5, 'Available'),
('CIN01_R03_E06', 'R03', 5, 6, 'Available'),
('CIN01_R03_E07', 'R03', 5, 7, 'Available'),
('CIN01_R03_E08', 'R03', 5, 8, 'Available'),
('CIN01_R03_E09', 'R03', 5, 9, 'Available'),
('CIN01_R03_E10', 'R03', 5, 10, 'Available'),
('CIN01_R03_E11', 'R03', 5, 11, 'Available'),
('CIN01_R03_E12', 'R03', 5, 12, 'Available'),
-- Hàng F
('CIN01_R03_F01', 'R03', 6, 1, 'Available'),
('CIN01_R03_F02', 'R03', 6, 2, 'Available'),
('CIN01_R03_F03', 'R03', 6, 3, 'Available'),
('CIN01_R03_F04', 'R03', 6, 4, 'Available'),
('CIN01_R03_F05', 'R03', 6, 5, 'Available'),
('CIN01_R03_F06', 'R03', 6, 6, 'Available'),
('CIN01_R03_F07', 'R03', 6, 7, 'Available'),
('CIN01_R03_F08', 'R03', 6, 8, 'Available'),
('CIN01_R03_F09', 'R03', 6, 9, 'Available'),
('CIN01_R03_F10', 'R03', 6, 10, 'Available'),
('CIN01_R03_F11', 'R03', 6, 11, 'Available'),
('CIN01_R03_F12', 'R03', 6, 12, 'Available'),
-- Hàng G
('CIN01_R03_G01', 'R03', 7, 1, 'Available'),
('CIN01_R03_G02', 'R03', 7, 2, 'Available'),
('CIN01_R03_G03', 'R03', 7, 3, 'Available'),
('CIN01_R03_G04', 'R03', 7, 4, 'Available'),
('CIN01_R03_G05', 'R03', 7, 5, 'Available'),
('CIN01_R03_G06', 'R03', 7, 6, 'Available'),
('CIN01_R03_G07', 'R03', 7, 7, 'Available'),
('CIN01_R03_G08', 'R03', 7, 8, 'Available'),
('CIN01_R03_G09', 'R03', 7, 9, 'Available'),
('CIN01_R03_G10', 'R03', 7, 10, 'Available'),
('CIN01_R03_G11', 'R03', 7, 11, 'Available'),
('CIN01_R03_G12', 'R03', 7, 12, 'Available'),
-- Hàng H
('CIN01_R03_H01', 'R03', 8, 1, 'Available'),
('CIN01_R03_H02', 'R03', 8, 2, 'Available'),
('CIN01_R03_H03', 'R03', 8, 3, 'Available'),
('CIN01_R03_H04', 'R03', 8, 4, 'Available'),
('CIN01_R03_H05', 'R03', 8, 5, 'Available'),
('CIN01_R03_H06', 'R03', 8, 6, 'Available'),
('CIN01_R03_H07', 'R03', 8, 7, 'Available'),
('CIN01_R03_H08', 'R03', 8, 8, 'Available'),
('CIN01_R03_H09', 'R03', 8, 9, 'Available'),
('CIN01_R03_H10', 'R03', 8, 10, 'Available'),
('CIN01_R03_H11', 'R03', 8, 11, 'Available'),
('CIN01_R03_H12', 'R03', 8, 12, 'Available'),
--Phòng 4
--Hàng A
('CIN01_R04_A01', 'R04', 1, 1, 'Available'),
('CIN01_R04_A02', 'R04', 1, 2, 'Available'),
('CIN01_R04_A03', 'R04', 1, 3, 'Available'),
('CIN01_R04_A04', 'R04', 1, 4, 'Available'),
('CIN01_R04_A05', 'R04', 1, 5, 'Available'),
('CIN01_R04_A06', 'R04', 1, 6, 'Available'),
('CIN01_R04_A07', 'R04', 1, 7, 'Available'),
('CIN01_R04_A08', 'R04', 1, 8, 'Available'),
('CIN01_R04_A09', 'R04', 1, 9, 'Available'),
('CIN01_R04_A10', 'R04', 1, 10, 'Available'),
('CIN01_R04_A11', 'R04', 1, 11, 'Available'),
('CIN01_R04_A12', 'R04', 1, 12, 'Available'),
--Hàng B
('CIN01_R04_B01', 'R04', 2, 1, 'Available'),
('CIN01_R04_B02', 'R04', 2, 2, 'Available'),
('CIN01_R04_B03', 'R04', 2, 3, 'Available'),
('CIN01_R04_B04', 'R04', 2, 4, 'Available'),
('CIN01_R04_B05', 'R04', 2, 5, 'Available'),
('CIN01_R04_B06', 'R04', 2, 6, 'Available'),
('CIN01_R04_B07', 'R04', 2, 7, 'Available'),
('CIN01_R04_B08', 'R04', 2, 8, 'Available'),
('CIN01_R04_B09', 'R04', 2, 9, 'Available'),
('CIN01_R04_B10', 'R04', 2, 10, 'Available'),
('CIN01_R04_B11', 'R04', 2, 11, 'Available'),
('CIN01_R04_B12', 'R04', 2, 12, 'Available'),
--Hàng C
('CIN01_R04_C01', 'R04', 3, 1, 'Available'),
('CIN01_R04_C02', 'R04', 3, 2, 'Available'),
('CIN01_R04_C03', 'R04', 3, 3, 'Available'),
('CIN01_R04_C04', 'R04', 3, 4, 'Available'),
('CIN01_R04_C05', 'R04', 3, 5, 'Available'),
('CIN01_R04_C06', 'R04', 3, 6, 'Available'),
('CIN01_R04_C07', 'R04', 3, 7, 'Available'),
('CIN01_R04_C08', 'R04', 3, 8, 'Available'),
('CIN01_R04_C09', 'R04', 3, 9, 'Available'),
('CIN01_R04_C10', 'R04', 3, 10, 'Available'),
('CIN01_R04_C11', 'R04', 3, 11, 'Available'),
('CIN01_R04_C12', 'R04', 3, 12, 'Available'),
--Hàng D
('CIN01_R04_D01', 'R04', 4, 1, 'Available'),
('CIN01_R04_D02', 'R04', 4, 2, 'Available'),
('CIN01_R04_D03', 'R04', 4, 3, 'Available'),
('CIN01_R04_D04', 'R04', 4, 4, 'Available'),
('CIN01_R04_D05', 'R04', 4, 5, 'Available'),
('CIN01_R04_D06', 'R04', 4, 6, 'Available'),
('CIN01_R04_D07', 'R04', 4, 7, 'Available'),
('CIN01_R04_D08', 'R04', 4, 8, 'Available'),
('CIN01_R04_D09', 'R04', 4, 9, 'Available'),
('CIN01_R04_D10', 'R04', 4, 10, 'Available'),
('CIN01_R04_D11', 'R04', 4, 11, 'Available'),
('CIN01_R04_D12', 'R04', 4, 12, 'Available'),
-- Hàng E
('CIN01_R04_E01', 'R04', 5, 1, 'Available'),
('CIN01_R04_E02', 'R04', 5, 2, 'Available'),
('CIN01_R04_E03', 'R04', 5, 3, 'Available'),
('CIN01_R04_E04', 'R04', 5, 4, 'Available'),
('CIN01_R04_E05', 'R04', 5, 5, 'Available'),
('CIN01_R04_E06', 'R04', 5, 6, 'Available'),
('CIN01_R04_E07', 'R04', 5, 7, 'Available'),
('CIN01_R04_E08', 'R04', 5, 8, 'Available'),
('CIN01_R04_E09', 'R04', 5, 9, 'Available'),
('CIN01_R04_E10', 'R04', 5, 10, 'Available'),
('CIN01_R04_E11', 'R04', 5, 11, 'Available'),
('CIN01_R04_E12', 'R04', 5, 12, 'Available'),
-- Hàng F
('CIN01_R04_F01', 'R04', 6, 1, 'Available'),
('CIN01_R04_F02', 'R04', 6, 2, 'Available'),
('CIN01_R04_F03', 'R04', 6, 3, 'Available'),
('CIN01_R04_F04', 'R04', 6, 4, 'Available'),
('CIN01_R04_F05', 'R04', 6, 5, 'Available'),
('CIN01_R04_F06', 'R04', 6, 6, 'Available'),
('CIN01_R04_F07', 'R04', 6, 7, 'Available'),
('CIN01_R04_F08', 'R04', 6, 8, 'Available'),
('CIN01_R04_F09', 'R04', 6, 9, 'Available'),
('CIN01_R04_F10', 'R04', 6, 10, 'Available'),
('CIN01_R04_F11', 'R04', 6, 11, 'Available'),
('CIN01_R04_F12', 'R04', 6, 12, 'Available'),
-- Hàng G
('CIN01_R04_G01', 'R04', 7, 1, 'Available'),
('CIN01_R04_G02', 'R04', 7, 2, 'Available'),
('CIN01_R04_G03', 'R04', 7, 3, 'Available'),
('CIN01_R04_G04', 'R04', 7, 4, 'Available'),
('CIN01_R04_G05', 'R04', 7, 5, 'Available'),
('CIN01_R04_G06', 'R04', 7, 6, 'Available'),
('CIN01_R04_G07', 'R04', 7, 7, 'Available'),
('CIN01_R04_G08', 'R04', 7, 8, 'Available'),
('CIN01_R04_G09', 'R04', 7, 9, 'Available'),
('CIN01_R04_G10', 'R04', 7, 10, 'Available'),
('CIN01_R04_G11', 'R04', 7, 11, 'Available'),
('CIN01_R04_G12', 'R04', 7, 12, 'Available'),
-- Hàng H
('CIN01_R04_H01', 'R04', 8, 1, 'Available'),
('CIN01_R04_H02', 'R04', 8, 2, 'Available'),
('CIN01_R04_H03', 'R04', 8, 3, 'Available'),
('CIN01_R04_H04', 'R04', 8, 4, 'Available'),
('CIN01_R04_H05', 'R04', 8, 5, 'Available'),
('CIN01_R04_H06', 'R04', 8, 6, 'Available'),
('CIN01_R04_H07', 'R04', 8, 7, 'Available'),
('CIN01_R04_H08', 'R04', 8, 8, 'Available'),
('CIN01_R04_H09', 'R04', 8, 9, 'Available'),
('CIN01_R04_H10', 'R04', 8, 10, 'Available'),
('CIN01_R04_H11', 'R04', 8, 11, 'Available'),
('CIN01_R04_H12', 'R04', 8, 12, 'Available');

--Bảng Screening
INSERT INTO Screening (ScreeningID, RoomID, MovieID, StartTime, EndTime, Quantity)
VALUES
('SCR01', 'R01', 'MOV001', '2024-12-10 14:00:00', '2024-12-10 16:42:00', 90),
('SCR02', 'R02', 'MOV002', '2024-12-11 18:00:00', '2024-12-11 20:28:00', 80),
('SCR03', 'R03', 'MOV003', '2024-12-12 15:00:00', '2024-12-12 18:15:00', 85),
('SCR04', 'R04', 'MOV004', '2024-12-13 19:00:00', '2024-12-13 21:49:00', 96);

--Bảng Ticket
INSERT INTO Ticket (ScreeningID, Price, Age, OnOffline, SeatID)
VALUES
('SCR01', 5.00, 12, TRUE, 'CIN01_R01_A01'),
('SCR01', 5.00, 0, FALSE, 'CIN01_R01_B02'),
('SCR02', 5.00, 16, TRUE, 'CIN01_R01_B01'),
('SCR02', 5.00, 18, FALSE, 'CIN01_R01_C01'),
('SCR03', 5.00, 16, TRUE, 'CIN01_R01_A01'),
('SCR03', 4.50, 18, FALSE, 'CIN01_R01_B02'),
('SCR04', 6.00, 0, TRUE, 'CIN01_R01_B01'),
('SCR04', 6.00, 12, FALSE, 'CIN01_R01_C01');

--Bảng Customer
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber)
VALUES
('Quan Hai', 'Ho', 'hohai@gmail.com', '0900111222'),
('Dang Quang', 'Nguyen', 'quang.ng@gmail.com', '0900333444'),
('Ha Phuc', 'Le', 'phuc.le@gmail.com', '0900555666'),
('Minh Quan', 'Pham', 'quanpham@gmail.com', '0900777888'),
('Anh Tuan', 'Tran', 'anhtuan.tran@gmail.com', '0900999000'),
('Hoang Nam', 'Vu', 'hoangnam.vu@gmail.com', '0900222333'),
('Thuy Linh', 'Do', 'thuylinh.do@gmail.com', '0900444555'),
('Khanh Hoa', 'Ngo', 'khanhhoa.ngo@gmail.com', '0900666777'),
('Bao Chau', 'Nguyen', 'nguyen.baochau@gmail.com', '0900888999'),
('Ngoc Han', 'Le', 'ngochan.le@gmail.com', '0900111001'),
('Duc Thinh', 'Pham', 'thinh.ducpham@gmail.com', '0900333003'),
('Hoai Thu', 'Tran', 'hoaithu.tran@gmail.com', '0900555005'),
('Thi Mai', 'Nguyen', 'nguyen.thimai@gmail.com', '0900123123'),
('Duc Anh', 'Tran', 'ducanh.tran@gmail.com', '0900234234'),
('Minh Chau', 'Vo', 'minhchau.vo@gmail.com', '0900345345'),
('Hoai Bao', 'Le', 'hoaibao.le@gmail.com', '0900456456'),
('Thu Huong', 'Pham', 'thu.huong@gmail.com', '0900567567'),
('Quang Huy', 'Ngo', 'quanghuy.ngo@gmail.com', '0900678678'),
('Ngoc Anh', 'Dang', 'ngocanh.dang@gmail.com', '0900789789'),
('Bich Phuong', 'Nguyen', 'bichphuong.nguyen@gmail.com', '0900890890'),
('Hai Dang', 'Do', 'haidang.do@gmail.com', '0900101010'),
('Thien An', 'Pham', 'thienan.pham@gmail.com', '0900202020'),
('Yen Nhi', 'Vo', 'yennhi.vo@gmail.com', '0900303030'),
('Gia Bao', 'Tran', 'giabao.tran@gmail.com', '0900404040'),
('Quoc Khanh', 'Ngo', 'quockhanh.ngo@gmail.com', '0900505050'),
('Phuong Thao', 'Le', 'phuongthao.le@gmail.com', '0900606060');

--Bảng FoodItem
INSERT INTO FoodItem (FoodItemID, Name, Price)
VALUES
('F001', 'Sweet Popcorn 60oz', 2.00),
('F002', 'Cheese Popcorn 60oz', 2.50),
('F003', 'Caramel Popcorn 60oz', 3.00),
('F004', 'Poca Wavy 54g', 2.00),
('F005', 'Lays Stax 100g', 3.00),
('F006', 'Water 32oz', 1.50),
('F007', 'Fanta 32oz', 2.00),
('F008', 'Coke 32oz', 2.25),
('F009', 'Spire 32oz', 2.50),
('F010', 'Combo Solo: 1 Sweet Popcorn 60oz + 1 Coke 32oz', 3.75),
('F011', 'Combo Couple: 1 Sweet Popcorn 60oz + 2 Coke 32oz', 5.50),
('F012', 'Combo Party: 2 Sweet Popcorn 60oz + 4 Coke 32oz', 11.00);

--Bảng Revenue
INSERT INTO Revenue (CinemaID, RevenueDate, Source, Total)
VALUES
('CIN01', '2024-12-01', 'Ticket Sales', 5123.00),
('CIN02', '2024-12-01', 'Ticket Sales', 4510.00),
('CIN01', '2024-12-01', 'Food Sales', 1531.00),
('CIN02', '2024-12-01', 'Food Sales', 1210.50),
('CIN01', '2024-12-02', 'Ticket Sales', 6125.00),
('CIN02', '2024-12-02', 'Ticket Sales', 4250.00),
('CIN01', '2024-12-02', 'Food Sales', 2050.75),
('CIN02', '2024-12-02', 'Food Sales', 1175.25),
('CIN01', '2024-12-03', 'Ticket Sales', 4550.00),
('CIN02', '2024-12-03', 'Ticket Sales', 2170.00),
('CIN01', '2024-12-03', 'Food Sales', 1230.50),
('CIN02', '2024-12-03', 'Food Sales', 575.25);

--III. Kiểm tra dữ liệu
--SELECT * FROM Employee;
--SELECT * FROM Cinema;
--SELECT * FROM Room;
--SELECT * FROM Seats;
--SELECT * FROM Movie;
--SELECT * FROM Screening;
--SELECT * FROM Ticket;
--SELECT * FROM Customer;
--SELECT * FROM FoodItem;
--SELECT * FROM Revenue;

--1. Xem danh sách ghế
CREATE OR REPLACE FUNCTION view_seats_in_room(room_id_input VARCHAR)
RETURNS TABLE(
    seat_id VARCHAR,
    row_number INT,
    seat_number INT,
    status VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        SeatID AS seat_id,
        RowNumber AS row_number,
        SeatNumber AS seat_number,
        SeatStatus AS status
    FROM Seats
    WHERE RoomID = room_id_input
    ORDER BY RowNumber, SeatNumber;
END;
$$ LANGUAGE plpgsql;

--2. Thêm ghế vào phòng
CREATE OR REPLACE FUNCTION add_seat_to_room(
    cinema_id_input VARCHAR,
    room_id_input VARCHAR,
    seat_row_input INT,
    seat_number_input INT
) RETURNS VOID AS $$
DECLARE
    seat_id VARCHAR;
    row_letter CHAR;
BEGIN
    -- Kiểm tra phòng có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM Room WHERE RoomID = room_id_input) THEN
        RAISE EXCEPTION 'Room with ID % does not exist.', room_id_input;
    END IF;

    -- Chuyển đổi RowNumber sang chữ cái (A, B, C, ...)
    row_letter := CHR(64 + seat_row_input); -- CHR(65) là 'A'

    -- Tạo ID cho ghế mới
    seat_id := CONCAT(cinema_id_input, '_', room_id_input, '_', row_letter, LPAD(seat_number_input::TEXT, 2, '0'));

    -- Kiểm tra ghế có tồn tại hay không
    IF EXISTS (SELECT 1 FROM Seats WHERE SeatID = seat_id) THEN
        RAISE EXCEPTION 'Seat with ID % already exists.', seat_id;
    END IF;

    -- Thêm ghế mới vào bảng Seats
    INSERT INTO Seats (SeatID, RoomID, RowNumber, SeatNumber, SeatStatus)
    VALUES (
        seat_id, 
        room_id_input, 
        seat_row_input, 
        seat_number_input, 
        'Available'
    );
END;
$$ LANGUAGE plpgsql;

--3. Xóa ghế khỏi phòng
CREATE OR REPLACE FUNCTION delete_seat(
    cinema_id_input VARCHAR,
    room_id_input VARCHAR,
    seat_row_input INT,
    seat_number_input INT
)
RETURNS VOID AS $$
DECLARE
    seat_id_input VARCHAR;
    row_letter CHAR;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Room WHERE RoomID = room_id_input) THEN
        RAISE EXCEPTION 'Room with ID % does not exist.', room_id_input;
    END IF;

    -- Chuyển đổi RowNumber sang chữ cái (A, B, C, ...)
    row_letter := CHR(64 + seat_row_input); -- CHR(65) is 'A'

    -- Tạo ID cho ghế mới
    seat_id_input := CONCAT(cinema_id_input, '_', room_id_input, '_', row_letter, LPAD(seat_number_input::TEXT, 2, '0'));

    -- Kiểm tra ghế có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM Seats WHERE SeatID = seat_id_input) THEN
        RAISE EXCEPTION 'Seat with ID % does not exist.', seat_id_input;
    END IF;

    -- Kiểm tra ghế có đang được đặt không
    IF EXISTS (SELECT 1 FROM Ticket WHERE SeatID = seat_id_input) THEN
        RAISE EXCEPTION 'Cannot delete seat with ID % as it is currently booked.', seat_id_input;
    END IF;

    -- Xóa ghế
    DELETE FROM Seats WHERE SeatID = seat_id_input;
END;
$$ LANGUAGE plpgsql;

--4. Tổng doanh thu từ đồ ăn
CREATE OR REPLACE FUNCTION get_food_revenue(cinema_id_input VARCHAR, revenue_date_input DATE)
RETURNS NUMERIC 
AS $$ 
DECLARE 
    total_revenue NUMERIC; 
BEGIN 
    SELECT COALESCE(SUM(r.Total), 0) 
    INTO total_revenue 
    FROM Revenue r
    WHERE r.CinemaID = cinema_id_input AND r.RevenueDate = revenue_date_input AND r.Source = 'Food Sales'; 

    RETURN total_revenue; 
END; 
$$ LANGUAGE plpgsql;

--5. Tổng doanh thu từ vé
CREATE OR REPLACE FUNCTION get_ticket_revenue(cinema_id_input VARCHAR, revenue_date_input DATE)
RETURNS NUMERIC 
AS $$ 
DECLARE 
    total_revenue NUMERIC; 
BEGIN 
    SELECT COALESCE(SUM(r.Total), 0) 
    INTO total_revenue 
    FROM Revenue r
    WHERE r.CinemaID = cinema_id_input AND r.RevenueDate = revenue_date_input AND r.Source = 'Ticket Sales'; 

    RETURN total_revenue; 
END; 
$$ LANGUAGE plpgsql;

--6. Tổng doanh thu từ tất cả nguồn
-- Tổng doanh thu từ vé và đồ ăn (với hàm mới)
CREATE OR REPLACE FUNCTION get_total_revenue(cinema_id_input VARCHAR, revenue_date_input DATE)
RETURNS NUMERIC 
AS $$ 
DECLARE 
    total_revenue NUMERIC; 
BEGIN 
    SELECT COALESCE(SUM(r.Total), 0) 
    INTO total_revenue 
    FROM Revenue r
    WHERE r.CinemaID = cinema_id_input AND r.RevenueDate = revenue_date_input; 

    RETURN total_revenue; 
END; 
$$ LANGUAGE plpgsql;

--1. Từ chối đặt vé khi buổi chiếu đã kết thúc
CREATE OR REPLACE FUNCTION check_screening_end_time()
RETURNS TRIGGER AS $$
DECLARE
    screening_end_time TIMESTAMP;
BEGIN
    -- Lấy thời gian kết thúc của buổi chiếu
    SELECT EndTime
    INTO screening_end_time
    FROM Screening
    WHERE ScreeningID = NEW.ScreeningID;

    -- Kiểm tra nếu thời gian hiện tại đã vượt qua thời gian kết thúc
    IF CURRENT_TIMESTAMP > screening_end_time THEN
        RAISE EXCEPTION 'Cannot book a ticket after the screening has ended.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_screening_end_time
BEFORE INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION check_screening_end_time();

--2. Kiểm tra hai buổi chiếu không trùng thời gian trong cùng một phòng
CREATE OR REPLACE FUNCTION check_overlapping_screenings()
RETURNS TRIGGER AS $$
DECLARE
    overlapping_screenings INT;
BEGIN
    -- Kiểm tra sự trùng lặp giữa thời gian của buổi chiếu mới và các buổi chiếu hiện có trong cùng một phòng
    SELECT COUNT(*)
    INTO overlapping_screenings
    FROM Screening
    WHERE RoomID = NEW.RoomID
      AND NEW.StartTime < EndTime
      AND NEW.EndTime > StartTime
      AND ScreeningID != NEW.ScreeningID; -- Loại bỏ trường hợp buổi chiếu hiện tại (khi cập nhật)

    -- Nếu có buổi chiếu bị trùng lặp, từ chối thay đổi
    IF overlapping_screenings > 0 THEN
        RAISE EXCEPTION 'Overlapping screenings in the same room are not allowed.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_overlapping_screenings
BEFORE INSERT OR UPDATE ON Screening
FOR EACH ROW
EXECUTE FUNCTION check_overlapping_screenings();

--3. Cập nhật thông tin vé khi khách hàng đặt vé
CREATE OR REPLACE FUNCTION update_ticket_details()
RETURNS TRIGGER AS $$
BEGIN
    -- Ensure all required information is present
    IF NEW.ScreeningID IS NULL THEN
        RAISE EXCEPTION 'ScreeningID cannot be null';
    END IF;
    IF NEW.Price IS NULL THEN
        RAISE EXCEPTION 'Price cannot be null';
    END IF;
    IF NEW.Age IS NULL THEN
        RAISE EXCEPTION 'Age cannot be null';
    END IF;
    IF NEW.OnOffline IS NULL THEN
        RAISE EXCEPTION 'OnOffline cannot be null';
    END IF;
    IF NEW.SeatID IS NULL THEN
        RAISE EXCEPTION 'SeatID cannot be null';
    END IF;

    RETURN NEW; -- Return the new record with all details
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_ticket_details
BEFORE INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION update_ticket_details();

--4. Đảm bảo cập nhật trạng thái ghế sau khi đặt vé
CREATE OR REPLACE FUNCTION update_seat_status_after_booking()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Seats
    SET SeatStatus = 'Reserved'
    WHERE SeatID = NEW.SeatID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_seat_status_after_booking
AFTER INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION update_seat_status_after_booking();

--5. Đảm bảo ghế không bị đặt trùng trong cùng một buổi chiếu
CREATE OR REPLACE FUNCTION check_duplicate_seat_booking()
RETURNS TRIGGER AS $$
DECLARE
    duplicate_bookings INT;
BEGIN
    -- Kiểm tra nếu ghế đã được đặt trong cùng một buổi chiếu
    SELECT COUNT(*)
    INTO duplicate_bookings
    FROM Ticket
    WHERE ScreeningID = NEW.ScreeningID
      AND SeatID = NEW.SeatID;

    -- Nếu có ghế bị đặt trùng, từ chối thay đổi
    IF duplicate_bookings > 0 THEN
        RAISE EXCEPTION 'This seat has already been reserved for the selected screening.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_duplicate_seat_booking
BEFORE INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION check_duplicate_seat_booking();


CREATE OR REPLACE FUNCTION validate_rooms(
    movie_id TEXT,
    screening_date DATE,
    start_time TIME
)
RETURNS TABLE(roomid VARCHAR(10), CinemaID VARCHAR(10), capacity INT) AS $$
BEGIN
    RETURN QUERY
    SELECT r.roomid, r.cinemaid, r.numberofseats
    FROM Room r
    WHERE r.roomid NOT IN (
        SELECT s.roomid
        FROM Screening s
        JOIN Movie m ON s.movieid = m.movieid
        WHERE (
            tsrange(
                s.starttime, 
                s.starttime + (m.duration * INTERVAL '1 minute')
            ) &&
            tsrange(
                screening_date + start_time,
                screening_date + start_time + (SELECT duration * INTERVAL '1 minute' FROM Movie WHERE movieid = movie_id LIMIT 1)
            )
        )
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_new_screening(
    p_roomid TEXT,
    p_movieid TEXT,
    p_starttime TIME,  -- starttime is of type TIME
    p_screening_date DATE  -- separate date for screening date
) RETURNS VOID AS $$
DECLARE
    movie_duration INT;  -- in minutes
    screening_count INT;
    calculated_endtime TIMESTAMP;
    starttime TIMESTAMP;
    scr_id TEXT;
    quantity INT;
BEGIN
    -- Retrieve movie duration (in minutes) from the movie table

    SELECT COUNT(*) INTO screening_count
    FROM screening;

    SELECT duration INTO movie_duration
    FROM movie
    WHERE movieid = p_movieid;

    SELECT numberofseats INTO quantity
    FROM room
    WHERE roomid = p_roomid;

    -- Calculate the endtime by adding the duration to the starttime
    -- To add the duration (in minutes) to the TIME value, we need to convert the starttime to INTERVAL first
    scr_id := 'SCR' || LPAD((screening_count + 1)::TEXT, 2, '0'); 
    starttime := (p_screening_date || ' ' || p_starttime)::timestamp;
    calculated_endtime := (starttime + INTERVAL '1 minute' * movie_duration);

    -- Insert into the screening table
    INSERT INTO screening (screeningid, roomid, movieid, starttime, endtime, quantity)
    VALUES (scr_id, p_roomid, p_movieid, starttime, calculated_endtime, quantity);

END;
$$ LANGUAGE plpgsql;