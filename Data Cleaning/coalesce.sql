/* Run the query entered below in the SQL workspace to notice the row with missing data. */
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL
/* Use COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table in 1. */
SELECT COALESCE(a.id,a.id), o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
/* Use COALESCE to fill in the orders.account_id column with the account.id for the NULL value for the table in 1. */
SELECT COALESCE(o.account_id,a.id), o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
/* Use COALESCE to fill in each of the qty and usd columns with 0 for the table in 1. */
SELECT COALESCE(o.account_id,a.id) AS account_id, COALESCE(standard_qty, 0) standar_qty, COALESCE(gloss_qty, 0) gloss_qty, COALESCE(poster_qty,0) poster_qty, COALESCE(standard_amt_usd,0) standard_amt_usd, COALESCE(gloss_amt_usd,0) gloss_amt_usd, COALESCE(poster_amt_usd,0) poster_amt_usd, COALESCE(total_amt_usd, 0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
/* Run the query in 1 with the WHERE removed and COUNT the number of ids. */
SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
/* Run the query in 5, but with the COALESCE function used in questions 2 through 4. */
WITH t1 AS (SELECT COALESCE(a.id,a.id) filled_id, COALESCE(o.account_id,a.id) account_id, COALESCE(o.account_id,a.id) AS account_id, COALESCE(standard_qty, 0) standar_qty, COALESCE(gloss_qty, 0) gloss_qty, COALESCE(poster_qty,0) poster_qty, COALESCE(standard_amt_usd,0) standard_amt_usd, COALESCE(gloss_amt_usd,0) gloss_amt_usd, COALESCE(poster_amt_usd,0) poster_amt_usd, COALESCE(total_amt_usd, 0)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id)
SELECT COUNT(*)
FROM t1
