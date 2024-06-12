WITH t5 AS (
WITH t4 AS (
WITH t3 AS (  
WITH facebook_google_utm AS( 
WITH facebook_google AS(
    SELECT
        ad_date,
        url_parameters,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM facebook_ads_basic_daily fabd
LEFT JOIN facebook_campaign fc ON fabd.campaign_id = fc.campaign_id
LEFT JOIN facebook_adset fa ON fabd.adset_id = fa.adset_id
UNION ALL
    SELECT
        ad_date,
        url_parameters,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM google_ads_basic_daily gabd)
    SELECT
        ad_date,
        CASE WHEN lower (substring (url_parameters,'utm_campaign=([^\&]+)')) = 'nan' THEN NULL ELSE lower (substring (url_parameters, 'utm_campaign=([^\&]+)'))
        END AS utm_campaign,
        COALESCE (spend, 0) AS spend,
        COALESCE (impressions, 0) AS impressions,
        COALESCE (reach, 0) AS reach,
        COALESCE (clicks, 0) AS clicks,
        COALESCE (leads, 0) AS leads,
        COALESCE (value, 0) AS value
    FROM facebook_google)
    SELECT
        ad_date,
        utm_campaign,
        sum(spend) AS total_spend,
        sum(impressions) AS total_impr,
        sum(clicks) AS total_clicks,
        sum(value) AS total_value
    FROM facebook_google_utm
    GROUP BY ad_date, utm_campaign)
    SELECT
        to_char(date_trunc('MONTH', ad_date),'YYYY-MM-DD') AS ad_month, utm_campaign,
        sum(total_spend) AS month_spend,
        sum(total_impr) AS month_impr,
        sum(total_clicks) AS month_clicks,
        sum(total_value) AS month_value,
        CASE WHEN sum(total_clicks) > 0 THEN sum(total_spend)/ sum(total_clicks) ELSE 0 END AS CPC,
        CASE WHEN sum(total_impr)::NUMERIC > 0 THEN sum(total_spend)/ sum(total_impr)::NUMERIC * 1000 ELSE 0 END AS CPM,
        CASE WHEN sum(total_impr)::NUMERIC > 0 THEN sum(total_clicks)/ sum(total_impr)::NUMERIC * 100 ELSE 0 END AS CTR,
        CASE WHEN sum(total_spend)::NUMERIC > 0 THEN (sum(total_value)-sum(total_spend))/ sum(total_spend)::NUMERIC * 100 ELSE 0 END AS ROMI
    FROM t3
    GROUP BY ad_month, utm_campaign)
    SELECT
        ad_month,
        utm_campaign,
        month_spend,
        month_impr,
        month_clicks,
        month_value,
        CPC,
        CPM,
        CTR,
        ROMI,
        LAG (CPC, 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS previous_CPC,
        LAG (CPM, 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS previous_CPM,
        LAG (CTR, 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS previous_CTR,
        LAG (ROMI, 1) OVER (PARTITION BY utm_campaign ORDER BY ad_month) AS previous_ROMI
    FROM t4)
    SELECT
        ad_month,
        utm_campaign,
        cpc,
        previous_CPC,
        CPM, 
        previous_CPM,
        CTR, 
        previous_CTR,
        ROMI, 
        previous_ROMI,
        CASE WHEN CPC > 0 THEN (CPC- previous_CPC)/ CPC ELSE NULL END AS Diff_CPC,
        CASE WHEN CPM > 0 THEN (CPM- previous_CPM)/ CPM ELSE NULL END AS Diff_CPM,
        CASE WHEN CTR > 0 THEN (CTR- previous_CTR)/ CTR ELSE NULL END AS Diff_CTR,
        CASE WHEN ROMI > 0 THEN (ROMI- previous_ROMI)/ ROMI ELSE NULL END AS Diff_ROMI
    FROM t5