create database CNPM_DEAN_TEST
go 
use [CNPM_DEAN_TEST]
CREATE TABLE BacHoc
(
  MaBacHoc VARCHAR(50) NOT NULL,
  TenBacHoc NVARCHAR(100) NOT NULL,
  PRIMARY KEY (MaBacHoc)
);

CREATE TABLE DiaChiBang
(
  MaBang VARCHAR(50) NOT NULL,
  TenBang NVARCHAR(100) NOT NULL,
  PRIMARY KEY (MaBang)
);

CREATE TABLE KhachHang
(
  MaKhachHang int identity(1,1),
  TenKhachHang NVARCHAR(200) NOT NULL,
  SoDienThoai NVARCHAR(10) NOT NULL,
  EmailKH NVARCHAR(100) NOT NULL,
  MatKhau NVARCHAR(50) NOT NULL,
  --GioiTinh NVARCHAR(3) NOT NULL,
  --NgaySinh DATE NOT NULL,
  --DiaChi NVARCHAR(200) NOT NULL,
  PRIMARY KEY (MaKhachHang),
);

CREATE TABLE NhanVien
(
  MaNhanVien int identity(1,1) ,
  TenNhanVien NVARCHAR(200) NOT NULL,
  EmailNV NVARCHAR(100) NOT NULL,
  MatKhau NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaNhanVien)
);

CREATE TABLE HoSoDuHoc
(
  MaHoSo int identity(1,1),
  HocLuc FLOAT CHECK (HocLuc >= 0 AND HocLuc <=10),
  TiengAnh NVARCHAR(100) NOT NULL,
  NgayNop DATE NOT NULL,
  TrangThai NVARCHAR(100) NOT NULL,
  MaBacHoc VARCHAR(50) NOT NULL,
  MaKhachHang int,
  PRIMARY KEY (MaHoSo),
  FOREIGN KEY (MaBacHoc) REFERENCES BacHoc(MaBacHoc),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
);

--CREATE TABLE TaiKhoan
--(
--  MaTaiKhoan VARCHAR(5) NOT NULL,
--  Email NVARCHAR(100) NOT NULL,
--  MatKhau NVARCHAR(100) NOT NULL,
--  --MaQuyen INT NOT NULL,
--  MaNhanVien VARCHAR(5),
--  MaKhachHang VARCHAR(5),
--  PRIMARY KEY (MaTaiKhoan),
--  --FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen)
--  FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
--  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
--);

CREATE TABLE ThongTinDuHoc
(
  MaTTDH int identity(1,1),
  TenThongTinDuHoc NVARCHAR(200) NOT NULL,
  TenTruong NVARCHAR(200) NOT NULL,
  DiaChiTruong VARCHAR(200) NOT NULL,
  MoTaThongTin NVARCHAR(MAX) NOT NULL,
  ChiPhi NVARCHAR(100) NOT NULL,
  HocLuc NVARCHAR(50) NOT NULL,
  TiengAnh NVARCHAR(100) NOT NULL,
  NgayDang DATE NOT NULL,
  HanNop DATE NOT NULL,
  MaNhanVien int,
  MaBacHoc VARCHAR(50) NOT NULL,
  MaBang VARCHAR(50) NOT NULL,
  PRIMARY KEY (MaTTDH),
  FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
  FOREIGN KEY (MaBacHoc) REFERENCES BacHoc(MaBacHoc),
  FOREIGN KEY (MaBang) REFERENCES DiaChiBang(MaBang)
);

CREATE TABLE BaiViet
(
  MaBaiViet int identity(1,1),
  TenBaiViet NVARCHAR(200) NOT NULL,
  AnhBaiViet NVARCHAR(200) NOT NULL,
  NoiDung NVARCHAR(MAX) NOT NULL,
  ThoiGian DATETIME NOT NULL,
  MaNhanVien int ,
  PRIMARY KEY (MaBaiViet),
  FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

select * from BacHoc
select * from BaiViet
select * from DiaChiBang
select * from HoSoDuHoc
select * from KhachHang
select * from NhanVien
--select * from Quyen
--select * from TaiKhoan
select * from ThongTinDuHoc

insert [dbo].[BacHoc] ([MaBacHoc],[TenBacHoc]) values (N'tien-si', N'Tiến sĩ');
insert [dbo].[BacHoc] ([MaBacHoc],[TenBacHoc]) values (N'sau-dai-hoc', N'Sau Đại học');
insert [dbo].[BacHoc] ([MaBacHoc],[TenBacHoc]) values (N'dai-hoc', N'Đại học');
insert [dbo].[BacHoc] ([MaBacHoc],[TenBacHoc]) values (N'du-bi-dai-hoc', N'Dự bị Đại học');


--insert [dbo].[Quyen] ([MaQuyen], [TenQuyen]) values (1, 'Khách hàng');
--insert [dbo].[Quyen] ([MaQuyen], [TenQuyen]) values (2, 'Nhân viên');

--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaQuyen]) values (1, N'admin@gmail.com', N'12345678', 2);
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaQuyen]) values (2, N'loc123@gmail.com', N'12345678', 1);
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaQuyen]) values (3, N'tri123@gmail.com', N'12345678', 1);
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaQuyen]) values (4, N'tung123@gmail.com', N'12345678', 1);
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaQuyen]) values (5, N'dat123@gmail.com', N'12345678', 1);

insert [dbo].[NhanVien] ( [TenNhanVien], [EmailNV], [MatKhau]) values ( N'Phạm Thị Ngọc Yến', N'yen123@gmail.com', N'123456a');
insert [dbo].[NhanVien] ( [TenNhanVien], [EmailNV], [MatKhau]) values ( N'Ngô Quang Vinh', N'vinh123@gmail.com', N'123456a');
insert [dbo].[NhanVien] ( [TenNhanVien], [EmailNV], [MatKhau]) values ( N'Trần Đức Hà Sơn', N'son123@gmail.com', N'123456a');
insert [dbo].[NhanVien] ( [TenNhanVien], [EmailNV], [MatKhau]) values (N'Văn Duy Bảo', N'bao123@gmail.com', N'123456a');
 
insert [dbo].[KhachHang] ( [TenKhachHang], [SoDienThoai], [EmailKH], [MatKhau]) values ( N'Trần Tấn Lộc', N'0637452749', N'loc@gmail.com', N'123456a');
insert [dbo].[KhachHang] ( [TenKhachHang], [SoDienThoai], [EmailKH], [MatKhau]) values ( N'Nguyễn Trần Trọng Trí', N'0637452749', N'tri@gmail.com', N'123456a');
insert [dbo].[KhachHang] ( [TenKhachHang], [SoDienThoai], [EmailKH], [MatKhau]) values ( N'Lê Minh Tùng', N'0637452749', N'tung@gmail.com', N'123456a');
insert [dbo].[KhachHang] ( [TenKhachHang], [SoDienThoai], [EmailKH], [MatKhau]) values (N'Dương Tấn Đạt', N'0637452749', N'dat@gmail.com', N'123456a');


--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaNhanVien], [MaKhachHang]) values (1, N'admin@gmail.com', N'12345678', N'NV001', NULL);
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaNhanVien], [MaKhachHang]) values (2, N'loc123@gmail.com', N'12345678', NULL, N'KH001');
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaNhanVien], [MaKhachHang]) values (3, N'tri123@gmail.com', N'12345678', NULL, N'KH002');
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaNhanVien], [MaKhachHang]) values (4, N'tung123@gmail.com', N'12345678', NULL, N'KH003');
--insert [dbo].[TaiKhoan] ([MaTaiKhoan], [Email], [MatKhau], [MaNhanVien], [MaKhachHang]) values (5, N'dat123@gmail.com', N'12345678', NULL, N'KH004');


insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'california', N'California');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'new-york', N'New York');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'texas', N'Texas');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'neveda', N'Nevada');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'washington', N'Washington');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'los-angeles', N'Los Angeles');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'boston', N'Boston');
insert [dbo].[DiaChiBang] ([MaBang], [TenBang]) values (N'seattle', N'Seattle');

insert [dbo].[BaiViet] ([TenBaiViet],[AnhBaiViet],[NoiDung],[ThoiGian],[MaNhanVien]) values (N'Những thông tin hữu ích khi du học Mỹ tại Washington', N'/Content/images/BaiViet/UW_Seattle1.jpg', N'<p>Washington DC nổi tiếng ở nhiều lĩnh vực, bao gồm lịch sử, văn hóa, nghệ thuật, ẩm thực và chính trị.</p><p>Là sinh viên du học Mỹ tại Washington, cho dù bạn quan tâm đến vấn đề gì, bạn có thể tìm thấy một viện bảo tàng có liên quan đến lĩnh vực đó tại thủ đô. Tại đây có rất nhiều địa điểm thu hút, từ vườn cây đến nhà hát nhạc kịch - đều hoàn toàn miễn phí và phù hợp với ngân sách sinh viên.</p><h2>Trải nghiệm tuần đầu tiên tại thành phố</h2><p>Việc làm quen với một thành phố mới có thể vừa thú vị vừa mệt mỏi, và Washington cũng không phải là ngoại lệ.</p><p>Có rất nhiều điều để làm tại Washington mà bạn không biết là sẽ bắt đầu từ đâu. Bạn hãy xem qua những thông tin hướng dẫn về cách trải qua tuần đầu tiên và làm cho nơi ở mới trở nên quen thuộc như ở nhà.</p><h3>Hãy thử lướt qua National Mall</h3><p>Đây là một nơi hấp dẫn du khách, National Mall có thể là một địa điểm thú vị nhất tại DC. Bạn sẽ tìm thấy rất nhiều viện bảo tàng, đài kỷ niệm và các khu bảo tồn thắng cảnh tự nhiên ngay tại khu vực mà bạn đang sống, phần lớn các công trình này đều miễn phí tham quan.</p><p>Bạn không cần tham quan tất cả các công trình này ngay lập tức, nhưng hãy đến trong tuần lễ đầu tiên khi bạn vừa chuyển đến.</p><p>Một vài điểm nổi bật là:</p><ul><li>Con đường thuận tiện cho người đi bộ dài khoảng hai dặm. Bạn hãy lưu ý đến Tidal Basin ở cuối phía tây. Đây là nơi bạn sẽ muốn quay trở lại khi những cây cherry nở hoa và được mang đến buổi triển lãm lớn mùa xuân.</li><li>Lâu đài Smithsonian cách khoảng nửa đoạn đường, là một điểm dừng thú vị để lấy các mẫu quảng cáo và bản đồ tại trung tâm hỗ trợ du khách.</li><li>Tại cuối phía đông, bạn hãy tự chụp ảnh mình khi đứng trước Tòa nhà Quốc hội Hoa Kỳ để khoe với bạn bè và gia đình.</li></ul><h2>Ghi nhớ hệ thống đi lại</h2><p>Washington nổi tiếng có hệ thống giao thông không tốt. Nhưng may mắn thay, phương tiện công cộng lại hoạt động dễ dàng hơn. Tàu điện ngầm Washington không chỉ hoạt động tại DC mà còn tại các vùng ngoại ô xa xôi khác.</p><p>Có sáu tuyến xe lửa đều có biển hướng dẫn tại các trạm, trên các biển báo đều có thể hiện điểm đến cuối cùng, vì vậy bạn sẽ dễ dàng biết mình đang đi đâu. Nếu bạn gặp vấn đề, chỉ cần hỏi nhân viên của trạm hoặc truy cập Trip Planner để biết tuyến đường cần đến, kể cả các chuyến xe buýt.</p><p>Giá vé từ USD2 trở lên, tùy theo bạn đang sử dụng tuyến tốc hành ít điểm dừng (xe buýt) hoặc hoạt động trong giờ cao điểm (xe lửa). Bạn cũng có thể đăng nhập vào SmarTrip card để nạp tiền vé. Nếu bạn đi lại thường xuyên thì hãy mua vé tháng hoặc vé tuần để tiết kiệm được một ít tiền.</p>', '2023-6-24', 1);
insert [dbo].[BaiViet] ([TenBaiViet],[AnhBaiViet],[NoiDung],[ThoiGian],[MaNhanVien]) values (N'Những thông tin hữu ích khi du học Mỹ tại New York', N'/Content/images/BaiViet/MyIC_Inline_79462.jpg', N'<h1>New York - Thành phố của nhịp sống hối hả</h1><p>New York là thành phố nổi tiếng với nhịp sống hối hả và bận rộn. Nhưng một khi bạn rời xa những con đường dành cho khách du lịch, bạn sẽ khám phá một cộng đồng năng động, nhiều nơi tham quan và ẩn chứa nhiều điều đáng quý, bạn sẽ có cảm giác như đang ở nhà.</p><h2>Những lựa chọn cho kỳ nghỉ</h2><p>Bất kỳ kế hoạch nào cũng có thời gian nghỉ, và có nhiều nơi thú vị để bạn đến tham quan vào thời gian rảnh rỗi tại Thành phố New York.</p><p>Bạn sẽ có vô số việc để làm hoặc vô vàn nơi để đi, và bạn có thể hoàn thành nhiều việc mà không tốn nhiều chi phí hoặc miễn phí.</p><h3>Phà Staten Island</h3><p>Đây là một trong những cảnh đẹp nhất của Manhattan nhìn từ hướng sông và hoàn toàn miễn phí.</p><p>Chuyến phà này hoạt động 24 giờ và là đường giao thông huyết mạch cho những người sử dụng phương tiện công cộng để đi lại từ các khu vực cuối phía nam Thành phố.</p><p>Bạn hãy hướng mắt về phía Đảo Governors ở hướng đông và Đảo Ellis cũng như Tượng Nữ thần Tự do ở hướng tây. Có nhiều công viên, viện bảo tàng và nhà hàng để bạn khám phá trên đảo hoặc bạn cũng có thể di chuyển bằng phà.</p><h3>Viện bảo tàng thú vị và miễn phí</h3><p>Người dân địa phương biết nhiều viện bảo tàng New York nổi tiếng thế giới cho phép tham quan miễn phí hoặc chi phí không đáng kể.</p><p>Đối với những người cần nguồn cảm hứng của Van Gogh từ the Met, thì đừng tiếc tiền để tìm hiểu về nghệ thuật của thành phố. Viện bảo tàng lịch sử tự nhiên (Natural History Museum) cũng miễn phí, và ngay cả MOMA cũng có những ngày Thứ sáu miễn phí, vì vậy mọi người có thể thưởng thức nghệ thuật mà không tốn nhiều chi phí.</p><h3>Smorgasburg</h3><p>Chợ Chelsea tại Brooklyn là thiên đường của dân hipster. Smorgasburg được tổ chức tại Williamsburg vào mỗi Thứ bảy, và tại công viên Prospect vào mỗi Chủ nhật, với sự kết hợp giữa chợ trời/nông sản và những người bán hàng địa phương.</p><p>Các món ăn và những người sành ăn từ khắp nơi trong thành phố sẽ cùng tham gia vào lễ hội ẩm thực này. Nhiều người dân địa phương đến đây bởi vì đồ ăn quá ngon, điều này làm cho kỳ nghỉ của khóa học thêm ý nghĩa – vừa rẻ vừa ngon.</p><h3>30 Under 30</h3><p>Đây là cách mà sinh viên du học Mỹ tại New York có thể xem kịch với giá rẻ.</p><p>Các vé 30 Under 30 được phát hành bởi Câu lạc bộ Kịch nghệ Manhattan, cung cấp vé xem kịch với giá tiết kiệm dành cho giới trẻ. Đây chỉ là một trong nhiều cách mà các nhà hát nhạc kịch Off-Broadway hỗ trợ người dân địa phương.</p><h3>Đi dạo</h3><p>Thành phố New York tự hào sở hữu 1.700 công viên, vì vậy, bạn sẽ có vô số địa điểm “xanh” để khám phá.</p><p>High Line là một điểm đến được yêu thích, nằm ở phía tây Manhattan. Được xây dựng trên một phần đất bị bỏ hoang của Đường xe lửa trên cao tại Trung tâm New York, nơi đây đã được thay đổi thành công viên dành cho khách bộ hành và không gian nghệ thuật cho công chúng, và mở cửa quanh năm.</p><p>Công viên Central Park cũng là địa điểm giải trí thú vị dành cho người dân địa phương và du khách. Công viên rộng 843 mẫu Anh, bạn phải đến vài lần mới có thể tham quan hết, nơi đây rất thích hợp cho một buổi picnic hoặc dạo quanh bằng xe đạp.</p><h2>Các chuyến tham quan trong ngày ở ngoài thành phố</h2><p>Sống trong một thành phố sầm uất như New York, sẽ có lúc bạn cảm thấy mệt mỏi, vì vậy thỉnh thoảng bạn hãy lên kế hoạch cho kỳ nghỉ của mình.</p><p>Có nhiều địa điểm đẹp để bạn khám phá chỉ trong một ngày.</p>', '2023-6-24', 1);


insert [dbo].[HoSoDuHoc] ([HocLuc], [TiengAnh], [NgayNop], [TrangThai], [MaBacHoc], [MaKhachHang]) values (7.5, N'TOEFL iBT 68 / IELTS 5.5', '2023-07-20', N'Tư vấn', N'dai-hoc', 1);
insert [dbo].[HoSoDuHoc] ([HocLuc], [TiengAnh], [NgayNop], [TrangThai], [MaBacHoc], [MaKhachHang]) values (8.0, N'TOEFL iBT 68 / IELTS 5.5', '2023-07-20', N'Liên hệ', N'dai-hoc', 2);
insert [dbo].[HoSoDuHoc] ([HocLuc], [TiengAnh], [NgayNop], [TrangThai], [MaBacHoc], [MaKhachHang]) values (7.0, N'TOEFL iBT 68 / IELTS 5.5', '2023-07-20', N'Đã gửi', N'sau-dai-hoc', 3);
insert [dbo].[HoSoDuHoc] ([HocLuc], [TiengAnh], [NgayNop], [TrangThai], [MaBacHoc], [MaKhachHang]) values (9.0, N'TOEFL iBT 68 / IELTS 5.5', '2023-07-20', N'Kết quả', N'sau-dai-hoc', 4);

insert [dbo].[ThongTinDuHoc] ([TenThongTinDuHoc], [TenTruong], [DiaChiTruong], [MoTaThongTin], [ChiPhi], [HocLuc], [TiengAnh], [NgayDang], [HanNop], [MaNhanVien], [MaBacHoc], [MaBang]) values (N'Học bổng Du học tại College of Southern Nevada - Mở cánh cửa cho tương lai rực rỡ', N'College of Southern Nevada', N'700 College Dr, Henderson, NV 89002, USA', N'<h1>College of Southern Nevada</h1><p>Được thành lập năm 1971, College of Southern Nevada mang đến cho sinh viên cơ hội sáng tạo và thay đổi cuộc sống thông qua chương trình đào tạo chất lượng, kinh nghiệm phong phú. Trường được công nhận bởi Northwest Commission on Colleges and Universities (NWCCU) về chất lượng giáo dục liên tục nhiều năm từ 1975.</p><p>Trường cung cấp học phí thấp nhất ở Southern Nevada, cung cấp các lớp học có sĩ số nhỏ để các sinh viên và cộng đồng có thể có được một nền giáo dục chất lượng, được công nhận mà không đòi hỏi quá nhiều về tài chính. Nếu sinh viên cần hỗ trợ, trường đại học có thể hướng dẫn qua quy trình hỗ trợ tài chính và lên kế hoạch từ học bổng và trợ cấp cho các khoản vay và kế hoạch thanh toán.</p><p>Nhiều dịch vụ hỗ trợ mà sinh viên có thể tìm thấy tại Department of Student Life and Leadership Development như đánh giá nghề nghiệp và hướng nghiệp qua các bài test trên máy tính. Trường sẽ hỗ trợ sinh viên tìm kiếm việc làm qua hệ thống Careerlink. Các hội chợ việc làm thường xuyên được tổ chức giúp sinh viên có cơ hội gặp gỡ với các nhà tuyển dụng và phỏng vấn tìm việc làm; giao lưu với mạng lưới cựu sinh viên rộng lớn.</p><p>Trường cũng có các đối tác trường đại học nghiên cứu hàng đầu Hoa Kỳ nhằm đảm bảo việc nhập học đại học các chương trình cấp bằng cử nhân, dành cho những sinh viên đạt đủ điều kiện.</p><p>Sinh viên có nhiều cơ sở để mở rộng bản thân về mặt xã hội, thể chất thông qua hơn 30 câu lạc bộ, các hoạt động ngoại khóa, tạo môi trường giúp các sinh viên đến từ 50 bang và hơn 60 quốc gia trên thế giới tham gia và kết bạn với nhau.</p>', N'$29,160/năm', N'Ít nhất 6.5 (trên thang 10)', N'TOEFL iBT 68 / IELTS 5.5 trở lên', '2023-07-20', '2024-01-15', 1, N'dai-hoc', N'neveda');
insert [dbo].[ThongTinDuHoc] ([TenThongTinDuHoc], [TenTruong], [DiaChiTruong], [MoTaThongTin], [ChiPhi], [HocLuc], [TiengAnh], [NgayDang], [HanNop], [MaNhanVien], [MaBacHoc], [MaBang]) values (N'Học bổng Du học tại California State University Northridge đạt top #600 tại Đại học tốt nhất ở Mỹ', N'California State University Northridge', N'5241 N Maple Ave, Fresno, California, USA', N'<p>Được thành lập vào năm 1958, California State University, Northridge (CSUN)  là một tổ chức giáo dục đại học công lập có quy mô lớn chính thức được công nhận bởi WASC Senior College and University Commission. CSUN có 9 trường trực thuộc cung cấp 68 chương trình Cử nhân, 58 chương trình đào tạo Thạc sĩ , 2 chương trình Tiến sĩ và 14 chương trình chứng chỉ giảng dạy.</p><h2>Các trường trực thuộc:</h2><ul><li>Mike Curb College of Arts, Media, and Communication</li><li>David Nazarian College of Business & Economics</li><li>Michael D. Eisner College of Education</li><li>Engineering & Computer Science</li><li>Tseng College</li><li>Health & Human Development</li><li>Humanities</li><li>Science & Mathematics</li><li>Social & Behavioral Sciences</li></ul><h2>Ưu tiên hàng đầu của California State University, Northridge (CSUN)</h2><p>Thúc đẩy sự tiến bộ về phúc lợi và trí tuệ của sinh viên. Để hoàn thành nhiệm vụ này, trường đã thiết kế các chương trình và hoạt động để giúp sinh viên phát triển năng lực học tập, khả năng chuyên môn, óc sáng tạo và giá trị đạo đức của những người sống trong một xã hội dân chủ trong thời đại công nghệ.</p><h2>Các bậc đào tạo:</h2><p>Bachelor, Master, Certificate.</p><h2>Các chuyên ngành đào tạo:</h2><p>Các chuyên ngành đào tạo thế mạnh: Business, Arts, Maketing, Education, Music, Nursing,...</p><h2>Các ngành đào tạo phổ biến:</h2><ul><li>College of Engineering & Computer Science:</li><ul><li>Bachelor: Construction Management, Civil Engineering, Computer Science, Computer Information Technology, Electrical Engineering, Computer Engineering, Engineering Management, Manufacturing Systems Engineering, Mechanical Engineering.</li><li>Master: Structural Engineering, Computer Science, Software Engineering, Assistive Technology Engineering, Computer Engineering, Electrical Engineering, Materials Engineering, Engineering Management, Manufacturing Systems Engineering, Mechanical Engineering.</li></ul><li>College of Health & Human Development</li><ul><li>Bachelor: Apparel Design & Merchandising; Consumer Affairs; FCS Education; Family Studies; Interior Design; Nutrition, Dietetics & Food Science (Didactic Program in Dietetics)</li><li>Master: Family and Consumer Sciences (Apparel Design & Merchandising, Consumer Affairs & Family Studies); Human Nutrition (Dietetic Internship Program)</li></ul><li>Tseng College</li><ul><li>Bachelor: Public Sector Management; Liberal Studies</li><li>Master: Assistive Technology Engineering; Assistive Technology Studies and Human Services; Engineering Management; Humanities; Knowledge Management; Music Industry Administration; Public Administration Health Administration Option; Public Administration Public Sector Management and Leadership Option; Public Health Community Health Education; Social Work; Taxation; Business Administration.</li></ul></ul>',  N'$35,160/năm', N'Ít nhất 6.5 (trên thang 10)', N'TOEFL iBT 68 / IELTS 5.5 trở lên', '2023-07-20', '2024-01-15', 1, N'sau-dai-hoc', N'california');


--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'tu-van', N'Tư vấn');
--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'lien-he', N'Liên hệ');
--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'nhan-ho-so-va-thanh-toan', N'Nhận hồ sơ và thanh toán');
--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'da-gui', N'Đã gửi');
--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'da-nhan', N'Đã nhận');
--insert [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) values (N'ket-qua', N'Kết quả');

DROP TABLE [dbo].[ThongTinDuHoc]

