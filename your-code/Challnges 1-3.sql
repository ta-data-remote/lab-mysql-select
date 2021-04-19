USE publications;

-- Challenge 1
SELECT a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name 
FROM titles AS t
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN authors AS a
ON a.au_id = ta.au_id;

-- Challenge 2
SELECT ta.au_id, a.au_lname, a.au_fname, p.pub_name, count(*) as title_count
FROM titles AS t
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN authors AS a
ON a.au_id = ta.au_id
GROUP BY ta.au_id, p.pub_name
ORDER BY ta.au_id;

/*
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SELECT a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name, count(a.au_lname)
FROM titles AS t
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN publishers AS
ON t.pub_id = p.pub_id
INNER JOIN authors AS a
ON a.au_id = ta.au_id
GROUP BY a.au_lname, p.pub_name;
*/

-- Challenge 3
SELECT a.au_id, a.au_lname, a.au_fname, sum(s.qty) as title_total
FROM authors AS a
INNER JOIN titleauthor AS ta
ON ta.au_id = a.au_id
INNER JOIN titles AS t
ON t.title_id = ta.title_id
INNER JOIN sales AS s
ON s.title_id = a.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) DESC
LIMIT 3;

-- Challenge 4
SELECT a.au_id, a.au_lname, a.au_fname, ifnull(sum(s.qty),0) as title_total
FROM authors AS a
LEFT JOIN titleauthor AS ta
ON ta.au_id = a.au_id
LEFT JOIN titles AS t
ON t.title_id = ta.title_id
LEFT JOIN sales AS s
ON s.title_id = t.title_id
GROUP BY a.au_id
ORDER BY sum(s.qty) DESC
LIMIT 23;