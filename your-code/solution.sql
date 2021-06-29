Use publications;

#Challenge 1 - Who Have Published What At Where?

Select author_id, last_name, first_name, title, pub_name from (
Select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, b.title_id, c.title as title, c.pub_id, d.pub_name as pub_name 
from authors a, titleauthor b, titles c, publishers d
where a.au_id = b.au_id and b.title_id = c.title_id and c.pub_id = d.pub_id ) as sub
group by author_id, title, pub_name
order by author_id asc;


#Challenge 2 - Who Have Published How Many At Where?

Select author_id, last_name, first_name, pub_name, count(title) as title_count from (
Select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, b.title_id, c.title as title, c.pub_id, d.pub_name as pub_name 
from authors a, titleauthor b, titles c, publishers d
where a.au_id = b.au_id and b.title_id = c.title_id and c.pub_id = d.pub_id
group by author_id, title, pub_name ) as sub
group by author_id, pub_name
order by title_count desc


#check results
Select sum(title_count) from
(Select author_id, last_name, first_name, pub_name, count(title) as title_count from (
Select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, b.title_id, c.title as title, c.pub_id, d.pub_name as pub_name 
from authors a, titleauthor b, titles c, publishers d
where a.au_id = b.au_id and b.title_id = c.title_id and c.pub_id = d.pub_id
group by author_id, title, pub_name ) as sub
group by author_id, pub_name
order by title_count desc) as sub2;

#25 same number

# Challenge 3 - Best Selling Authors
Select author_id, last_name, first_name, sum(qty) as total from
(Select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, b.title_id, c.qty as qty
from authors a, titleauthor b, sales c
where a.au_id = b.au_id and b.title_id = c.title_id) as sub
group by author_id
order by total desc
limit 3; 

#Challenge 4 - Best Selling Authors Ranking

Select author_id, last_name, first_name,  sum(qty) as total from
(Select a.au_id as author_id, a.au_lname as last_name, a.au_fname as first_name, b.title_id, c.qty as qty
from authors a
LEFT Join  titleauthor b ON a.au_id = b.au_id
LEFT JOIN sales c ON b.title_id = c.title_id 
) as sub
group by author_id
order by total desc;

#isnull function not working in my console

