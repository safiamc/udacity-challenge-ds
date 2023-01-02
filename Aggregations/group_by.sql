/* Which account (by name) placed the earliest order?
Your solution should have the account name and the date of the order.
*/
SELECT a.name, MIN(o.occurred_at)
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY min
LIMIT 1
/* Find the total sales in usd for each account.
You should include two columns - the total sales for each company's orders in usd and the company name.
*/
SELECT a.name, SUM(o.total_amt_usd) AS total_sales_usd
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
/* Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event?
Your query should return only three values - the date, channel, and account name.
*/
SELECT a.name, MIN(w.occurred_at), w.channel
FROM web_events w
JOIN accounts a ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY min DESC
LIMIT 1
/* Find the total number of times each type of channel from the web_events was used.
Your final table should have two columns - the channel and the number of times the channel was used.
*/
SELECT channel, COUNT(channel)
FROM web_events
GROUP BY channel
/* Who was the primary contact associated with the earliest web_event? 
*/
SELECT a.primary_poc, w.occurred_at
FROM web_events w
JOIN accounts a ON a.id = w.account_id
ORDER BY occurred_at
LIMIT 1
/*What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd.
Order from smallest dollar amounts to largest.
*/
SELECT a.name, MIN(o.total_amt_usd)
FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY min
/* Find the number of sales reps in each region.
Your final table should have two columns - the region and the number of sales_reps.
Order from the fewest reps to most reps.
*/
SELECT r.name, COUNT(s.*)
FROM sales_reps s
JOIN region r ON r.id = s.region_id
GROUP BY r.name
ORDER BY count
