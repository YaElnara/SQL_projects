SELECT
    campaign_name,
    ((sum("value")- sum(spend)) / sum(spend)::NUMERIC) * 100 AS ROMI,
    adset_name
FROM 
    (
    SELECT
        gabd.ad_date,
        'Google Ads' media_source,
        gabd.campaign_name,
        gabd.adset_name,
        gabd.spend ,
        gabd.impressions,
        gabd.reach,
        gabd.clicks,
        gabd.leads,
        gabd."value"
    FROM
        google_ads_basic_daily gabd
UNION ALL
    SELECT
        fabd.ad_date,
        'Facebook Ads' media_source,
        fc.campaign_name,
        fa.adset_name,
        fabd.spend ,
        fabd.impressions,
        fabd.reach,
        fabd.clicks,
        fabd.leads,
        fabd."value"
    FROM
        facebook_ads_basic_daily fabd
    INNER JOIN facebook_adset fa ON
        fa.adset_id = fabd.adset_id
    INNER JOIN facebook_campaign fc ON
        fc.campaign_id = fabd.campaign_id
    ) t
WHERE
    spend > 0
GROUP BY
    campaign_name,
    adset_name
HAVING
    sum(spend) > 500000
ORDER BY
    ROMI DESC
LIMIT 1

