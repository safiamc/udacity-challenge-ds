/* Essentially a WITH statement performs the same task as a Subquery.
Therefore, you can write any of the queries we worked with in the "Subquery Mania" using a WITH.
That's what you'll do here.
Try to perform each of the earlier queries again, but using a WITH instead of a subquery. */
/* Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales. */
WITH ts AS (SELECT s.name, r.name AS region, SUM(o.total_amt_usd) AS total_sales
    FROM sales_reps s
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
    JOIN region r ON r.id = s.region_id
    GROUP BY s.name, r.name
    ORDER BY r.name),
    ms AS (SELECT region, MAX(total_sales)
    FROM ts
    GROUP BY region)
SELECT ts.name, ts.region, ts.total_sales
FROM ts
JOIN ms on ms.region = ts.region
WHERE ms.max = ts.total_sales
/* For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed? */
WITH ts AS (SELECT r.name, SUM(o.total_amt_usd)
            FROM orders o
            JOIN accounts a ON a.id=o.account_id
			JOIN sales_reps s ON s.id=a.sales_rep_id
			JOIN region r ON r.id = s.region_id
			GROUP BY r.name),
     top_region AS (SELECT MAX(sum)
                    FROM ts)
SELECT COUNT(*)
FROM orders o
JOIN accounts a ON a.id=o.account_id
JOIN sales_reps s ON s.id=a.sales_rep_id
JOIN region r ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM top_region)
/* This is much more complicated than it needs to be! This can be done without subqueries at all!
How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer? */
WITH sq AS (SELECT SUM(o.standard_qty) standard_sum, SUM(o.total_amt_usd) total_cost
			FROM accounts a
			JOIN orders o on o.account_id=a.id
			GROUP BY a.name
			ORDER BY 1 DESC
			LIMIT 1),
    high_accounts AS (SELECT a.name, SUM(o.total_amt_usd)
	FROM accounts a
	JOIN orders o ON o.account_id = a.id
	GROUP BY a.name
	HAVING SUM(o.total_amt_usd) > (SELECT standard_sum FROM sq))
SELECT COUNT(*)
FROM high_accounts
/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel? */
WITH high_cust AS (SELECT a.name, SUM(o.total_amt_usd)
		FROM orders o
		JOIN accounts a ON a.id = o.account_id
		GROUP BY a.name
		ORDER BY 2 DESC
		LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a ON w.account_id=a.id
WHERE a.name = (SELECT name FROM high_cust)
GROUP BY a.name, w.channel
/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts? */
WITH top_10 AS (SELECT a.name, SUM(o.total_amt_usd)
	FROM accounts a
	JOIN orders o ON a.id=o.account_id
	GROUP BY a.name
	ORDER BY 2 DESC
	LIMIT 10)
SELECT AVG(sum)
FROM top_10
/* What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders? */
WITH above_avg AS (SELECT a.name, AVG(o.total_amt_usd) AS order_avg
                   FROM orders o
                   JOIN accounts a ON o.account_id = a.id
                   GROUP BY a.name
                   HAVING AVG(o.total_amt_usd) > 
                   (SELECT AVG(o.total_amt_usd) 
                    FROM orders o)
                  ),
     lifetime AS (SELECT a.name, SUM(o.total_amt_usd)
                  FROM accounts a
                  JOIN orders o ON o.account_id = a.id
                  JOIN above_avg aa ON a.name=aa.name
                  GROUP BY a.name)
SELECT AVG(sum)
FROM lifetime
