-- Challenge 1 - Who Have Published What At Where?
/*
In this challenge you will write a MySQL SELECT query that joins various tables 
to figure out what titles each author has published at which publishers. 
Your output should have at least the following columns:
-- AUTHOR ID - the ID of the author
-- LAST NAME - author last name
-- FIRST NAME - author first name
-- TITLE - name of the published title
-- PUBLISHER - name of the publisher where the title was published
*/

USE publications;

-- use the following commands to have an overview in every required tables
SELECT * FROM authors;
SELECT * FROM titles;
SELECT * FROM publishers;
SELECT * FROM titleauthor;

-- First inner join authors and titleauthor on au_id
-- Then inner join title
-- join titels and publishers on pub_id
-- Table title : title, title_id,pub_id
-- Table publishers: publishers-pub_name, pub_id
-- common column : pub_id
-- table titleauthors : au_id, title_id
-- table authors: au_id, au_lname, au_fname
-- common column : au_id

SELECT a.au_id AS 'AUTHOR ID', 
a.au_lname AS 'LAST NAME',
a.au_fname AS 'FIRST NAME',
t.title as 'TITEL', p.pub_name as 'PUBLISHER'
FROM authors a
JOIN titleauthor ta
ON a.au_id = ta.au_id
JOIN titles t
ON ta.title_id = t.title_id
JOIN publishers p
ON t.pub_id = p.pub_id;

/*
Challenge 2 - Who Have Published How Many At Where?
Elevating from your solution in Challenge 1, query how many titles each 
author has published at each publisher. Your output should look something like below:
*/

SELECT a.au_id AS 'AUTHOR ID', 
a.au_lname AS 'LAST NAME',
a.au_fname AS 'FIRST NAME',
p.pub_name as 'PUBLISHER',
count(t.title) as 'TITEL COUNT'
FROM authors a
JOIN titleauthor ta
ON a.au_id = ta.au_id
JOIN titles t
ON ta.title_id = t.title_id
JOIN publishers p
ON t.pub_id = p.pub_id
group by a.au_id, p.pub_name  # VERY IMPORTANT TO KNOW WHICH COL TO CALL HERE!
ORDER BY count(t.title) desc;

/*
Challenge 3 - Best Selling Authors
Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

Requirements:

Your output should have the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TOTAL - total number of titles sold from this author
Your output should be ordered based on TOTAL from high to low.
Only output the top 3 best selling authors.
*/

-- table author: au_id, au_lname, au_fname
-- table titleauthor : au_id, title_id
-- table sales: stor_id, title_id, qty
-- table titles : title_id, pub_id
-- table publsher: pub_id
SELECT a.au_id AS 'AUTHOR ID', 
a.au_lname AS 'LAST NAME',
a.au_fname AS `FIRST NAME`,
sum(s.qty) as `TOTAL`  -- use this special quotes for alias!!!!
FROM authors a 
JOIN titleauthor ta
ON a.au_id = ta.au_id
JOIN titles t
ON t.title_id = ta.title_id
JOIN sales s
ON s.title_id = t.title_id
GROUP BY a.au_id
ORDER BY `TOTAL` DESC
limit 3;

/*
Challenge 4 - Best Selling Authors Ranking
Now modify your solution in Challenge 3 so that the output will display 
all 23 authors instead of the top 3. Note that the authors who have sold 0 
titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
Also order your results based on TOTAL from high to low.
*/

SELECT a.au_id AS 'AUTHOR ID', 
a.au_lname AS 'LAST NAME',
a.au_fname AS `FIRST NAME`,
IFNULL(sum(s.qty), 0) AS TOTAL -- use this special quotes `` for alias!!!!
FROM authors a 
LEFT JOIN titleauthor ta
ON a.au_id = ta.au_id
LEFT JOIN titles t
ON t.title_id = ta.title_id
LEFT JOIN sales s
ON s.title_id = t.title_id
GROUP BY a.au_id
ORDER BY TOTAL DESC;







