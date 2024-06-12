SELECT 
    ad_date, 
    media_source,
    sum(spend) AS spend,
    sum(impressions) AS impressions,
    sum(clicks) AS clicks,
    sum("value") AS value  
FROM 
(
    SELECT ad_date, 'Facebook Ads' media_source, spend, impressions, reach,  clicks, leads, "value"    
    FROM facebook_ads_basic_daily f
    UNION 
    SELECT ad_date, 'Google Ads' media_source, spend ,  impressions, reach,  clicks, leads, "value"    
    FROM google_ads_basic_daily g
) t
GROUP BY ad_date, media_source 