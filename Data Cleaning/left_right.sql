/* In the accounts table, there is a column holding the website for each company.
The last three digits specify what type of web address they are using.
Pull these extensions and provide how many of each website type exist in the accounts table.*/
SELECT RIGHT(website,3) AS extension, COUNT(*)
FROM accounts
GROUP BY 1
/* There is much debate about how much the name (or even the first letter of a company name) matters.
Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).
*/
SELECT LEFT(name,1) AS first_init, COUNT(*)
FROM accounts
GROUP BY 1
ORDER BY 1
/* Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and the second group of those company names that start with a letter.
What proportion of company names start with a letter? */
SELECT
CASE WHEN LEFT(name,1) IN ('0','1','2', '3', '4', '5', '6', '7', '8', '9') THEN 0
ELSE 1 END AS letter, COUNT(*)
FROM accounts
GROUP BY 1
/* 350/351~99.7% of company names start with a letter.*/
/* Consider vowels as a, e, i, o, and u.
What proportion of company names start with a vowel, and what percent start with anything else? */
SELECT
CASE WHEN LEFT(name,1) IN ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U') THEN 1
ELSE 0 END AS vowel, COUNT(*)
FROM accounts
GROUP BY 1
/* 80/351~22.8% start with a vowel and  271/351~77.2% start with anything else.*/
