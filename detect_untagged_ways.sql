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

