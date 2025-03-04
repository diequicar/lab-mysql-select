USE publications;

SELECT 
authors.au_id as "AUTHOR ID",
authors.au_lname as "LAST NAME",
authors.au_fname as "FIRST NAME",
titles.title as "TITLE",
publishers.pub_name as "PUBLISHER"
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;

SELECT 
authors.au_id as "AUTHOR ID",
authors.au_lname as "LAST NAME",
authors.au_fname as "FIRST NAME",
publishers.pub_name as "PUBLISHER",
COUNT(titles.title_id)	 as "TITLE COUNT"
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id ORDER BY COUNT(titles.title_id) DESC;

SELECT
authors.au_id as "AUTHOR ID",
authors.au_lname as "LAST NAME",
authors.au_fname as "FIRST NAME",
SUM(sales.qty) as "TOTAL"
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id= titles.title_id
GROUP BY authors.au_id ORDER BY SUM(sales.qty) DESC LIMIT 3;

SELECT
authors.au_id as "AUTHOR ID",
authors.au_lname as "LAST NAME",
authors.au_fname as "FIRST NAME",
IFNULL(SUM(sales.qty),0) as "TOTAL"
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON sales.title_id= titles.title_id
GROUP BY authors.au_id ORDER BY SUM(sales.qty) DESC;

SELECT
authors.au_id as "AUTHOR ID",
authors.au_lname as "LAST NAME",
authors.au_fname as "FIRST NAME",
round((((titleauthor.royaltyper/100) * (titles.royalty/100) * titles.price * sales.qty) + (titles.advance / COUNT(titles.title_id))),2)  as "PROFIT"
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON sales.title_id= titles.title_id
GROUP BY authors.au_id ORDER BY PROFIT DESC LIMIT 3;