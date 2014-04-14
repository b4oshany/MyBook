DROP PROCEDURE IF EXISTS addUser;
DELIMITER ??
CREATE PROCEDURE addUser(in userid varchar(30), in user_password varchar(25), in first_name varchar(25), in last_name varchar(25), in user_email varchar(55), in user_dob date )
BEGIN
insert into users(user_id, password) values(userid, md5(user_password));
insert into profile(user_id, first_name, last_name, dob, email) values(userid, first_name, last_name, user_dob, user_email);
insert into registration_info(user_id) values(userid); /* could a used a trigger but, its better this way, i think */
END ??
DELIMITER ;

DROP PROCEDURE IF EXISTS addPost;
DELIMITER ??
CREATE PROCEDURE addPost(in userid varchar(30), in post_title varchar(65),  in postype varchar(10), in message varchar(255), in photo_url varchar(255))
BEGIN
DECLARE ipid int;
insert into post(title, post_type) values(post_title, postype);
SET ipid = (select LAST_INSERT_ID());
insert into user_post(user_id, post_id) values(userid, ipid);
IF postype = "text" THEN
insert into posted_text(post_id,content) values(ipid, message);
ELSEIF postype = "photo" THEN
insert into post_picture(post_id, picture_url) values(ipid, photo_url);
ELSE
insert into post_picture(post_id, picture_url) values(ipid, photo_url);
insert into posted_text(post_id,content) values(post_id, message);
END IF;
END ??
DELIMITER ;

DROP PROCEDURE IF EXISTS addGroupPost;
DELIMITER ??
CREATE PROCEDURE addGroupPost(in groupid varchar(30), in editorid varchar(30), in post_title varchar(65),  in postype varchar(10), in message varchar(255), in photo_url varchar(255))
BEGIN
DECLARE ipid int;
insert into group_post(title, gpost_type) values(post_title, postype);
SET ipid = (select LAST_INSERT_ID());
insert into create_content(group_id, editor_id, gpost_id) values(groupid, editorid, ipid);
IF postype = "text" THEN
insert into gposted_text(gpost_id,content) values(ipid, message);
ELSEIF postype = "photo" THEN
insert into gpost_picture(gpost_id, picture_url) values(ipid, photo_url);
ELSE
insert into gpost_picture(post_id, picture_url) values(ipid, photo_url);
insert into gposted_text(post_id,content) values(ipid, message);
END IF;
END ??
DELIMITER ;

DROP PROCEDURE IF EXISTS addComment;
DELIMITER ??
CREATE PROCEDURE addComment(in userid varchar(30), in postid int, in message varchar(255))
BEGIN
DECLARE icid int;
insert into comments(content) values(message);
SET icid = (select LAST_INSERT_ID());
insert into commented_on(post_id, comment_id) values(postid, icid);
insert into user_comments(user_id, comment_id) values(userid, icid);
END ??
DELIMITER ;

DROP TRIGGER IF EXISTS setRegistrationInfo;
Delimiter $$
CREATE TRIGGER setRegistrationInfo
AFTER insert ON profile
FOR EACH ROW
BEGIN
insert into registration_info(user_id) values (new.user_id);
END $$
delimiter ;
