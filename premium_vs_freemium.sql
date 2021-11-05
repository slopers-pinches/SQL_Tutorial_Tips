/* GO TO DATASETS FOLDER TO IMPORT ms_acc_dimension, ms_download_facts, and ms_user_dimension csv files */

/* Premium vs Freemium */

/* Find the total number of downloads for paying and non-paying users by date. 
   Include only records where non-paying customers have more downloads than paying customers.
   The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. */

# Use practice schema
use practice;

# Approach:
-- Find the # of downloads between non-paying vs paying by dates 
-- Only show records where non-paying downloads greater than paying downloads

# CTE of non-paying donwloads
WITH non_paying AS (
    SELECT date, SUM(downloads) AS non_paying_downloads
        FROM ms_download_facts AS d
        INNER JOIN ms_user_dimension AS u
        ON d.user_id = u.user_id
        INNER JOIN ms_acc_dimension AS a
        ON u.acc_id = a.acc_id
        WHERE paying_customer = 'no'
        GROUP BY date),
	
# CTE of paying downloads
    paying AS (
    SELECT date, SUM(downloads) AS paying_downloads
        FROM ms_download_facts AS d
        INNER JOIN ms_user_dimension AS u
        ON d.user_id = u.user_id
        INNER JOIN ms_acc_dimension AS a
        ON u.acc_id = a.acc_id
        WHERE paying_customer = 'yes'
        GROUP BY date)

# Final Output
SELECT non_paying.date, non_paying_downloads, paying_downloads
    FROM non_paying
    INNER JOIN paying
    ON non_paying.date = paying.date
    -- Show records when non_paying downloads > paying_downloads
    WHERE non_paying_downloads > paying_downloads
    ORDER BY non_paying.date;