CREATE TABLE `BucketList`.`tbl_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(50) NULL,
  `user_username` VARCHAR(100) NULL,  -- Update the length to 100 characters
  `user_password` VARCHAR(100) NULL,  -- Update the length to 100 characters
  PRIMARY KEY (`user_id`)
);
