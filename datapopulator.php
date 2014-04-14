<?php
require('LoremIpsum.class.php');
$generator = new LoremIpsumGenerator();
//echo $generator->getContent(100, 'plain');
$users = array('b4oshany', 'britts', 'msheather','manboy', 'theteach', 'tatsoo','wowslide',
'kimmie2string','shany','shottas','buckhead','ballhead','spotters','champ','chimp','swinken'
);

$num_user = count($users);
$user_insert = "
insert into users(user_id, password, is_admin) values ('b4oshany', md5('oshany1991'), 1);
insert into users(user_id, password, is_admin) values ('msheather', md5('reecescookies'), 1);
insert into users(user_id, password, is_admin) values ('manboy', md5('aldin92'), 1);
insert into users(user_id, password, is_admin) values ('theteach', md5('kevin123'), 1);
insert into users(user_id, password, is_admin) values ('britts', md5('brittaney'), 1);
";

for($i = 5; $i < $num_user; $i++){
    $user_insert .= "insert into users(user_id, password, is_active) values ('".$users[$i]."', md5('tester".$i."'), ".(($i%2==0)? 0:1).");";
};

echo "<br/><br/>#user<br/>";
echo $user_insert;

$user_profile = "
insert into profile(user_id, first_name, last_name, email, dob) values('msheather', 'Heather', 'Recee', 'recees@gmail', '1990/07/15');
insert into profile(user_id, first_name, last_name, email, dob) values('b4oshany', 'Oshane', 'Bailey', 'b4.oshany@gmail', '1991/09/30');
insert into profile(user_id, first_name, last_name, email, dob) values('manboy', 'Aldin', 'Crossdale', 'the.manboy@gmail', '1991/02/07');
insert into profile(user_id, first_name, last_name, email, dob) values('britts', 'Brittaney', 'Bailey', 'britts40@gmail', '1993/02/10');
insert into profile(user_id, first_name, last_name, email, dob) values('theteach', 'Kevin', 'Miller', 'b4.oshany@gmail', '1982/11/09');
";

for($i = 5; $i < $num_user; $i++){
    $user_profile .= "
insert into profile(user_id, first_name, last_name, email, dob) values('".$users[$i]."', '".$generator->getContent(1, 'plain', false)."', '".$generator->getContent(1, 'plain', false)."', '".$generator->getContent(1, 'plain', false)."@gmail', '".rand(1985, 2004)."/".rand(1,12)."/".rand(1,28)."');
";
};

echo "<br/><br/>#profile<br/>";
echo $user_profile;

$relation = array("school", "work", "relatives");
$friends = "";
foreach($users as $user){
    for($i = rand(0, ($num_user-1)); $i < rand(0, ($num_user-1)); $i++){
        if($user != $users[$i]){
        $friends .= "
        insert into friend_of(user_id, friend_id, relation) values('".$user."','".$users[$i]."','".$relation[rand(0,2)]."');
        ";
        }
    }
}

echo "<br/><br/>#friends<br/>";
echo $friends;

$post = "";
foreach($users as $user){
    for($i = 0; $i < 10; $i++){
        $post .= "call addPost('".$user."', '".$generator->getContent(10, 'plain', false)."', 'text', '".$generator->getContent(30, 'plain', false)."', '');
        ";
    }
}

echo "<br/><br/>#post<br/>";
echo $post;

$comments = "";
for($i = 0; $i < 8; $i++){
    for($a = 0; $a < rand(2, $num_user); $a++){
    $comments .= "call addComment('".$users[rand(0,($num_user - 1))]."', ".rand(1,8).", '".$generator->getContent(10, 'plain', false)."');";
    }
}

echo "<br/><br/>#Comments<br/>";
echo $comments;


$groups = "";
$editors = "";
$members = "";
$gpost = "";
$existing_groups = array();
 for($i = 0; $i < rand(0, ($num_user-1)); $i++){
    $groupname = $generator->getContent(4, 'plain', false);
    $groupid = $generator->getContent(1, 'plain', false);
     if(!array_key_exists($groupid, $existing_group)){
        $groups .= "
            insert into groups(group_id, group_name) values('".$groupid."', '".$groupname."');
    insert into group_creator(group_id, owner_id) values('".$groupid."', '".$users[$i]."');
        ";
        for($u = 0; $u < rand(5, ($num_user-1)); $u++){
            if($users[$u] != $users[$i] && $u%(rand(2,4))){
            $editors .= "
                insert into add_editors(group_id, editor_id) values('".$groupid."','".$users[$u]."');
            ";
            $gpost .= "call addGroupPost('".$groupid."','".$users[$u]."', '".$generator->getContent(10, 'plain', false)."', 'text', '".$generator->getContent(30, 'plain', false)."', '');
            ";            
            $members .= "
                insert into add_member(user_id, group_id) values('".$users[$u]."','".$groupid."');
            ";
            }
        }
     }
     
}

echo "<br/><br/>#group<br/>";
echo $groups;
echo "<br/><br/>#Editors<br/>";
echo $editors;
echo "<br/><br/>#Members<br/>";
echo $members;
echo "<br/><br/>#group post<br/>";
echo $gpost;

$data = $user_insert.$user_profile.$friends.$post.$comments.$groups.$editors.$members.$gpost;

echo "<br/><br/>#user perm<br/>";
echo getcwd();
echo "<br/><br/>#put data<br/>";
echo file_put_contents("populator.sql", $data, LOCK_EX);



?>