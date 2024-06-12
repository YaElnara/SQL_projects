SELECT
    ad_date,
    media_source, 
    campaign_name,
    adset_name,
    sum(spend) AS total_spend,
    sum(impressions) AS total_impr,
    sum(clicks) AS total_clicks,
    sum("value") AS total_value
    FROM 
    (
    SELECT gabd.ad_date,'Google Ads' media_source, gabd.campaign_name, gabd.adset_name, gabd.spend , gabd.impressions, gabd.reach, gabd.clicks, gabd.leads, gabd."value"
    FROM google_ads_basic_daily gabd
UNION All
    SELECT fabd.ad_date,'Facebook Ads' media_source, fc.campaign_name, fa.adset_name, fabd.spend , fabd.impressions, fabd.reach, fabd.clicks, fabd.leads, fabd."value"
    FROM facebook_ads_basic_daily fabd 
INNER JOIN facebook_adset fa ON fa.adset_id = fabd.adset_id 
INNER JOIN facebook_campaign fc ON fc.campaign_id = fabd.campaign_id
    ) t 
    GROUP BY ad_date,media_source,campaign_name, adset_name


