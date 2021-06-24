-- Challenge 1 - Who Have Published What At Where?

USE publications;

SELECT a.au_id, a.au_lname, a.au_fname, t.title_id, p.pub_name, tit.title
FROM authors as a
INNER JOIN titleauthor as t
on a.au_id = t.au_id
LEFT JOIn titles as tit
on t.title_id = tit.title_id
LEFT JOIN publishers as p
on tit.pub_id = p.pub_id;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


-- Challenge 2 - Who Have Published How Many At Where?

SELECT  a.au_id, a.au_lname, a.au_fname, p.pub_name, count(tit.title) as Tilte_Count
FROM authors as a
INNER JOIN titleauthor as t
on a.au_id = t.au_id
LEFT JOIn titles as tit
on t.title_id = tit.title_id
LEFT JOIN publishers as p
on tit.pub_id = p.pub_id
GROUP BY tit.title;


-- Challenge 3 - Best Selling Authors

SELECT  a.au_id, a.au_lname, a.au_fname, tit.title, coalesce(ytd_sales, 0)
FROM authors as a
INNER JOIN titleauthor as t
on a.au_id = t.au_id
LEFT JOIn titles as tit
on t.title_id = tit.title_id
ORDER BY ytd_sales DESC
