/* Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
Do you notice any trends in the yearly sales totals? */
SELECT DATE_TRUNC('year', occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Which month did Parch & Posey have the greatest sales in terms of total dollars?
Are all months evenly represented by the dataset? */
SELECT EXTRACT(MONTH FROM occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Months are not evenly represented by the dataset. */
/* Which year did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all years evenly represented by the dataset? */
SELECT EXTRACT(YEAR FROM occurred_at), COUNT(*) AS freq
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Years are not evenly represented by the dataset. */
/* Which month did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all months evenly represented by the dataset? */
