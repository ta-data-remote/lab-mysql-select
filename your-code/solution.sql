-- Challenge 1 - Who Have Published What At Where? https://github.com/ta-data-remote/lab-mysql-select
	-- AUTHOR ID - the ID of the author
	-- LAST NAME - author last name
	-- FIRST NAME - author first name
	-- TITLE - name of the published title
	-- PUBLISHER - name of the publisher where the title was published

USE publications;

-- select a.au_id, a.au_lname, a.au_fname from authors as a;
-- select ta.au_id, ta.title_id from titleauthor as ta;
-- select t.title_id, t.title from titles as t;
-- select p.pub_id, p.pub_name, p.city from publishers as p;

SELECT  a. au_id, a.au_lname, a.au_fname, c.title, d.pub_name FROM authors AS a
JOIN titleauthor AS b
ON a.au_id = b.au_id
JOIN titles AS c
ON b.title_id = c.title_id
JOIN publishers AS d
ON c.pub_id = d.pub_id;

-- Challenge 2 - Who Have Published How Many At Where?
SELECT  a.au_id, a.au_lname AS "Last name", a.au_fname AS "First name", c.title, d.pub_name AS "Publisher" FROM authors AS a
JOIN titleauthor AS b
ON a.au_id = b.au_id
JOIN titles AS c
ON b.title_id = c.title_id
JOIN publishers AS d
ON c.pub_id = d.pub_id
GROUP BY au_id, pub_name;

-- Challenge 3 - Best Selling Authors

SELECT a.au_id AS "Author ID", au_lname AS "Last name", au_fname AS "First name", t.ytd_sales AS "Total"
FROM authors AS a
INNER JOIN titleauthor AS ta
ON a.au_id = ta.au_id
INNER JOIN titles AS t
ON ta.title_id = t.title_id
GROUP BY t.title
ORDER BY t.ytd_sales DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking

SELECT a.au_id AS "Author ID", au_lname AS "Last name", au_fname AS "First name", coalesce(t.ytd_sales, 0) AS "Total"
FROM authors AS a
INNER JOIN titleauthor AS ta
ON a.au_id = ta.au_id
INNER JOIN titles AS t
ON ta.title_id = t.title_id
ORDER BY t.ytd_sales DESC;