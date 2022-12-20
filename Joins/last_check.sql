/*Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to the account name.
*/
SELECT r.name "Region", s.name "Sales Rep", a.name "Account"
FROM region r
JOIN sales_reps s
ON r.id = s.region_id AND r.name = 'Midwest'
JOIN accounts a
ON a.sales_rep_id=s.id
ORDER BY a.name
