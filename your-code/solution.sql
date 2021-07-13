use publications;
-- Challenge 1
select  a. au_id, a.au_lname, a.au_fname, c.title, d.pub_name from authors as a
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
join publishers as d
on c.pub_id = d.pub_id;

-- challenge 2

select  a. au_id, a.au_lname, a.au_fname, count(c.title) as title_count, d.pub_name from authors as a
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
join publishers as d
on c.pub_id = d.pub_id
group by au_id,pub_name;


SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));



-- Challenge 3


select  a. au_id, a.au_lname, a.au_fname, c.ytd_sales as TOTAL from authors as a
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
group by au_id
Order by TOTAL desc
Limit 0,3;


-- challenge 4
select  a. au_id, a.au_lname, a.au_fname, coalesce(c.ytd_sales,0) as TOTAL from authors as a
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
Order by c.ytd_sales desc;
