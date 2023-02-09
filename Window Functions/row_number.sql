/* Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition.
Your final table should have these four columns. */
SELECT id, account_id, total, ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY total DESC) AS ranking
FROM orders
