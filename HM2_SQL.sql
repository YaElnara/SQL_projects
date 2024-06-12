select 
	fabd.ad_date,
	fabd.campaign_id, 
	sum(fabd.spend) as sum_spend , 
	sum(fabd.impressions) as sum_impr,
	sum(fabd.clicks) as sum_clicks,
	sum(fabd.value) as sum_value,
	sum(fabd.spend) / sum(fabd.clicks) as CPC,
	(sum(fabd.spend) / sum(fabd.impressions)::numeric) * 1000 as CPM,
	(sum(fabd.clicks) / sum(fabd.impressions)::numeric) * 100 as CTR,
	((Sum(fabd.value) - sum(fabd.spend)) / sum(fabd.spend)::numeric) * 100 as ROMI
from
	facebook_ads_basic_daily fabd
where
	fabd.clicks > 0
	and fabd.impressions > 0
group by
	fabd.ad_date,
	fabd.campaign_id


