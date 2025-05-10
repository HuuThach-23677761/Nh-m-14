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
	CHUONGTRINH nVarchar(100), 
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
('L001', 'Lớp Java cơ bản', 'T2-T4-T6', '2025-06-01', 2000000,'HK1-01', 'ngắn hạn'),
('L002', 'Lớp SQL nâng cao', 'T3-T5', '2025-06-05', NULL,'HK2-01', 'dài hạn'),
('L003', 'Lớp Python', 'T2-T4', '2025-06-10', 2200000,'HK3-01', 'ngắn hạn'),
('L004', 'Lớp C#', 'T7-CN', '2025-06-15', NULL,'HK1-02', 'dài hạn'),
('L005', 'Lớp HTML/CSS', 'T2-T5', '2025-06-20', 1800000,'HK2-02', 'ngắn hạn');
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



---------------------------------------Truy Vấn --------------------------------------
--2 Câu truy vấn lồng
--/*Tìm danh sách học viên thuộc các lớp có học phí cao hơn mức trung bình của tất cả lớp học.*/
SELECT HOTEN
FROM HOCVIEN
WHERE MAHV IN (
    SELECT MAHV
    FROM DIEMTHI
    WHERE DIEMTHI = (
        SELECT MAX(DIEMTHI) FROM DIEMTHI
    )
);
--Kết quả = 1
 
--/* Tính tổng học phí đã đóng của từng lớp (có học viên đóng tiền).*/
SELECT L.TENLOP, SUM(B.HOCPHI) AS TongHocPhiDaDong
FROM BIENLAI B
JOIN HOCVIEN HV ON B.MAHV = HV.MAHV
JOIN LOP L ON HV.MALOP = L.MALOP
GROUP BY L.TENLOP
ORDER BY TongHocPhiDaDong DESC;
--Kết quả = 5
 

--2 Câu Delete
--/*Xóa các học viên thuộc lớp ngắn hạn đã hoàn thành và có điểm thi dưới 5*/
DELETE FROM HOCVIEN WHERE MAHV IN ( SELECT MAHV FROM DIEMTHI WHERE DIEMTHI < 5 ) AND MALOP IN ( SELECT MALOP FROM LOP WHERE LOAILOP = N'ngắn hạn' );
/*Xóa học viên không có điểm thi nào*/
DELETE FROM HOCVIEN WHERE MAHV NOT IN (SELECT MAHV FROM DIEMTHI);

--2 Câu subquerry
--/*Liệt kê thông tin các học viên có học phí đã đóng nhiều hơn mức học phí trung bình của tất cả học viên*/
SELECT H.MAHV, H.HOTEN, H.NGAYSINH, H.NOISINH, H.PHAI, H.NGHENGHIEP
FROM HOCVIEN H
WHERE H.MAHV IN (
    SELECT MAHV
    FROM BIENLAI
    GROUP BY MAHV
    HAVING SUM(HOCPHI) > (
        SELECT AVG(TongHP)
        FROM (
            SELECT MAHV, SUM(HOCPHI) AS TongHP
            FROM BIENLAI
            GROUP BY MAHV
        ) AS T
    )
)
--Kết quả = 3
 
--/*Tìm tên lớp học mà học viên tên 'Nguyễn Xuân Hoan' đã đóng học phí*/
SELECT TENLOP
FROM LOP
WHERE MALOP IN (
    SELECT MALOP
    FROM HOCPHAN
    WHERE MAHP IN (
        SELECT MAHP
        FROM HOCPHAN_MONHOC
        WHERE MAMH IN (
            SELECT MAMH
            FROM DIEMTHI
            WHERE MAHV = (
                SELECT MAHV
                FROM HOCVIEN
                WHERE HOTEN = 'Nguyễn Xuân Hoan'
            )
        )
    )
)
--Kết quả : Lớp HTML/CSS

--2 Câu Update
UPDATE HOCVIEN
SET NGHENGHIEP = 'Lập trình viên'
WHERE MAHV = 'HV03';

UPDATE LOP
SET HOCPHI = HOCPHI + 500000
WHERE MALOP = 'L004';

--2 Câu Group By
--/*Thống kê số lượng học viên theo từng lớp học*/
SELECT L.TENLOP, COUNT(H.MAHV) AS SoLuongHocVien
FROM LOP L
JOIN HOCVIEN H ON L.MALOP = H.MALOP
GROUP BY L.TENLOP;
--Kết quả = 5
 
/* Tính điểm trung bình mỗi môn học*/
SELECT M.TENMONHOC, AVG(D.DIEMTHI) AS DiemTrungBinh
FROM MONHOC M
JOIN DIEMTHI D ON M.MAMH = D.MAMH
GROUP BY M.TENMONHOC
--Kết quả = 5
 
--2 Câu tùy ý (Select)
--*/Liệt kê họ tên học viên và tên lớp mà học viên đó đang tham gia học, sắp xếp theo tên học viên.*/
SELECT HV.HOTEN, L.TENLOP
FROM HOCVIEN HV
JOIN LOP L ON HV.MALOP = L.MALOP
ORDER BY HV.HOTEN;

--Kết quả = 5
 
/*Liệt kê tên môn học và số lượng học viên đã thi môn đó, sắp xếp theo số lượng học viên giảm dần.*/
SELECT MH.TENMONHOC, COUNT(DT.MAHV) AS SO_HOCVIEN_THI
FROM MONHOC MH
JOIN DIEMTHI DT ON MH.MAMH = DT.MAMH
GROUP BY MH.TENMONHOC
ORDER BY SO_HOCVIEN_THI DESC;
--Kết quả = 5


--------------------------------------------bài truy vấn cá nhân------------------------------------------------
--Văn Khoa
--/Tính tổng học phí mà mỗi học viên đã đóng, sắp xếp giảm dần theo số tiền./
SELECT 
    HV.HOTEN AS HoTenHocVien,
    SUM(BL.HOCPHI) AS TongHocPhiDong
FROM BIENLAI BL
JOIN HOCVIEN HV ON BL.MAHV = HV.MAHV
GROUP BY HV.HOTEN
ORDER BY TongHocPhiDong DESC;
--– Kết quả = 5
 
-- /Liệt kê danh sách lớp học dài hạn kèm số học phần của mỗi lớp./
SELECT 
    L.TENLOP AS TenLopDaiHan,
    COUNT(HP.MAHP) AS SoHocPhan
FROM LOP L
LEFT JOIN HOCPHAN HP ON L.MALOP = HP.MALOP
WHERE L.LOAILOP = N'dài hạn'
GROUP BY L.TENLOP;
--– Kết quả = 0 

--/Xóa biên lai của học viên có điểm thi dưới 7/

DELETE FROM BIENLAI
WHERE MAHV IN (
    SELECT MAHV
    FROM DIEMTHI
    WHERE DIEMTHI < 7
);
--– Kết quả = 1

/*Cập nhật THOIKHOABIEU thành 'T2-T4-T6' cho những lớp ngắn hạn có học phí cao hơn mức học phí trung bình của tất cả các lớp ngắn hạn*/
UPDATE LOP
SET THOIKHOABIEU = 'T2-T4-T6'
WHERE LOAILOP = N'ngắn hạn'
  AND HOCPHI > (
    SELECT AVG(HOCPHI)
    FROM LOP
    WHERE LOAILOP = N'ngắn hạn'
  );

/* Liệt kê tên các học viên có điểm thi cao hơn điểm thi trung bình của toàn bộ học viên trong hệ thống.*/
SELECT HV.HOTEN, DT.DIEMTHI
FROM DIEMTHI DT
JOIN HOCVIEN HV ON DT.MAHV = HV.MAHV
WHERE DT.DIEMTHI > (
  SELECT AVG(DIEMTHI)
  FROM DIEMTHI
);

--Nguyễn Khang
/*Tìm tên học viên có điểm thi cao nhất môn "Lập trình Python"*/
SELECT HOTEN
FROM HOCVIEN
WHERE MAHV IN (
    SELECT MAHV
    FROM DIEMTHI
    WHERE MAMH = 'MH03' AND DIEMTHI = (
        SELECT MAX(DIEMTHI)
        FROM DIEMTHI
        WHERE MAMH = 'MH03'
    )
)
/*Tăng học phí thêm 5% cho các lớp có học viên tên chứa từ "Nguyễn"*/
UPDATE LOP
SET HOCPHI = HOCPHI * 1.05
WHERE MALOP IN (
    SELECT DISTINCT L.MALOP
    FROM LOP L
    JOIN HOCPHAN HP ON L.MALOP = HP.MALOP
    JOIN HOCPHAN_MONHOC HPM ON HP.MAHP = HPM.MAHP
    JOIN DIEMTHI DT ON DT.MAMH = HPM.MAMH
    JOIN HOCVIEN HV ON HV.MAHV = DT.MAHV)

/* Tìm lớp đông học viên nhất */
SELECT TOP 1 L.TENLOP, COUNT(H.MAHV) AS SoLuongHocVien
FROM LOP L
JOIN HOCVIEN H ON L.MALOP = H.MALOP
GROUP BY L.TENLOP
ORDER BY SoLuongHocVien DESC

/* Liệt kê học viên chưa đống học phí */
SELECT HV.MAHV, HV.HOTEN, L.TENLOP
FROM HOCVIEN HV
JOIN LOP L ON HV.MALOP = L.MALOP
WHERE HV.MAHV NOT IN (SELECT MAHV FROM BIENLAI)

/* Tính tổng số tiết học (lý thuyết + thực hành) của từng lớp ngắn hạn */
SELECT L.TENLOP, SUM(M.SOTIETLYTHUYET + M.SOTIETTHUCHANH) AS TongSoTiet
FROM LOP L
JOIN LOP_MONHOC LM ON L.MALOP = LM.MALOP
JOIN MONHOC M ON LM.MAMH = M.MAMH
WHERE L.LOAILOP = N'ngắn hạn'
GROUP BY L.TENLOP


--Khánh Linh
/*Hãy liệt kê tên lớp, số lượng môn học của từng lớp, chỉ lấy các lớp có nhiều hơn 1 môn học*/
     SELECT L.TENLOP, COUNT(LM.MAMH) AS SoLuongMonHoc
     FROM LOP L
     JOIN LOP_MONHOC LM ON L.MALOP = LM.MALOP
     GROUP BY L.TENLOP
     HAVING COUNT(LM.MAMH) > 1;
/*Liệt kê tên môn học có số tiết thực hành nhiều hơn lý thuyết*/
SELECT TENMONHOC
FROM MONHOC
WHERE SOTIETTHUCHANH > (
   SELECT SOTIETLYTHUYET
   FROM MONHOC
   WHERE TENMONHOC = MONHOC.TENMONHOC)
/*Liệt kê mã học viên, tên học viên, tên môn học, tên lớp mà học viên đó đã thi môn học đó thuộc lớp nào*/
SELECT HV.MAHV, HV.HOTEN, MH.TENMONHOC, L.TENLOP
FROM HOCVIEN HV
JOIN DIEMTHI DT ON HV.MAHV = DT.MAHV
JOIN MONHOC MH ON DT.MAMH = MH.MAMH
JOIN LOP_MONHOC LMH ON MH.MAMH = LMH.MAMH
JOIN LOP L ON LMH.MALOP = L.MALOP
 
/*Liệt kê tên học viên, nghề nghiệp, tên lớp, loại lớp mà học viên đó đã đóng học phí (theo biên lai), sắp xếp theo ngày đóng tiền mới nhất*/
SELECT 
    HV.HOTEN, HV.NGHENGHIEP, 
    L.TENLOP, L.LOAILOP, BL.NGAYDONGTIEN
FROM BIENLAI BL
JOIN HOCVIEN HV ON BL.MAHV = HV.MAHV
JOIN LOP L ON HV.MALOP = L.MALOP
ORDER BY BL.NGAYDONGTIEN DESC

--Lê Thị Chung
--Detele 
/*Xóa tất cả học phần có chứa môn học thực hành >= 25 tiết*/
DELETE FROM HOCPHAN
WHERE MAHP IN (
    SELECT DISTINCT HPMH.MAHP
    FROM HOCPHAN_MONHOC HPMH
    JOIN MONHOC MH ON HPMH.MAMH = MH.MAMH
    WHERE MH.SOTIETTHUCHANH >= 25
	)
--Update
/*Cập nhật nghề nghiệp thành “Đã tốt nghiệp” cho những học viên có điểm thi tất cả môn >= 5 */
UPDATE HOCVIEN
SET NGHENGHIEP = N'Đã tốt nghiệp'
WHERE MAHV IN (
    SELECT MAHV
    FROM DIEMTHI
    GROUP BY MAHV
    HAVING MIN(DIEMTHI) >= 5)
--Group by 
/*Mỗi lớp học có tổng số tiết thực hành là bao nhiêu? */
SELECT LM.MALOP, SUM(MH.SOTIETTHUCHANH) AS TongTietThucHanh
FROM LOP_MONHOC LM
JOIN MONHOC MH ON LM.MAMH = MH.MAMH
GROUP BY LM.MALOP
--Sub query
/*Tìm các học phần có học phí lớn hơn học phí của lớp “Lớp Java cơ bản”*/
SELECT HP.MAHP, HP.TENHOCPHAN
FROM HOCPHAN HP
WHERE HP.HOCPHI > (
    SELECT HOCPHI 
    FROM LOP 
  WHERE TENLOP = 'Lớp Java cơ bản')
--Truy vấn kết nối nhiều bảng 
/*Liệt kê các học viên cùng lớp và học phần họ đã tham gia, trong đó chỉ lấy các học viên có điểm thi trên 8.0*/
SELECT H.HOTEN, L.TENLOP, HP.TENHOCPHAN, D.DIEMTHI
FROM HOCVIEN H
JOIN DIEMTHI D ON H.MAHV = H.MAHV
JOIN LOP L ON L.MALOP= H.MALOP
JOIN HOCPHAN HP ON HP.MALOP = L.MALOP
WHERE D.DIEMTHI > 8.0

--Hửu Thạch
/* Học viên học lớp có học phí cao nhất.*/
SELECT * FROM HOCVIEN
WHERE MALOP = (
SELECT MALOP FROM LOP 
WHERE HOCPHI = (SELECT MAX(HOCPHI) FROM LOP WHERE LOAILOP = N'ngắn hạn')
);
/* Mỗi lớp và tổng học phí học viên của lớp đó đã đóng (nếu có).*/
SELECT L.TENLOP, SUM(BL.HOCPHI) AS TongHocPhi
FROM LOP L
JOIN HOCVIEN HV ON L.MALOP = HV.MALOP
JOIN BIENLAI BL ON HV.MAHV = BL.MAHV
GROUP BY L.TENLOP;
/* Mức học phí cao nhất của lớp ngắn hạn*/
SELECT MAX(HOCPHI) AS HocPhiCaoNhat
FROM LOP
WHERE LOAILOP = N'ngắn hạn';

/*Điểm thi kèm tên học viên và tên môn học*/
SELECT HV.HOTEN, MH.TENMONHOC, DT.DIEMTHI 
FROM DIEMTHI DT
JOIN HOCVIEN HV ON DT.MAHV = HV.MAHV
JOIN MONHOC MH ON DT.MAMH = MH.MAMH;
/* Điểm thi xếp loại (Giỏi >=8, Khá >=6.5, TB <6.5)*/
SELECT HV.HOTEN, DT.DIEMTHI,
CASE 
WHEN DIEMTHI >= 8 THEN N'Giỏi'
WHEN DIEMTHI >= 6.5 THEN N'Khá'
ELSE N'Trung bình'
END AS XepLoai
FROM DIEMTHI DT
JOIN HOCVIEN HV ON DT.MAHV = HV.MAHV;


