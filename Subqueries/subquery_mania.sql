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

/* How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer? */
/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel? */
/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts? */
/* What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders? */
