/* Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc. */
SELECT LEFT(primary_poc,POSITION(' ' IN primary_poc)-1) as first, RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) as last
FROM accounts
/* Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns. */
SELECT LEFT(name,POSITION(' ' IN name)-1) as first, RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) as last
FROM sales_reps
