-- Create the tbl_user table
CREATE TABLE `BucketList`.`tbl_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(200) NULL,
  `user_username` VARCHAR(200) NULL,
  `user_password` VARCHAR(200) NULL,
  PRIMARY KEY (`user_id`)
);

-- Create the sp_createUser stored procedure
DELIMITER $$
CREATE PROCEDURE `sp_createUser`(
    IN p_name VARCHAR(200),
    IN p_username VARCHAR(200),
    IN p_password VARCHAR(200)
)
BEGIN
    IF (SELECT EXISTS (SELECT 1 FROM tbl_user WHERE user_username = p_username)) THEN
        SELECT 'Username Exists !!';
    ELSE
        INSERT INTO tbl_user (user_name, user_username, user_password)
        VALUES (p_name, p_username, p_password);
    END IF;
END$$
DELIMITER ;

-- Create the sp_validateLogin stored procedure
DELIMITER $$
CREATE PROCEDURE `sp_validateLogin`(
    IN p_username VARCHAR(200)
)
BEGIN
    SELECT * FROM tbl_user WHERE user_username = p_username;
END$$
DELIMITER ;

-- Create the tbl_wish table
CREATE TABLE `BucketList`.`tbl_wish` (
  `wish_id` INT(11) NOT NULL AUTO_INCREMENT,
  `wish_title` VARCHAR(45) DEFAULT NULL,
  `wish_description` VARCHAR(5000) DEFAULT NULL,
  `wish_user_id` INT(11) DEFAULT NULL,
  `wish_date` DATETIME DEFAULT NULL,
  PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Create the sp_addWish stored procedure
DELIMITER $$
CREATE PROCEDURE `sp_addWish`(
    IN p_title VARCHAR(45),
    IN p_description VARCHAR(1000),
    IN p_user_id BIGINT
)
BEGIN
    INSERT INTO tbl_wish (wish_title, wish_description, wish_user_id)
    VALUES (p_title, p_description, p_user_id);
END$$
DELIMITER ;

-- Create the sp_GetWishByUser stored procedure
DELIMITER $$
CREATE PROCEDURE `sp_GetWishByUser` (
    IN p_user_id BIGINT
)
BEGIN
    SELECT * FROM tbl_wish WHERE wish_user_id = p_user_id;
END$$
DELIMITER ;
