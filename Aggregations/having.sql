/* How many of the sales reps have more than 5 accounts that they manage? */
SELECT s.name rep_name, COUNT(a.id) num_accounts
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id=s.id
GROUP BY s.name
HAVING COUNT(a.id) > 5
/* How many accounts have more than 20 orders? */
SELECT a.name account_name, COUNT(o.id) num_orders
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20
/* Which account has the most orders? */
SELECT a.name account_name, COUNT(o.id) num_orders
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1
