-- INTRODUCTION

USE publications;

-- CHALLENGE 1 - Who have published WHAT at WHERE?

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME',
tit.title AS 'TITLE', pub.pub_name AS 'PUBLISHER'
FROM authors as au
JOIN titleauthor AS titau
ON au.au_id = titau.au_id
JOIN titles AS tit
ON titau.title_id = tit.title_id
JOIN publishers AS pub
ON tit.pub_id = pub.pub_id;

-- CHALLENGE 2 - Who have published HOW MANY at WHERE?

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', pub.pub_name AS 'PUBLISHER',COUNT(titau.title_id) AS 'TITLE COUNT'
FROM authors as au
INNER JOIN titleauthor AS titau
ON au.au_id = titau.au_id
INNER JOIN titles AS tit
ON titau.title_id = tit.title_id
INNER JOIN publishers AS pub
ON tit.pub_id = pub.pub_id
GROUP BY au.au_id, pub.pub_name
ORDER BY au.au_id DESC;

-- CHALLENGE 3 - Best Selling Authors

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME',
 IFNULL(SUM(sa.qty),0) AS 'SOLD'
FROM authors as au
LEFT JOIN titleauthor AS titau
ON au.au_id = titau.au_id
LEFT JOIN sales AS sa
ON titau.title_id = sa.title_id
GROUP BY au.au_id
ORDER BY SUM(sa.qty) DESC
limit 3;

-- CHALLENGE 4 - Best Selling Authors

SELECT au.au_id as 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME',
 IFNULL(SUM(sa.qty),0) AS 'SOLD'
FROM authors as au
LEFT JOIN titleauthor AS titau
ON au.au_id = titau.au_id
LEFT JOIN sales AS sa
ON titau.title_id = sa.title_id
GROUP BY au.au_id
ORDER BY SUM(sa.qty) DESC;