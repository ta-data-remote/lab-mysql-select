-- Challenge 1 - Who Have Published What At Where?

select * from authors;
-- authors: au_lname, au_fname, au_id

select * from titleauthor;
-- titleauthor: au_id, title_id

select * from titles;
-- titles: title_id, pub_id

select * from publishers;
-- publishers: pub_id, pub_name


select a.au_id, a.au_lname, a.au_fname, t.title, pub.pub_name
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join publishers as pub
		on t.pub_id = pub.pub_id
order by a.au_lname;
 
 /* 
 Check if right: If your query is correct, the total rows in your output should be the same as the total number of records in Table titleauthor.
 */
select count(au_id) from titleauthor;
-- There are 25 lines in titleauthors

select count(a.au_id), a.au_lname, a.au_fname, t.title, pub.pub_name
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join publishers as pub
		on t.pub_id = pub.pub_id;
        
-- This table also has 25 lines.



-- Challenge 2 - Who Have Published How Many At Where?

select a.au_id, a.au_lname, a.au_fname, pub.pub_name, count(title) as title_nr
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join publishers as pub
		on t.pub_id = pub.pub_id
group by a.au_lname
order by title_nr desc;


/* 
 Check if right: To check if your output is correct, sum up the TITLE COUNT column. 
 The sum number should be the same as the total number of records in Table titleauthor.
 */


select count(title) as title_nr
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join publishers as pub
		on t.pub_id = pub.pub_id;
-- The number of titles is 25

select count(au_id) from titleauthor;
-- There are 25 lines in titleauthors


-- Challenge 3 - Best Selling Authors


select * from sales;
-- title_id, qty = quantity

select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as sales
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join sales as s
		on t.title_id = s.title_id
group by a.au_fname
order by sales desc
limit 3;


-- Challenge 4 - Best Selling Authors Ranking

-- IMPORTANT: DOES NOT SHOW NULLS
select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as sales
from authors as a
	inner join titleauthor as t_au
		on a.au_id = t_au.au_id
	inner join titles as t
		on t_au.title_id = t.title_id
	inner join sales as s
		on t.title_id = s.title_id
group by a.au_fname
order by sales desc;

