/* Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales. */
SELECT T3.name, T3.region, T3.total_sales
FROM (SELECT s.name, r.name AS region, SUM(o.total_amt_usd) AS total_sales
    FROM sales_reps s
    JOIN accounts a ON a.sales_rep_id = s.id
    JOIN orders o ON o.account_id = a.id
    JOIN region r ON r.id = s.region_id
    GROUP BY s.name, r.name
    ORDER BY r.name) T3
JOIN (SELECT region, MAX(total_sales)
      FROM
        (SELECT s.name, r.name AS region, SUM(o.total_amt_usd) AS total_sales
        FROM sales_reps s
        JOIN accounts a ON a.sales_rep_id = s.id
        JOIN orders o ON o.account_id = a.id
        JOIN region r ON r.id = s.region_id
        GROUP BY s.name, r.name
        ORDER BY r.name) T1
      GROUP BY region) T2 ON T2.region=T3.region
WHERE T2.max = T3.total_sales
/* For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed? */
SELECT r.name, COUNT(o.id) order_count, SUM(o.total_amt_usd) sales_sum
FROM orders o
JOIN accounts a ON a.id=o.account_id
JOIN sales_reps s ON s.id=a.sales_rep_id
JOIN region r ON r.id = s.region_id
GROUP BY r.name
ORDER BY 3 DESC
LIMIT 1
/* How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer? */
SELECT COUNT(*)
FROM (SELECT a.name, COUNT(*)
	FROM accounts a
	JOIN orders o ON o.account_id = a.id
	GROUP BY a.name
	HAVING COUNT(*) >
		(SELECT count
		FROM
			(SELECT SUM(o.standard_qty), COUNT(o.id)
			FROM accounts a
			JOIN orders o on o.account_id=a.id
			GROUP BY a.name
			ORDER BY sum DESC
			LIMIT 1) T1
		)
        ) T2
/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel? */
SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a ON w.account_id=a.id
WHERE a.name = (SELECT name
		FROM (SELECT a.name, SUM(o.total_amt_usd)
			FROM orders o
			JOIN accounts a ON a.id = o.account_id
			GROUP BY a.name
			ORDER BY 2 DESC
			LIMIT 1) T1
	       )
GROUP BY a.name, w.channel
/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts? */
SELECT AVG(sum)
FROM (SELECT a.name, SUM(o.total_amt_usd)
	FROM accounts a
	JOIN orders o ON a.id=o.account_id
	GROUP BY a.name
ORDER BY 2 DESC
LIMIT 10) T1
/* What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders? */
SELECT AVG(sum)
FROM   (SELECT a.name, SUM(o.total_amt_usd)
	FROM orders o
	JOIN accounts a ON a.id=o.account_id
	JOIN (SELECT a.name, AVG(o.total_amt_usd) AS order_avg
	      FROM accounts a
	      JOIN orders o ON o.account_id=a.id
	      GROUP BY a.name
	      HAVING AVG(o.total_amt_usd) > 
			(SELECT AVG(o.total_amt_usd)
			 FROM orders o)
	      ORDER BY order_avg DESC) T1 ON T1.name=a.name
	GROUP BY a.name) T2
