DROP DATABASE IF EXISTS  BTL_Flutter;
CREATE DATABASE BTL_Flutter DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

use BTL_Flutter;

CREATE TABLE songs (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	title VARCHAR(100),
	album VARCHAR(100),
	artist VARCHAR(100),
	source VARCHAR(100),
	image VARCHAR(100),
	duration INT,
	PRIMARY KEY(id)
);


CREATE TABLE account (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	name VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	password VARCHAR(100),
	birthday DATE DEFAULT CURRENT_DATE,
	gender BOOLEAN,
	role VARCHAR(100) DEFAULT 'user',
	PRIMARY KEY(id)
);


CREATE TABLE favorite (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	song_id INT NOT NULL,
	account_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(song_id) REFERENCES songs(id),
	FOREIGN KEY(account_id) REFERENCES account(id)
);


INSERT INTO account (name, email, password, gender,role) VALUES 
('Manh','admin@gmail.com','123456','true','admin');


INSERT INTO `songs` (`id`, `title`, `album`, `artist`, `source`, `image`, `duration`) VALUES
(1, 'Xin Đừng Lặng Im', 'Xin Đừng Lặng Im(Single)', 'SOOBIN', 'https://thantrieu.com/resources/music/1078245070.mp3', 'https://thantrieu.com/resources/arts/1078245070.webp', 250),
(2, 'Chạy Về Khóc Với Anh', 'Chạy Về Khóc Với Anh(Single)', 'ERIK', 'https://thantrieu.com/resources/music/1121429554.mp3', 'https://thantrieu.com/resources/arts/1121429554.webp', 224),
(3, 'Như Anh Đã Thấy Em', 'Chẳng Thể Tìm Được Em 2', 'Phúc XP ft Freak D', 'https://thantrieu.com/resources/music/1130295694.mp3', 'https://thantrieu.com/resources/arts/1130295694.webp', 302),
(4, 'Có Chơi Có Chịu', 'KARIK X ONLY C', 'Karik ft Only C', 'https://thantrieu.com/resources/music/1130295695.mp3', 'https://thantrieu.com/resources/arts/1130295695.webp', 224),
(5, 'Hoa Nở không Màu', 'Đồng Dao Show', 'Hoài Lâm', 'https://thantrieu.com/resources/music/1130295696.mp3', 'https://thantrieu.com/resources/arts/1130295696.webp', 257),
(6, 'Đế Vương', 'Ciray Remix-Cover', 'Đình Dũng', 'https://thantrieu.com/resources/music/1130295697.mp3', 'https://thantrieu.com/resources/arts/1130295697.webp', 199),
(7, 'Trách Duyên Trách Phận', 'Unknown', 'Đỗ Thành Duy', 'https://thantrieu.com/resources/music/1130295699.mp3', 'https://thantrieu.com/resources/arts/1130295699.webp', 284),
(8, 'Hoa Nở không Màu', 'Đồng Dao Show', 'Hoài Lâm', 'https://thantrieu.com/resources/music/1130295696.mp3', 'https://thantrieu.com/resources/arts/1130295696.webp', 257),
(9, 'Thì Thôi', 'Remix-Đại Mèo', 'Nal ft TVk ft 93NEW-G', 'https://thantrieu.com/resources/music/1130295698.mp3', 'https://thantrieu.com/resources/arts/1130295698.webp', 287),
(10, 'Cưới Hông Chốt Nha', 'NH4T', 'Út Nhị Mino', 'https://thantrieu.com/resources/music/1130295700.mp3', 'https://thantrieu.com/resources/arts/1130295700.webp', 257),
(11, 'Beautiful In White', 'Wild Angel\'s Collection', 'Shayne Ward', 'https://thantrieu.com/resources/music/1073419268.mp3', 'https://thantrieu.com/resources/arts/1073419268.webp', 232),
(12, 'Where Have You Gone', 'Collection Songs', 'Ricky J', 'https://thantrieu.com/resources/music/1073850016.mp3', 'https://thantrieu.com/resources/arts/1073850016.webp', 323),
(13, 'Right Here Waiting For You', 'Wild Angel\'s Collection', 'Richard Marx', 'https://thantrieu.com/resources/music/1073969708.mp3', 'https://thantrieu.com/resources/arts/1073969708.webp', 262),
(14, 'Mặt Trời Của Em', 'Mặt Trời Của Em(Single)', 'Phương Ly ft JustaTee', 'https://thantrieu.com/resources/music/1078245050.mp3', 'https://thantrieu.com/resources/arts/1078245050.webp', 249),
(15, 'Giả Vờ Nhưng Em Yêu Anh', 'Em Yêu Anh', 'Miu Lê', 'https://thantrieu.com/resources/music/1074592745.mp3', 'https://thantrieu.com/resources/arts/1074183664.webp', 236),
(16, 'Phía Sau Một Cô Gái', 'Phía Sau Một Cô Gái(Single)', 'SOOBIN', 'https://thantrieu.com/resources/music/1078245018.mp3', 'https://thantrieu.com/resources/arts/1078245018.webp', 270),
(17, 'Yêu Anh Đi Mẹ Anh Bán Bánh Mì', 'Yêu Anh Đi Mẹ Anh Bán Bánh Mì(EP)', 'Phúc Du', 'https://thantrieu.com/resources/music/1078245030.mp3', 'https://thantrieu.com/resources/arts/1078245030.webp', 253),
(18, 'See Tình', 'LINK', 'Hoàng Thùy Linh', 'https://thantrieu.com/resources/music/1078245035.mp3', 'https://thantrieu.com/resources/arts/1078245035.webp', 185),
(19, 'Hết Thương Cạn Nhớ', 'Hết Thương Cạn Nhớ(Single)', 'Đức Phúc', 'https://thantrieu.com/resources/music/1078245049.mp3', 'https://thantrieu.com/resources/arts/1078245049.webp', 284);
