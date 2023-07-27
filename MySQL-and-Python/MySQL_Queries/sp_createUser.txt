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
