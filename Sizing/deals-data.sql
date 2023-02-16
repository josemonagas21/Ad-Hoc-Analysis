-- Deals data is obtained from airtable
-- The following table was created in BigQuery with all deals data until Jan' 31-2023 `nyt-bigquery-beta-workspace.jose_data.airtable-deals-data` 
-- Query to pull data from a specific month 

SELECT 
      Product_Name,
      Merchant,
      Category,
      Start_Date,
      End_Date,
    

FROM `nyt-bigquery-beta-workspace.jose_data.airtable-deals-data` 
WHERE Start_Date between '2023-01-01' and '2023-01-31' and (End_Date > '2023-01-31' OR End_Date is null) 
ORDER BY 4