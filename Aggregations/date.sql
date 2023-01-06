/* Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
Do you notice any trends in the yearly sales totals? */
SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Which month did Parch & Posey have the greatest sales in terms of total dollars?
Are all months evenly represented by the dataset? */
SELECT EXTRACT(MONTH FROM occurred_at), SUM(total_amt_usd) AS total
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Highest total dollars occurred in Dec. Months are not evenly represented by the dataset.
Which year did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all years evenly represented by the dataset? */
SELECT EXTRACT(YEAR FROM occurred_at), COUNT(*) AS freq
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Highest number of orders occurred in 2016. Years are not evenly represented by the dataset.
Which month did Parch & Posey have the greatest sales in terms of the total number of orders?
Are all months evenly represented by the dataset? */
SELECT EXTRACT(MONTH FROM occurred_at), COUNT(*) AS freq
FROM orders
GROUP BY 1
ORDER BY 2 DESC
/* Highest number of orders occurred in Dec.
In which month of which year did Walmart spend the most on gloss paper in terms of dollars? */
SELECT EXTRACT(YEAR FROM o.occurred_at) AS year, EXTRACT(MONTH FROM o.occurred_at) AS month, SUM(gloss_amt_usd)
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1,2
ORDER BY 3 DESC
/* Walmart spent the most on gloss paper in May 2016. */
