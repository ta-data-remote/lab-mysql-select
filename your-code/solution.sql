USE publications;

-- Challenge 1

SELECT a.au_id, a.au_lname, a.au_fname, t2.title, p.pub_name
FROM authors a
INNER JOIN titleauthor t
ON a.au_id = t.au_id
INNER JOIN titles t2
ON t.title_id = t2.title_id
INNER JOIN publishers p 
ON t2.pub_id = p.pub_id;

-- Challenge 2

SELECT 
a.au_id, 
a.au_lname, 
a.au_fname, 
t2.title, 
p.pub_name, 
COUNT(*) as title_count
FROM authors a
INNER JOIN titleauthor t
ON a.au_id = t.au_id
INNER JOIN titles t2
ON t.title_id = t2.title_id
INNER JOIN publishers p 
ON t2.pub_id = p.pub_id
GROUP BY a.au_id, p.pub_id
ORDER BY au_lname;

-- Challenge 3

SELECT a.au_id, a.au_lname, a.au_fname, COUNT(*) as TOTAL
FROM authors a
INNER JOIN titleauthor t
ON a.au_id = t.au_id
GROUP BY(t.au_id)
ORDER BY TOTAL DESC
LIMIT 3;

-- Challenge 4

SELECT a.au_id, a.au_lname, a.au_fname, IFNULL(t.title_id, 0),
COUNT(t.title_id) as total
FROM authors a
LEFT JOIN titleauthor t
ON a.au_id = t.au_id
GROUP BY(au_id)
ORDER BY total desc;
