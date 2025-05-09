
-- Tạo database
CREATE DATABASE QLTrungTamTinHoc;
GO

USE QLTrungTamTinHoc;

-- Bảng Lớp học
CREATE TABLE LOP (
    MALOP VARCHAR(20) PRIMARY KEY,
    TENLOP NVARCHAR(100),
    THOIKHOABIEU NVARCHAR(100),
    NGAYKHAIGIANG DATE,
    HOCPHI DECIMAL(10, 2),
    LOAILOP NVARCHAR(20) -- "ngắn hạn" hoặc "dài hạn"
);

-- Bảng Học viên
CREATE TABLE HOCVIEN (
    MAHV VARCHAR(20) PRIMARY KEY,
    HOTEN NVARCHAR(100),
    NGAYSINH DATE,
    NOISINH NVARCHAR(100),
    PHAI NVARCHAR(10),
    NGHENGHIEP NVARCHAR(100),
    MALOP VARCHAR(20), -- Mỗi học viên thuộc 1 lớp
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

-- Bảng Học phần (chỉ dành cho lớp dài hạn)
CREATE TABLE HOCPHAN (
    MAHP VARCHAR(20) PRIMARY KEY,
    TENHOCPHAN NVARCHAR(100),
    MALOP VARCHAR(20),
    NGAYBATDAU DATE,
    HOCPHI DECIMAL(10, 2),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

-- Bảng Môn học
CREATE TABLE MONHOC (
    MAMH VARCHAR(20) PRIMARY KEY,
    TENMONHOC NVARCHAR(100),
    SOTIETLYTHUYET INT,
    SOTIETTHUCHANH INT
);

-- Môn học trong học phần (chỉ cho lớp dài hạn)
CREATE TABLE HOCPHAN_MONHOC (
    MAHP VARCHAR(20),
    MAMH VARCHAR(20),
    PRIMARY KEY (MAHP, MAMH),
    FOREIGN KEY (MAHP) REFERENCES HOCPHAN(MAHP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

-- Môn học trong lớp (chỉ cho lớp ngắn hạn)
CREATE TABLE LOP_MONHOC (
    MALOP VARCHAR(20),
    MAMH VARCHAR(20),
    PRIMARY KEY (MALOP, MAMH),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

-- Bảng Điểm thi
CREATE TABLE DIEMTHI (
    MAHV VARCHAR(20),
    MAMH VARCHAR(20),
    DIEMTHI FLOAT,
    PRIMARY KEY (MAHV, MAMH),
    FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

-- Bảng Biên lai đóng tiền
CREATE TABLE BIENLAI (
    MABL VARCHAR(10) PRIMARY KEY,
    MAHV VARCHAR(20),
    NGAYDONGTIEN DATE,
    HOCPHI DECIMAL(10, 2),
    FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV)
);

-- =============================
-- DỮ LIỆU MẪU
-- =============================

-- Lớp học
INSERT INTO LOP VALUES
('L001', 'Lớp Java cơ bản', 'T2-T4-T6', '2025-06-01', 2000000, 'ngắn hạn'),
('L002', 'Lớp SQL nâng cao', 'T3-T5', '2025-06-05', NULL, 'dài hạn'),
('L003', 'Lớp Python', 'T2-T4', '2025-06-10', 2200000, 'ngắn hạn'),
('L004', 'Lớp C#', 'T7-CN', '2025-06-15', NULL, 'dài hạn'),
('L005', 'Lớp HTML/CSS', 'T2-T5', '2025-06-20', 1800000, 'ngắn hạn');
-- Học viên
INSERT INTO HOCVIEN VALUES
('HV01', 'Nguyễn Khang', '2005-08-16', 'Gia Lai', 'Nam', 'Sinh viên', 'L001'),
('HV02', 'Nguyễn Thị Quỳnh Hương', '2005-08-29', 'Hà Nội', 'Nữ', 'Nhân viên IT', 'L002'),
('HV03', 'Phạm Sỹ Nguyên', '2005-05-13', 'Nghệ An', 'Nam', 'Tự do', 'L003'),
('HV04', 'Phùng Mai Anh', '2005-10-13', 'Thanh Hóa', 'Nữ', 'Sinh viên', 'L004'),
('HV05', 'Nguyễn Xuân Hoan', '2005-02-03', 'Gia Lai', 'Nam', 'Giáo viên', 'L005');

-- Môn học
INSERT INTO MONHOC VALUES
('MH01', 'Lập trình Java', 30, 20),
('MH02', 'Quản trị cơ sở dữ liệu', 25, 15),
('MH03', 'Lập trình Python', 28, 22),
('MH04', 'Lập trình C#', 35, 25),
('MH05', 'Thiết kế Web', 20, 30);

-- Học phần (chỉ lớp dài hạn)
INSERT INTO HOCPHAN VALUES
('HP02', 'Học phần SQL', 'L002', '2025-06-05', 2500000),
('HP04', 'Học phần C#', 'L004', '2025-06-15', 2300000);

-- Môn học trong học phần (chỉ lớp dài hạn)
INSERT INTO HOCPHAN_MONHOC VALUES
('HP02', 'MH02'),
('HP04', 'MH04');

-- Môn học trong lớp (chỉ lớp ngắn hạn)
INSERT INTO LOP_MONHOC VALUES
('L001', 'MH01'),
('L003', 'MH03'),
('L005', 'MH05');

-- Điểm thi
INSERT INTO DIEMTHI VALUES
('HV01', 'MH01', 8.5),
('HV02', 'MH02', 7.0),
('HV03', 'MH03', 9.0),
('HV04', 'MH04', 6.5),
('HV05', 'MH05', 8.0);

-- Biên lai thu tiền
INSERT INTO BIENLAI VALUES
('BL01', 'HV01', '2025-06-02', 2000000),
('BL02', 'HV02', '2025-06-06', 2500000),
('BL03', 'HV03', '2025-06-11', 2200000),
('BL04', 'HV04', '2025-06-16', 2300000),
('BL05', 'HV05', '2025-06-21', 1800000);
