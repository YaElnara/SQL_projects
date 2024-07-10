WITH t2 AS (
  WITH facebook_google AS (
    SELECT 
      ad_date, 
      url_parameters, 
      spend, 
      impressions, 
      reach, 
      clicks, 
      leads, 
      value 
    FROM 
      facebook_ads_basic_daily fabd 
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
    FROM 
      google_ads_basic_daily gabd
  ) 
  SELECT 
    ad_date, 
    CASE WHEN lower (
      substring (
        url_parameters, 'utm_campaign=([^\&]+)'
      )
    ) = 'nan' THEN NULL ELSE lower (
      substring (
        url_parameters, 'utm_campaign=([^\&]+)'
      )
    ) END AS utm_campaign, 
    COALESCE (spend, 0) AS spend, 
    COALESCE (impressions, 0) AS impressions, 
    COALESCE (reach, 0) AS reach, 
    COALESCE (clicks, 0) AS clicks, 
    COALESCE (leads, 0) AS leads, 
    COALESCE (value, 0) AS value 
  FROM 
    facebook_google
) 
SELECT 
  ad_date, 
  utm_campaign, 
  sum(spend) AS total_spend, 
  sum(impressions) AS total_impr, 
  sum(clicks) AS total_clicks, 
  sum(value) AS total_value, 
  CASE WHEN sum(clicks) > 0 THEN sum(spend)/ sum(clicks) ELSE 0 END AS CPC, 
  CASE WHEN sum(impressions):: NUMERIC > 0 THEN sum(spend)/ sum(impressions):: NUMERIC * 1000 ELSE 0 END AS CPM, 
  CASE WHEN sum(impressions):: NUMERIC > 0 THEN sum(clicks)/ sum(impressions):: NUMERIC * 100 ELSE 0 END AS CTR, 
  CASE WHEN
    sum(spend):: NUMERIC > 0
    THEN (sum(value)- sum(spend)) / sum(spend):: NUMERIC * 100
    ELSE 0
    END AS ROMI 
FROM 
  t2 
GROUP BY 
  ad_date, 
  utm_campaign
