/*  For this set of quiz questions, you are going to be working with a single table in the environment below.
This is a different dataset than Parch & Posey, as all of the data in that particular dataset were already clean.
Write a query to look at the top 10 rows to understand the columns and raw data in the dataset called 'sf_crime_data'. */
SELECT *
FROM sf_crime_data
LIMIT 10
/* Remembering back to the lesson on dates, use the Quiz Question at the bottom of this page to to make sure you remember the format that dates should use in SQL.
- yyyy-mm-dd 
Look at the data column in the 'sf_crime_data' table. Notice the date is not in the correct format.
Write a query to change the date into the correct SQL date format. You will need to use at least SUBSTR and CONCAT to perform this operation. */
SELECT date as original_date, CONCAT(SUBSTR(date,7,4), '-', SUBSTR(date,1,2), '-', SUBSTR(date, 4,2))::DATE as new_date
FROM sf_crime_data
