use publications;

-- Challenge 1 - Who Have Published What At Where?

SELECT ta.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', t.title as 'TITLE', p.pub_name as 'PUBLISHER'
FROM titles AS t
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN authors AS a
ON ta.au_id = a.au_id;




-- Challenge 2 - Who Have Published How Many At Where?

SELECT ta.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, p.pub_name as `PUBLISHER`, count(*) as `TITLE COUNT`
FROM titles AS t
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN authors AS a
ON ta.au_id = a.au_id
group by `AUTHOR ID`,`PUBLISHER`;






-- Challenge 3 - Best Selling Authors

SELECT a.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, sum(s.qty) as `TOTAL`
FROM titleauthor AS ta
INNER JOIN titles AS t
ON ta.title_id = t.title_id
INNER JOIN authors AS a
ON ta.au_id = a.au_id
INNER JOIN sales AS s
ON t.title_id = s.title_id
group by `AUTHOR ID`
order by `TOTAL` desc
limit 3;




-- Challenge 4 - Best Selling Authors Ranking

SELECT a.au_id as `AUTHOR ID`, a.au_lname as `LAST NAME`, a.au_fname as `FIRST NAME`, ifnull(sum(s.qty),0) as `TOTAL`
FROM authors AS a
LEFT JOIN titleauthor AS ta
ON a.au_id = ta.au_id
LEFT JOIN titles AS t
ON t.title_id = ta.title_id
LEFT JOIN sales AS s
ON t.title_id = s.title_id
group by `AUTHOR ID`
order by `TOTAL` desc;





