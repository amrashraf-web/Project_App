CREATE TABLE `tbl_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(200) NULL,
  `user_username` VARCHAR(200) NULL,
  `user_password` VARCHAR(200) NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `tbl_wish` (
  `wish_id` int(11) NOT NULL AUTO_INCREMENT,
  `wish_title` varchar(45) DEFAULT NULL,
  `wish_description` varchar(5000) DEFAULT NULL,
  `wish_user_id` int(11) DEFAULT NULL,
  `wish_date` datetime DEFAULT NULL,
  PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;


INSERT INTO tbl_user
VALUES
(10, 'ahmed', 'ahmed', 'ahmed');

CREATE PROCEDURE sp_createUser (
    IN p_name VARCHAR(200),
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(200)
)
BEGIN
    IF (SELECT EXISTS (SELECT 1 FROM tbl_user WHERE user_username = p_username)) THEN
        SELECT 'Username Exists !!';
    ELSE
        INSERT INTO tbl_user (user_name, user_username, user_password)
        VALUES (p_name, p_username, p_password);
    END IF;
END;

CREATE PROCEDURE sp_validateLogin (
    IN p_username VARCHAR(200)
)
BEGIN
    SELECT * FROM tbl_user WHERE user_username = p_username;
END;

DROP PROCEDURE IF EXISTS sp_addWish;

CREATE PROCEDURE sp_addWish (
    IN p_title varchar(45),
	IN p_description varchar(1000),
	IN p_user_id bigint
)
BEGIN
    INSERT INTO tbl_wish (wish_title, wish_description, wish_user_id, wish_date)
    VALUES (p_title, p_description, p_user_id, NOW());
END;


DROP PROCEDURE IF EXISTS sp_GetWishByUser;

CREATE PROCEDURE sp_GetWishByUser (
    IN p_user_id bigint
)
BEGIN
    SELECT * FROM tbl_wish WHERE wish_user_id = p_user_id;
END;
