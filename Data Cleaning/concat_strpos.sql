/* Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com. */
SELECT primary_poc, CONCAT(LOWER(LEFT(primary_poc,POSITION(' ' IN primary_poc)-1)), '.', LOWER(RIGHT(primary_poc,LENGTH(primary_poc)-POSITION(' ' IN primary_poc))), '@', RIGHT(website,LENGTH(website)-4)) email, name
FROM accounts
/* You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise, your solution should be just as in question 1. */
SELECT CONCAT(LOWER(LEFT(primary_poc,POSITION(' ' IN primary_poc)-1)), '.', LOWER(RIGHT(primary_poc,LENGTH(primary_poc)-POSITION(' ' IN primary_poc))), '@', LOWER(REPLACE(REPLACE(REPLACE(REPLACE(name, ' ', ''), '.', ''), '&', ''), '''', '')) , '.com') email
FROM accounts
/* We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces. */
WITH T1 AS (SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) AS first, 
            RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS last, name
            FROM accounts)
SELECT CONCAT(LOWER(LEFT(first,1)), LOWER(RIGHT(first,1)), LOWER(LEFT(last,1)), LOWER(RIGHT(last,1)), LENGTH(first), LENGTH(last), UPPER(REPLACE(name, ' ', '')))
FROM T1
ORDER BY 1
