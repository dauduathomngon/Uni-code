﻿USE QL_THAMGIADT

--Q75--
SELECT GV.HOTEN, BM.TENBOMON
FROM GIAOVIEN AS GV
LEFT JOIN BOMON AS BM
ON GV.MAGV = BM.TRUONGBM

--Q76--
SELECT BM.TENBOMON, GV.HOTEN AS TRUONG_BM
FROM BOMON AS BM
LEFT JOIN GIAOVIEN AS GV
ON GV.MAGV = BM.TRUONGBM

--Q77--
SELECT GV.HOTEN, DT.TENDT
FROM GIAOVIEN AS GV
LEFT JOIN DETAI AS DT
ON GV.MAGV = DT.GVCNDT

--Q78--
SELECT GV.MAGV, GV.HOTEN, 
	(CASE
		WHEN GV.LUONG < 1800 THEN N'Thấp' 
		WHEN GV.LUONG >= 1800 AND GV.LUONG <= 2200 THEN N'Trung bình'
		WHEN GV.LUONG > 2200 THEN N'Cao'
	END) AS MUCLUONG		 		
FROM GIAOVIEN AS GV

--Q79--
SELECT GV1.MAGV, GV1.HOTEN, (SELECT COUNT(*) + 1
			FROM GIAOVIEN AS GV2
			WHERE GV2.LUONG < GV1.LUONG) AS HANG
FROM GIAOVIEN AS GV1
ORDER BY GV1.LUONG ASC

--Q80--
SELECT GV.MAGV, GV.HOTEN, GV.LUONG + (CASE 
										WHEN K.TRUONGKHOA IS NOT NULL AND BM.TRUONGBM IS NOT NULL THEN 900
										WHEN K.TRUONGKHOA IS NULL AND BM.TRUONGBM IS NOT NULL THEN 300
										WHEN K.TRUONGKHOA IS NOT NULL AND BM.TRUONGBM IS NULL THEN 600
										WHEN K.TRUONGKHOA IS NULL AND BM.TRUONGBM IS NULL THEN 0
									  END) AS THUNHAP
FROM GIAOVIEN AS GV, KHOA AS K, BOMON AS BM
WHERE GV.MABM = BM.MABM AND K.MAKHOA = BM.MAKHOA

--Q81--
SELECT GV.MAGV, GV.HOTEN, YEAR(GV.NGAYSINH) + (CASE
												WHEN GV.PHAI = 'Nam' THEN 60
												WHEN GV.PHAI = N'Nữ' THEN 55
											   END) AS NAM_NGHIHUU
FROM GIAOVIEN AS GV