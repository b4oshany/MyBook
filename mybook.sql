drop database mybook;
create database mybook;
use mybook;

/* Strong Entities */

/*
status : 
comment :

*/
/*
Define the users of the systems 
*/
create table users(
    user_id varchar(30) primary key, 
    is_active boolean default True not null, 
    password varchar(64),
    is_admin BOOLEAN default False not null
);

/*
status : 
comment :

*/
/*
Defines the post within the system
Each post as a title and a type
the type determines whether a post contains a picture, a text or both.
*/
create table post(
    post_id int primary key AUTO_INCREMENT,
    title varchar(65),
    post_type varchar(10)
);

/*
status : 
comment :

Defines the group post within the system */
create table group_post(
    gpost_id int primary key AUTO_INCREMENT,
    title varchar(65),
    gpost_type varchar(10)
);

/*
status : 
comment :

*/
/*
defines the comments within the system
*/
create table comments(
    comment_id int primary key AUTO_INCREMENT,
    content varchar(255)
);

/*
status : 
comment :

*/
/*
defines the groups within the sytem
*/
create table groups(
    group_id varchar(30) primary key,
    group_name varchar(65)
);


/*
definesthe photos that is stored in the system
NB. This was made an entity because each post or profile my utitlize a photo. In order for the reduction of redunancy, it is best each photo post or profile picture relationship to the photo via photo_id to get the actually photo url.
For instance. A user post a photo and another user post the same photo... although photo url is unique and is stored
create Photo(
    photo_id int primary key AUTO_INCREMENT,
    photo_url varchar(255),
    title varchar(65)
)
*/

/* Weak Entities */

/*
status : 
comment :

defines the group post which are text */
create table gposted_text(
    gpost_id int primary key,
    content varchar(255),
    foreign key(gpost_id) references group_post(gpost_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

defines the group post which are photo */
create table gposted_picture(
    gpost_id int primary key,
    picture_path varchar(255), 
    foreign key(gpost_id) references group_post(gpost_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

defines the post which are text */
create table posted_text(
    post_id int primary key,
    content varchar(255),
    foreign key(post_id) references post(post_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

defines the post which are photo */
create table posted_picture(
    post_id int primary key,
    picture_path varchar(255), 
    foreign key(post_id) references post(post_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

defines the user profile */
create table profile(
    user_id varchar(30) primary key, 
    first_name varchar(55),
    last_name varchar(55),
    email varchar(65),
    dob date,
    profile_pic varchar(255) default "static/img/user-3.png" not null,
    date_created timestamp default current_timestamp,
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

registration details for user */
create table registration_info(
    reg_id int primary key AUTO_INCREMENT,
    user_id varchar(30) not null unique,
    date_of_registration timestamp default CURRENT_TIMESTAMP,
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :

 relationship
*/
create table user_post(
    post_id int primary key,
    user_id varchar(30),
    date_created timestamp default current_timestamp,
    foreign key(post_id) references post(post_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
status : 
comment :

*/

create table commented_on(
    post_id int,
    comment_id int,
    primary key(post_id,comment_id),
    date_commented timestamp default current_timestamp,
    foreign key(post_id) references post(post_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(comment_id) references comments(comment_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
status : 
comment :

*/

create table user_comments(
    user_id varchar(30),
    comment_id int,
    primary key(user_id, comment_id),
    foreign key(comment_id) references commented_on(comment_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
status : change
comment : chage field names

*/

create table friend_of(
    user_id varchar(30),
    friend_id varchar(30),
    relation varchar(10),
    primary key(user_id,friend_id),
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(friend_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
status : change
comment :

*/

create table add_editors(
    group_id varchar(30),
    editor_id varchar(30),
    date_added timestamp default current_timestamp,
    primary key(group_id, editor_id),
    foreign key(editor_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(group_id) references groups(group_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : change
comment : change it from add_to_group -> add_member, change the data -> timestamp so that date will be recorded on insertion
*/
create table add_member(
    user_id varchar(30),
    group_id varchar(30),
    date_added timestamp default current_timestamp,
    primary key(user_id,group_id),
    foreign key(user_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(group_id) references groups(group_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
status : change
comment :

*/

create table group_creator(
    group_id varchar(30),
    owner_id varchar(30),
    date_commented timestamp default current_timestamp,
    primary key (group_id),
    foreign key (group_id) references groups(group_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(owner_id) references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
status : 
comment :
*/
create table create_content(
    group_id varchar(30),
    editor_id varchar(30),
    gpost_id int, 
    date_created timestamp default current_timestamp,
    primary key(editor_id, group_id, gpost_id),
    foreign key (group_id) references groups(group_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(gpost_id) references group_post(gpost_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(editor_id) references add_editors(editor_id) ON DELETE CASCADE ON UPDATE CASCADE
);






