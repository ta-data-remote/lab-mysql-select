-- We use the Publications data base

USE publications;


-- Challenge 1 - Who Have Published What At Where?
/*
In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has published at which publishers. 
Your output should have at least the following columns:

AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published

If your query is correct, the total rows in your output should be the same as the total number of records in Table titleauthor
*/
-- Figure out what titles each author has published at which publishers
-- 1. I need information about titles, author, publishers.
-- 2. I look at the ERD to see which tables I need and how are they related and which variables they have of our interest
--  a)Tables titles: title, title_id, pub_id
--  b)Table authors: au_id, au_fname, au_lname
--  c) Table publishers: pub_name, pub_id
--  d) Table titleauthor: au_id, title_id
--    I had to select another table to have common columns for all the tables where I am retrieving the information
--    Let's inspect those tables:

SELECT * FROM authors;
SELECT * FROM titles;
SELECT * FROM publishers;
SELECT * FROM titleauthor;


-- 3. As what I am intrested in are the titles x author, the tables that commands in the author table.
-- The relation between the tables are the following:
--  authors-titleauthor (au_id)
--  titleauthor-titles (title_id)
--  titles-publishers (pub_id)

--   My left table would be the authors

SELECT a.au_id as "AuthorID",a.au_lname as "Last_name", a.au_fname as "First_name", p.pub_name as "Publisher",t.title as "Title" FROM authors as a

INNER JOIN titleauthor as ta
ON a.au_id = ta.au_id 

LEFT JOIN titles as t
ON ta.title_id = t.title_id

LEFT JOIN publishers as p
ON t.pub_id = p.pub_id;

-- The second one

-- It has 25 rows that meand I shoudl change one of the joins to inner.
 


-- Challenge 2 - Who Have Published How Many At Where?

/*
Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher.

To check if your output is correct, sum up the TITLE COUNT column. The sum number should be the same as the total number of records in Table titleauthor.
Hint: In order to count the number of titles published by an author, you need to use MySQL COUNT. Also check out MySQL Group By because you will count the 
rows of different groups of data. Refer to the references and learn by yourself. These features will be formally discussed in the Temp Tables and Subqueries lesson.
*/
-- query how many titles each author has published at each publisher.
-- We need to count the titles and then group by author and publisher

SELECT a.au_id as "AuthorID",a.au_lname as "Last_name", a.au_fname as "First_name", p.pub_name as "Publisher",count(t.title) as "Title_count" FROM authors as a

JOIN titleauthor as ta
ON a.au_id = ta.au_id 

JOIN titles as t
ON ta.title_id = t.title_id

JOIN publishers as p
ON t.pub_id = p.pub_id

GROUP BY a.au_id,p.pub_name

ORDER BY count(t.title) DESC;

-- when we group it is ok when the variables are coming from the same table as the groupby

-- Challenge 3 - Best Selling Authors
/*

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
-- 1. We need to acces to information on author, titleauthor and sales
--  a)Table authors: au_id, au_fname, au_lname
--  b) Table titleauthor: au_id, title_id
--  c) Table sales: qty
-- 2. Common columns
--  authors-titleauthor (au_id)
--  titleauthor-sales(title_id)


SELECT * FROM sales;
SELECT * FROM authors;
SELECT * FROM titleauthor;
SELECT * FROM titles;



-- This shows us repeated authors, as they might have more than one title per author

SELECT a.au_id as "AuthorID",a.au_lname as "Last_name", a.au_fname as "First_name", sum(s.qty) as "Total_sold"  FROM authors as a

JOIN titleauthor as ta
ON a.au_id = ta.au_id 

JOIN titles as t
ON ta.title_id = t.title_id

JOIN sales as s
ON t.title_id = s.title_id

GROUP BY a.au_id

ORDER BY sum(s.qty) DESC

LIMIT 3;



-- Challenge 4 - Best Selling Authors Ranking

/*
Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors who have sold 0 titles
should also appear in your output (ideally display 0 instead of NULL as the TOTAL). Also order your results based on TOTAL from high to low.

THOSE ARE THE COMMANDS TO USE TO PASS THE NULL VALUES TO 0:
IFNULL() WHEN LOOKING USE MYSQL

*/

-- BEFORE WERE 19 AUTHORS DISPLAY, WE HAVE 4 AUTHORS THAT DON'T HAVE ANY TITLE PUBLISHED
-- ``FOR COLUMNS-ALIAS, "" FOR VALUES
-- I CHANGE THE JOIN TO LEFT

SELECT a.au_id as `AuthorID`,a.au_lname as `Last_name`, a.au_fname as `First_name`, IFNULL(sum(s.qty),0) as `Total_sold`  FROM authors as a

LEFT JOIN titleauthor as ta
ON a.au_id = ta.au_id 

LEFT JOIN titles as t
ON ta.title_id = t.title_id

LEFT JOIN sales as s
ON t.title_id = s.title_id

GROUP BY a.au_id

ORDER BY sum(s.qty) DESC;


