CREATE TABLE `BucketList`.`tbl_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(50) NULL,
  `user_username` VARCHAR(100) NULL,  -- Update the length to 100 characters
  `user_password` VARCHAR(100) NULL,  -- Update the length to 100 characters
  PRIMARY KEY (`user_id`)
);
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_name VARCHAR(50),
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(100)  -- Update the length to match the column in tbl_user table
)
BEGIN
    if (select exists (select 1 from tbl_user where user_username = p_username)) THEN
        select 'Username Exists !!';
    ELSE
        insert into tbl_user (
            user_name,
            user_username,
            user_password
        ) values (
            p_name,
            p_username,
            p_password
        );
    END IF;
END;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateLogin`(IN p_username VARCHAR(100))  -- Update the length to 100 characters to match the column in tbl_user table
BEGIN
    SELECT user_id, user_name, user_username, user_password  -- Return the user_id, user_name, user_username, and user_password columns
    FROM tbl_user
    WHERE user_username = p_username;
END;
CREATE TABLE `tbl_wish` (
  `wish_id` int(11) NOT NULL AUTO_INCREMENT,
  `wish_title` varchar(45) DEFAULT NULL,
  `wish_description` varchar(5000) DEFAULT NULL,
  `wish_user_id` int(11) DEFAULT NULL,
  `wish_date` datetime DEFAULT NULL,
  PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
CREATE DEFINER=root@localhost PROCEDURE sp_addWish(
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_user_id INT
)
BEGIN
    INSERT INTO tbl_wish (wish_title, wish_description, user_id, wish_date)
    VALUES (p_title, p_description, p_user_id, NOW());
END;
CREATE DEFINER=root@localhost PROCEDURE sp_GetWishByUser(
    IN p_user_id bigint)
BEGIN
    select * from tbl_wish where wish_user_id = p_user_id;
END;
