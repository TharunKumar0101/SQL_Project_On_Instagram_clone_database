# Project on IG_Clone Dataset
use ig_clone;
# 1) -- Create an ER diagram or draw a schema for the given database.

-- Need to go through the revers engineer option from data base settings 
-- to connect to the DBMS and need to select the required Database schema to get 
-- the ER diagram of that database.

#------------------------------------------------------------------------
# 2) We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users order by created_at limit 5;

#------------------------------------------------------------------------------
# 3) To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from users u left join photos p on u.id = p.user_id where p.id is null;

#-------------------------------------------------------------------------------------
# 4) -- Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select photos.user_id,users.username,likes.photo_id,count(*) as count from photos join likes
 on photos.id = likes.photo_id join users on users.id=photos.user_id
 group by likes.photo_id order by count desc limit 1;
 
#---------------------------------------------------------------------------------------------- 
 # 5) -- The investors want to know how many times does the average user post.
select  round(
(select count(*)from photos)/(select count(*) from users) 
) as AVG_User_Post;

#--------------------------------------------------------------------------------------------------
# 6)-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select photo_tags.tag_id,tags.tag_name,count(*) as tag_count from photo_tags join tags on photo_tags.tag_id=tags.id
 group by tag_id order by tag_count desc limit 5;
# Below are the top 5 hashtags used by the users.Hence the brand can choose the top hashtag are any of the top 5.

#----------------------------------------------------------------------------------------------
# 7) -- To find out if there are bots, find users who have liked every single photo on the site.
SELECT COUNT(*) as Total_Posts FROM photos;
select likes.user_id,users.username,count(*) as likes_count from likes join users on users.id=likes.user_id group by
 user_id having likes_count=257;
 
select likes.user_id,users.username,count(*) as likes_count from likes join users on users.id=likes.user_id group by
 user_id having likes_count=(SELECT COUNT(*) as Total_Posts FROM photos);
 #---------------------------------------------------------------------------------------------
#8) -- Find the users who have created instagramid in may and select top 5 newest joinees from it?
select * from users order by created_at Desc;
select * from users  where month(created_at) =5 order by created_at Desc;
select * from users where created_at <=(select max(created_at) from users) order by created_at Desc;
select * from users where created_at <=(select created_at from users where created_at like "2017-05-%") order by created_at Desc limit 5;
#--------------------------------------------------------------------------------------------
#9)-- Can you help me find the users whose name starts with c and ends with any number
--  and have posted the photos as well as liked the photos?
select id, username from users where id in 
(select Distinct user_id  as id from photos where user_id in (select Distinct user_id from likes))
 and username like "c%";
 
 select id, username from users where id in 
(select Distinct user_id  as id from photos where user_id in (select Distinct user_id from likes))
 and username regexp "^c";

 #--------------------------------------------------------------------------------------------
 #10)-- Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select photos.user_id, users.username,count(*) as Post_count from photos join users 
on photos.user_id=users.id  group by user_id having Post_count 
between 3 and 5 order by Post_count Desc limit 30;
