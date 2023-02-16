-- This query pulls on-site search data and parses searched_terms 

 WITH base AS (
        SELECT   
            DATE_TRUNC(date,MONTH) as date,
            --   search_term,
              LOWER(REGEXP_EXTRACT(search_term, ':(.*?)\\|', 1)) as top_searched_terms,
              SUM(daily_total_search_count) as search_count

FROM `nyt-wccomposer-prd.wc_data_reporting.etsor_site_search_mv`
WHERE date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY 1,2
ORDER BY 3 DESC 
 )
     
SELECT 
* 
FROM base 
ORDER BY 3 DESC, 2
LIMIT 100 