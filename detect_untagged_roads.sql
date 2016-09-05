-- create the table with all empty ways
create table no_tags as 
select * from ways WHERE tags = ''; 

-- select just the closed ways
create table unclosed_no_tags as 
select * from no_tags 
WHERE ST_IsClosed(linestring)='f';

-- delete ways that are part of a relation
delete from unclosed_no_tags
where id in ( 
select id from unclosed_no_tags 
inner join relation_members 
on unclosed_no_tags.id = relation_members.member_id);

-- delete looong ways
create table unclosed_no_tags_length as
(
select * from unclosed_no_tags 
where id in (
select id from unclosed_no_tags 
where ST_Length(ST_Transform(linestring,3857))<5000
)
);

-- keep only ways that intersect highways
delete from unclosed_no_tags_length 
where id not in 
(SELECT a.id FROM
   unclosed_no_tags_length as a,
   (select * from ways where
   tags ?'highway'=true) as b
WHERE
    ST_Touches(a.linestring, b.linestring)
    AND a.id != b.id
);

