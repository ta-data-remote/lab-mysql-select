USE publications; 

-- CHALLENGE 1:
/* figure out what titles each author has published at which publishers. 
Your output should have at least the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published

If your query is correct, the total rows in your output should be the same,
as the total number of records in Table titleauthor.
*/
select a.au_id, a.au_lname, a.au_fname, c.title, d.pub_name from authors as a -- will be shown below
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
join publishers as d
on c.pub_id = d.pub_id;

select count(*) from titleauthor; -- 25


-- CHALLENGE 2:
/* Who Have Published How Many At Where?:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published
Title count - 

To check if your output is correct, sum up the TITLE COUNT column. 
The sum number should be the same as the total number of records in Table titleauthor.
*/

SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select a.au_id, a.au_lname, a.au_fname, c.title, d.pub_name, count(*) as Title_count from authors as a 
join titleauthor as b
on a.au_id = b.au_id
join titles as c
on b.title_id = c.title_id
join publishers as d
on c.pub_id = d.pub_id
group by a.au_id;

-- CHALLENGE 3:
/* Who are the top 3 authors who have sold the highest number of titles? :
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TOTAL - total number of titles sold from this author

Your output should be ordered based on TOTAL from high to low.
Only output the top 3 best selling authors.
*/

select a.au_id, a.au_lname, a.au_fname, sum(d.qty) from authors as a 
join titleauthor as b
on b.au_id = a.au_id
join titles as c
on c.title_id = b.title_id
join sales as d
on d.title_id = c.title_id
group by a.au_id
order by sum(d.qty) desc
limit 3;


-- CHALLENGE 4:
/* Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
Also order your results based on TOTAL from high to low.
*/

select a.au_id, a.au_lname, a.au_fname, COALESCE(sum(d.qty), 0) from authors as a 
left join titleauthor as b
on a.au_id = b.au_id
left join titles as c
on c.title_id = b.title_id
left join sales as d
on d.title_id = c.title_id
group by a.au_id
order by sum(d.qty) desc; 
