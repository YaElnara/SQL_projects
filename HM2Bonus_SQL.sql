SELECT
    fabd.campaign_id,
     ((SUM(fabd.value) - SUM(fabd.spend)) / SUM(fabd.spend)::NUMERIC) * 100 AS ROMI
FROM
    facebook_ads_basic_daily fabd
GROUP BY
    fabd.campaign_id
HAVING
    SUM(fabd.spend) > 500000
ORDER BY
    ROMI DESC
LIMIT 1