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

/* Consider vowels as a, e, i, o, and u.
What proportion of company names start with a vowel, and what percent start with anything else? */
