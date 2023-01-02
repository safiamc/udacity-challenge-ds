/* For each account, determine the average amount of each type of paper they purchased across their orders.
Your result should have four columns:
one for the account name and one for the average quantity purchased for each of the paper types for each account.
*/
SELECT a.name, AVG(standard_qty) AS standard_avg,
AVG(gloss_qty) AS gloss_avg,
AVG(poster_qty) AS poster_avg
FROM orders o
JOIN accounts a ON o.account_id = a.id
GROUP BY a.name
/* Determine the number of times a particular channel was used in the web_events table for each sales rep.
Your final table should have three columns:
the name of the sales rep, the channel, and the number of occurrences.
Order your table with the highest number of occurrences first.
*/
SELECT s.name AS rep_name, w.channel, COUNT(channel) as occurrences
FROM web_events w
JOIN accounts a ON w.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY occurrences DESC
/* Determine the number of times a particular channel was used in the web_events table for each region.
Your final table should have three columns:
the region name, the channel, and the number of occurrences.
Order your table with the highest number of occurrences first.
*/
SELECT r.name AS region_name, w.channel, COUNT(channel) as occurrences
FROM web_events w
JOIN accounts a ON w.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY occurrences DESC
