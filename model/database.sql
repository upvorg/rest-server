CREATE DATABASE IF NOT EXISTS `upv` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `upv`;

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cover` varchar(200) DEFAULT '',
  `title` varchar(60) NOT NULL,
  `content` text NOT NULL,
  `sort` varchar(10) NOT NULL COMMENT '番剧｜电影｜新番｜剧场版｜转载｜原创',
  `uid` int DEFAULT NULL,
  `tag` varchar(100) DEFAULT '',
  `status` TINYINT(1) DEFAULT 2 COMMENT '0=>删除 | 1=>下架 | 2=>待审核| 3=>正常',
  `create_time` timestamp DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(8) DEFAULT 'post' COMMENT 'post | video',
  `pv` int DEFAULT 0 COMMENT '浏览量', -- TODO: Redis 周榜｜月榜｜总榜
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- 视频描述表
DROP TABLE IF EXISTS `video_metas`;
CREATE TABLE `video_metas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `region` varchar(10) DEFAULT '美国｜日本｜中国',
  `is_end` TINYINT(1) DEFAULT 0 COMMENT '0=>未完结 | 1=>完结',
  `publish_date` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `update_time` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '每周几更新',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cover` varchar(200) DEFAULT '',
  `episode` int DEFAULT 0,
  `title` varchar(80) DEFAULT '',
  `content` varchar(2048) NOT NULL,
  `pid` int NOT NULL,
  `uid` int NOT NULL,
  `create_time` timestamp DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL UNIQUE,
  `nickname` varchar(16) DEFAULT '',
  `avatar` varchar(100) DEFAULT 'https://q1.qlogo.cn/g?b=qq&nk=7619376472&s=640',
  `pwd` varchar(100) NOT NULL,
  `qq` varchar(15) DEFAULT '',
  `bio` varchar(100) DEFAULT '这个人很酷，什么都没有留下',
  `level` TINYINT(1) NOT NULL DEFAULT 3,
  `status` TINYINT(1) DEFAULT 1 COMMENT '0=>删除 | 1=>正常',
  `create_time` timestamp DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


INSERT INTO
  `users`
VALUES
  (
    '1',
    'root',
    '我可是管理员!',
    'https://q1.qlogo.cn/g?b=qq&nk=7619376472&s=640',
    '99dbba184467cd7c2c7b5ace07a7102a',
    '88888888',
    '这个人很酷，没有签名',
    0,
    1,
    now(),
    now()
  );


DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `target_id` int DEFAULT 0,
  `content` varchar(200) NOT NULL,
  `pid` int NOT NULL,
  `vid` int DEFAULT 0,
  `color` varchar(10) DEFAULT '',
  `uid` int NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `collects`;
CREATE TABLE `collects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `pid` int NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `pid` int NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
