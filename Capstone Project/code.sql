Select Count(Distinct utm_campaign) AS 'Total Campaigns'
From page_visits;

Select Count(Distinct utm_source) AS 'Total Sources'
From page_visits;

Select Distinct utm_campaign AS 'Campaign', utm_source AS 'Source'
From page_visits;

Select Distinct page_name AS 'Pages'
From page_visits;

WITH last_touch AS (
    SELECT user_id  ,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id AS 'User ID',
    lt.last_touch_at AS 'Last Touch' ,
    pv.utm_source AS 'Source',
		pv.utm_campaign AS 'Campaign',
    COUNT(utm_campaign) AS 'LT and Purchase'
FROM last_touch lt

JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    
GROUP BY 4;

SELECT Count(Distinct user_id) AS 'Total Users That Purchased'
From page_visits
Where page_name = '4 - purchase';

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id AS 'User ID',
    ft.first_touch_at AS 'First Touch',
    pv.utm_source AS 'Source',
    pv.utm_campaign AS 'Campaign',
    COUNT(utm_campaign) AS 'Total First Touches'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 4;






