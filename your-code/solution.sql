USE publications;

/* -- What I want to do?

To answer the question `Who Have Published What At Where?` in new single table. 

What kind of information do I need?

AUTHOR ID - the ID of the author 
LAST NAME - author last name 
FIRST NAME - author first name 
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published

Where I can find the corresponding tables and columns?
Tables:
- authors
- titleauthor
- titles
- publishes
*/

-- Challenge 1 - Who Have Published What At Where?
SELECT a.au_id,  a.au_lname, a.au_fname, t.title, p.pub_name  FROM authors as a
JOIN titleauthor as ta
ON a.au_id = ta.au_id
LEFT JOIN titles as t
ON t.title_id = ta.title_id
LEFT JOIN publishers as p
ON p.pub_id = t.pub_id;


-- Challenge 2 - Who Have Published How Many At Where?
SELECT a.au_id as 'AUTHOR ID',  a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', p.pub_name as 'PUBLISHER', count(t.title) as 'TITLE COUNT' FROM authors as a
JOIN titleauthor as ta
ON a.au_id = ta.au_id
LEFT JOIN titles as t
ON t.title_id = ta.title_id
LEFT JOIN publishers as p
ON p.pub_id = t.pub_id
GROUP BY a.au_id, p.pub_name
ORDER BY a.au_id desc;


-- Challenge 3 - Best Selling Authors  
SELECT a.au_id as 'AUTHOR ID',  a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', sum(s.qty) as 'TOTAL' FROM authors as a
INNER JOIN titleauthor as ta
ON a.au_id = ta.au_id
INNER JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) desc
LIMIT 3;


-- Challenge 4 - Best Selling Authors Ranking
SELECT a.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', IFNULL(sum(s.qty), 0) as 'TOTAL' FROM authors as a
LEFT JOIN titleauthor as ta
ON a.au_id = ta.au_id
LEFT JOIN sales as s
ON ta.title_id = s.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) desc;
