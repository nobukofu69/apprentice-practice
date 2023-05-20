-- 1.データベースの作成
CREATE DATABASE internet_tv;

-- 2.データベースの選択
USE internet_tv;

-- 3.テーブルの作成
CREATE TABLE channels (
    PRIMARY KEY(id),
    id   INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE programs (
    PRIMARY KEY(id),
    id            BIGINT NOT NULL AUTO_INCREMENT,
    program_title VARCHAR(100) NOT NULL,
    program_info  VARCHAR(1000) NOT NULL,
    UNIQUE(program_title)
);

CREATE TABLE episodes (
    PRIMARY KEY(id),
    id               BIGINT NOT NULL AUTO_INCREMENT,
    season_num       INT,
    episode_num      INT,
    episode_title    VARCHAR(100) NOT NULL,
    episode_info     VARCHAR(1000) NOT NULL,
    video_time       TIME NOT NULL,
    release_date     DATETIME NOT NULL,
    views            BIGINT NOT NULL,
    program_id       BIGINT(20) NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs(id),
    INDEX(views)
);

CREATE TABLE tv_schedules (
    PRIMARY KEY(id), 
    id         BIGINT NOT NULL AUTO_INCREMENT,
    channel_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time   DATETIME NOT NULL,
    views      INT NOT NULL,
    episode_id BIGINT NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES channels(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id),
    UNIQUE (channel_id, start_time)
);

CREATE TABLE genres (
    PRIMARY KEY(id),
    id   INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE program_genres (
    PRIMARY KEY(program_id, genre_id),
    program_id BIGINT NOT NULL,
    genre_id   INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- 4.データの挿入
START TRANSACTION;
-- 4-1. channelsテーブルにデータを挿入
INSERT INTO channels (name) VALUES ('ドラマ'), ('スポーツ'), ('料理');

-- 4-2. programsテーブルにデータを挿入
INSERT INTO programs (program_title, program_info) VALUES 
('夏の冒険', '夏の休みを利用して、主人公たちが冒険に出る物語'), 
('冬の料理ショー', '料理上手なシェフが冬におすすめの料理を紹介する番組'), 
('春の恋', '春に出会った二人の甘酸っぱい恋愛物語');

-- 4-3. episodesテーブルにデータを挿入
INSERT INTO episodes (season_num, episode_num, episode_title, episode_info, video_time, release_date, views, program_id) VALUES 
(2, 1, '夏の冒険 第1話: 新たな出発', '主人公たちが旅に出るところから物語が始まる', '00:30:00', '2023-01-01 00:00:00', 3000, 1),
(2, 2, '夏の冒険 第2話: 初めての挑戦', '主人公たちが初めての挑戦に立ち向かう', '00:30:00', '2023-01-08 00:00:00', 3500, 1),
(2, 3, '夏の冒険 第3話: 友情の証', '主人公たちが友情を深めるエピソード', '00:30:00', '2023-01-15 00:00:00', 4000, 1),
(4, 1, '冬の料理ショー 第1話: ホットチョコレート', 'シェフがホットチョコレートの作り方を紹介', '01:00:00', '2023-01-01 00:00:00', 3000, 2),
(4, 2, '冬の料理ショー 第2話: チキンスープ', 'シェフが心温まるチキンスープの作り方を紹介', '01:00:00', '2023-01-08 00:00:00', 4000, 2),
(4, 3, '冬の料理ショー 第3話: スノーボールクッキー', 'シェフが冬にぴったりのスノーボールクッキーの作り方を紹介', '01:00:00', '2023-01-15 00:00:00', 5000, 2),
(3, 1, '春の恋 第1話: 出会い', '主人公たちの出会いから恋が始まる', '00:30:00', '2023-01-01 00:00:00', 2500, 3),
(3, 2, '春の恋 第2話: 迷い', '主人公たちが恋に迷い始める', '00:30:00', '2023-01-08 00:00:00', 3000, 3),
(3, 3, '春の恋 第3話: 決意', '主人公たちが恋に向き合う決意をする', '00:30:00', '2023-01-15 00:00:00', 3500, 3);

-- 4-4. tv_schedulesテーブルにデータを挿入
INSERT INTO tv_schedules (channel_id, start_time, end_time, views, episode_id) VALUES 
(1, '2023-05-18 10:00:00', '2023-05-18 10:30:00', 750, 1), -- '夏の冒険 第1話: 新たな出発' 30分
(2, '2023-05-18 20:00:00', '2023-05-18 21:00:00', 1200, 4), -- '冬の料理ショー 第1話: ホットチョコレート' 1時間
(3, '2023-05-19 10:00:00', '2023-05-19 10:30:00', 980, 7), -- '春の恋 第1話: 出会い' 30分
(1, '2023-05-19 20:00:00', '2023-05-19 20:30:00', 550, 2), -- '夏の冒険 第2話: 初めての挑戦' 30分
(2, '2023-05-20 10:00:00', '2023-05-20 11:00:00', 1150, 5), -- '冬の料理ショー 第2話: チキンスープ' 1時間
(3, '2023-05-20 20:00:00', '2023-05-20 20:30:00', 1300, 8), -- '春の恋 第2話: 迷い' 30分
(1, '2023-05-21 10:00:00', '2023-05-21 10:30:00', 950, 3), -- '夏の冒険 第3話: 友情の証' 30分
(2, '2023-05-21 20:00:00', '2023-05-21 21:00:00', 1100, 6), -- '冬の料理ショー 第3話: スノーボールクッキー' 1時間
(3, '2023-05-22 10:00:00', '2023-05-22 10:30:00', 820, 7), -- '春の恋 第1話: 出会い' 30分
(1, '2023-05-22 20:00:00', '2023-05-22 20:30:00', 1000, 1), -- '夏の冒険 第1話: 新たな出発' 30分
(2, '2023-05-23 10:00:00', '2023-05-23 11:00:00', 500, 4), -- '冬の料理ショー 第1話: ホットチョコレート' 1時間
(3, '2023-05-23 20:00:00', '2023-05-23 20:30:00', 980, 9), -- '春の恋 第3話: 告白' 30分
(1, '2023-05-24 10:00:00', '2023-05-24 10:30:00', 980, 2), -- '夏の冒険 第2話: 初めての挑戦' 30分
(2, '2023-05-24 20:00:00', '2023-05-24 21:00:00', 900, 5), -- '冬の料理ショー 第2話: チキンスープ' 1時間
(1, '2023-05-25 12:00:00', '2023-05-25 12:30:00', 700, 3), -- '夏の冒険 第3話: 友情の証' 30分
(2, '2023-05-25 15:00:00', '2023-05-25 16:00:00', 480, 6), -- '冬の料理ショー 第3話: スノーボールクッキー' 1時間
(3, '2023-05-26 14:00:00', '2023-05-26 14:30:00', 600, 8), -- '春の恋 第2話: 迷い' 30分
(3, '2023-05-26 18:00:00', '2023-05-26 18:30:00', 580, 9); -- '春の恋 第3話: 告白' 30分

-- 4-5. genresテーブルにデータを挿入
INSERT INTO genres (name) VALUES ('冒険'), ('料理'), ('恋愛');

-- 4-6. program_genresテーブルにデータを挿入
INSERT INTO program_genres (program_id, genre_id) VALUES 
(1, 1),  -- 夏の冒険は冒険ジャンル
(2, 2),  -- 冬の料理ショーは料理ジャンル
(3, 3);  -- 春の恋は恋愛ジャンル

COMMIT;