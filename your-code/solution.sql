use publications;

-- Challenge 1
SELECT ta.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', t.title as 'TITLE', p.pub_name as 'PUBLISHER'
FROM titles AS t
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN authors AS a
ON ta.au_id = a.au_id;

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


SELECT a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name, count(a.au_lname)
FROM titles AS t
INNER JOIN titleauthor AS ta
ON t.title_id = ta.title_id
INNER JOIN publishers AS p
ON t.pub_id = p.pub_id
INNER JOIN authors AS a
ON a.au_id = ta.au_id
GROUP BY a.au_lname, p.pub_name;

-- Challenge 3
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


-- Challenge 4
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

