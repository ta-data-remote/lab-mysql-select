use publications; 


-- CHALLENGE 1 

select ta.au_id, t.title, a.au_fname, a.au_lname, p.pub_name from titles as t
join titleauthor as ta
on t.title_id = ta.title_id
join authors as a 
on ta.au_id = a.au_id
join publishers as p
on t.pub_id = p.pub_id;



-- CHALLENGE 2

SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select ta.au_id, a.au_fname, a.au_lname, p.pub_name, count(*) from titles as t
join titleauthor as ta
on t.title_id = ta.title_id
join authors as a 
on ta.au_id = a.au_id
join publishers as p
on t.pub_id = p.pub_id
group by t.title;

-- CHALLENGE 3

select a.au_id, a.au_fname, a.au_lname, sum(s.qty) from authors as a
join titleauthor as ta
on ta.au_id = a.au_id
join titles as t
on t.title_id = ta.title_id
join sales as s
on s.title_id = t.title_id
group by a.au_id
order by sum(s.qty) desc
limit 3;


-- CHALLENGE 4

select a.au_id, a.au_fname, a.au_lname, COALESCE(sum(s.qty), 0) from authors as a
Left join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on t.title_id = ta.title_id
left join sales as s
on s.title_id = t.title_id
group by a.au_id
order by sum(s.qty) desc;