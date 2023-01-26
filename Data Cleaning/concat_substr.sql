/* Suppose the company wants to assess the performance of all the sales representatives.
Each sales representative is assigned to work in a particular region.
To make it easier to understand for the HR team, display the concatenated sales_reps.id, ‘_’ (underscore), and region.name as EMP_ID_REGION for each sales representative.
*/
SELECT CONCAT(s.id, '_', r.name) AS EMP_ID_REGION, s.name
FROM sales_reps s
JOIN region r ON r.id=s.region_id
/* From the accounts table, display the name of the client, the coordinate as concatenated (latitude, longitude), email id of the primary point of contact as <first letter of the primary_poc><last letter of the primary_poc>@<extracted name and domain from the website>.
*/
SELECT name, CONCAT(lat,', ', long) AS COORDINATE, CONCAT(LOWER(LEFT(primary_poc,1)), RIGHT(primary_poc,1), '@', SUBSTR(website,5)) AS email_id
FROM accounts a
/* From the web_events table, display the concatenated value of account_id, '_' , channel, '_', count of web events of the particular channel. */
SELECT CONCAT(account_id,'_', channel, '_', count)
FROM (SELECT account_id, channel, COUNT(*) AS count
FROM web_events
GROUP BY 1,2
ORDER BY 1) T1
