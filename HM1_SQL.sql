select fabd.ad_date, fabd.spend, fabd.clicks, fabd.spend / fabd.clicks as click_price
from facebook_ads_basic_daily fabd
where fabd.clicks > 0
order by fabd.ad_date desc;
