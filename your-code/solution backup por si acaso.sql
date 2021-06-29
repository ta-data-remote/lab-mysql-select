USE publications;

-- Challenge 1 - Who Have Published What At Where?

-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TITLE - name of the published title
-- PUBLISHER - name of the publisher where the title was published
SELECT * FROM authors;
SELECT * FROM titleauthor;
SELECT * FROM titles;

SELECT a.au_id, a.au_lname, a.au_fname, t.title_id, p.pub_name, tit.title
FROM authors as a
INNER JOIN titleauthor as t
ON a.au_id = t.au_id
LEFT JOIN titles as tit
ON t.title_id = tit.title_id
LEFT JOIN publishers as p
ON tit.pub_id = p.pub_id;


-- Challenge 2 - Who Have Published How Many At Where?
-- Create a COUNT for title by  author id NEXT TO publisher
SELECT a.au_id AS 'AUTHOR ID', a.au_lname AS 'LAST NAME', a.au_fname AS 'FIRST NAME', p.pub_name AS 'PUBLISHER', COUNT(tit.title) AS 'TITLE COUNT'
FROM authors as a
INNER JOIN titleauthor as t
ON a.au_id = t.au_id
LEFT JOIN titles as tit
ON t.title_id = tit.title_id
LEFT JOIN publishers as p
ON tit.pub_id = p.pub_id
GROUP BY a.au_id, p.pub_name
ORDER BY a.au_id DESC;

-- Challenge 3 - Best Selling Authors


-- columns:
-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TOTAL - total number of titles sold from this author
-- Your output should be ordered based on TOTAL from high to low.
-- Only output the top 3 best selling authors.

SELECT ytd_sales FROM titles;

SELECT a.au_id, a.au_lname, a.au_fname, tit.title, ytd_sales
FROM authors as a
INNER JOIN titleauthor as t
ON a.au_id = t.au_id
LEFT JOIN titles as tit
ON t.title_id = tit.title_id
GROUP BY tit.title
ORDER BY ytd_sales DESC
LIMIT 3;


-- Challenge 4 - Best Selling Authors Ranking


SELECT a.au_id, a.au_lname, a.au_fname, tit.title, coalesce(ytd_sales, 0)
FROM authors as a
INNER JOIN titleauthor as t
ON a.au_id = t.au_id
LEFT JOIN titles as tit
ON t.title_id = tit.title_id
ORDER BY ytd_sales DESC;



