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
/* Which accounts spent more than 30,000 usd total across all orders? */
SELECT a.name account_name, SUM(total_amt_usd) total_spent
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
HAVING SUM(total_amt_usd) > 30000
/* Which accounts spent less than 1,000 usd total across all orders? */
SELECT a.name account_name, SUM(total_amt_usd) total_spent
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
HAVING SUM(total_amt_usd) < 1000
/* Which account has spent the most with us? */
SELECT a.name account_name, SUM(total_amt_usd) total_spent
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1
/* Which account has spent the least with us? */
SELECT a.name account_name, SUM(total_amt_usd) total_spent
FROM accounts a
JOIN orders o ON a.id=o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1
/* Which accounts used facebook as a channel to contact customers more than 6 times? */
SELECT a.name account_name, COUNT(*)
FROM accounts a
JOIN web_events w ON a.id=w.account_id
WHERE channel = 'facebook'
GROUP BY a.name
HAVING COUNT(*) > 6
/* Which account used facebook most as a channel? */
SELECT a.name account_name, COUNT(*)
FROM accounts a
JOIN web_events w ON a.id=w.account_id
WHERE channel = 'facebook'
GROUP BY a.name
ORDER BY count DESC
LIMIT 1
/* Which channel was most frequently used by most accounts? */
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w ON w.account_id = a.id
GROUP BY a.name, channel
ORDER BY a.name, count DESC
