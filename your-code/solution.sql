-- Challenge 1
-- I need AUTHOR ID, LAST NAME, FIRST NAME, TITLE and PUBLISHER
-- From table authors I need: au_id, au_lname and au_fname
-- From table titleauthor I need: au_id and title_id
-- From table titles: title_id, title and pub_id
-- From table publishers: pub_id and pub_name
--  The total rows should be the same as the total number of records in Table titleauthor.

use publications
select * from authors
select * from titleauthor

Select a.au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", t.title as "TITLE", p.pub_name as "PUBLISHER"
from authors as a
inner join titleauthor as ta
On a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join publishers as p
on t.pub_id = p.pub_id;

-- Challenge 2 Who Have Published How Many At Where?
-- Same List but with TITLE COUNT instead of TITLE.

Select a.au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", p.pub_name as "PUBLISHER", COUNT(t.title) as "TITLE COUNT"
from authors as a
inner join titleauthor as ta
On a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join publishers as p
on t.pub_id = p.pub_id
group by a.au_id, p.pub_name
order by a.au_id desc;

-- Challenge 3
-- From sales get qty through title_id

Select a.au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", t.ytd_sales as "TOTAL"
from authors as a
inner join titleauthor as ta
On a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
Group by t.title
order by t.ytd_sales desc
limit 3;

-- Challenge 4

Select a.au_id as "AUTHOR ID", au_lname as "LAST NAME", au_fname as "FIRST NAME", coalesce(t.ytd_sales, 0) as "TOTAL"
from authors as a
inner join titleauthor as ta
On a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
order by t.ytd_sales desc;