/* Which account (by name) placed the earliest order?
Your solution should have the account name and the date of the order.
*/
SELECT a.name, MIN(o.occurred_at)
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY min
LIMIT 1
