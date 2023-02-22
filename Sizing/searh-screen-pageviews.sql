-- This query isolates pageviews of the search screen only and not subsequent like the other pageviews script

select 
DATE_TRUNC(date(_pt), MONTH) as date
-- --  referrer.raw
-- -- , url.url_without_query
-- -- ,regexp_extract(referrer.raw, '=([^&]*)', 1)
-- -- LOWER(REPLACE(REGEXP_REPLACE(regexp_extract(referrer.raw, '=([^&]*)', 1), '\\+', ' '), '_', '')) AS searched_key
,LOWER(uq.value) AS searched_key
-- , wirecutter.asset.primary_category
-- , p.home_category
, count(pageview_id) as pageviews
-- , wirecutter.asset.id 
-- uq.*

from `nyt-eventtracker-prd.et.page` pg,
 UNNEST(url.query) AS uq
LEFT JOIN `nyt-wccomposer-prd.wc_data_reporting.etsor_page_performance_mv`  p  ON p.post_id =  CASE 
              WHEN wirecutter.asset.id IN ("404","ALL","BLOG","HOME","LISTS","REVIEWS","SEARCH","Home","Search","Leaderboard","All","Post","Blog","List","Search","Sepecial Event","Section") THEN wirecutter.asset.id 
                ELSE SUBSTR(wirecutter.asset.id, 3) END  and p.date = DATE_TRUNC(DATE(pg._pt), MONTH)

where date(_pt) between "2023-01-01" and "2023-01-31"
    AND source_app LIKE '%wirecutter%'
-- and referrer.path like "%search%"
and wirecutter.asset.id = 'SEARCH'
and uq.key = 's'
 group by 1,2
order by pageviews desc
LIMIT 50