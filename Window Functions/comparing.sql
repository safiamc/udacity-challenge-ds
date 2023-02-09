/* Imagine you're an analyst at Parch & Posey and you want to determine how the current order's total revenue ("total" meaning from sales of all types of paper) compares to the next order's total revenue.
Modify Derek's query from the previous video in the SQL Explorer below to perform this analysis.
You'll need to use occurred_at and total_amt_usd in the orders table along with LEAD to do so.
In your query results, there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference. */
SELECT occurred_at, total_amt_usd, 
LEAD(total_amt_usd) OVER (ORDER BY occurred_at) as lead,
LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM orders
