# Ads analysis, Retail 

SQL, Google Looker Studio

## HM2_SQL.sql
This SQL script selects and aggregates the following data for each date and campaign ID:
- `ad_date`: The date of the ad display.
- `campaign_id`: The unique identifier of the campaign.
- Aggregated metrics per date and campaign ID:
  - Total spend
  - Number of impressions
  - Number of clicks
  - Total conversion value

Additionally, it calculates the following metrics for each date and campaign ID:
- CPC (Cost Per Click)
- CPM (Cost Per Thousand Impressions)
- CTR (Click-Through Rate)
- ROMI (Return on Marketing Investment)

## HM2Bonus_SQL.sql
This SQL script finds the campaign with the highest ROMI among those with total spend greater than 500,000.

## HM3_SQL.sqls
This SQL script uses a CTE to combine data from Google and Facebook ad tables to create a unified table with the following fields:
- `ad_date`: The date of the ad display.
- `media_source`: The name of the purchase source (Google Ads / Facebook Ads).
- `spend`, `impressions`, `reach`, `clicks`, `leads`, `value`: Campaign and ad set metrics for the respective days.

From this combined table, it performs a selection to aggregate the following data by date and media source:
- `ad_date`: The date of the ad display.
- `media_source`: The name of the purchase source.
- Aggregated metrics per date and media source:
  - Total spend
  - Number of impressions
  - Number of clicks
  - Total conversion value

## HM3.1_SQL.sql
1. This SQL script uses a CTE to combine data from `facebook_ads_basic_daily`, `facebook_adset`, and `facebook_campaign` tables to create a table with the following fields:
   - `ad_date`: The date of the ad display on Facebook.
   - `campaign_name`: The name of the campaign on Facebook.
   - `adset_name`: The name of the ad set on Facebook.
   - `spend`, `impressions`, `reach`, `clicks`, `leads`, `value`: Campaign and ad set metrics for the respective days.
2. In the second CTE, it combines data from `google_ads_basic_daily` and the first CTE to create a unified table with information about Facebook and Google marketing campaigns.
3. From this unified table, it performs a selection to aggregate the following data by date, media source, campaign name, and ad set name:
   - `ad_date`: The date of the ad display.
   - `media_source`: The name of the purchase source (Google Ads / Facebook Ads).
   - `campaign_name`: The name of the campaign.
   - `adset_name`: The name of the ad set.
   - Aggregated metrics per date, campaign name, and ad set name:
     - Total spend
     - Number of impressions
     - Number of clicks
     - Total conversion value

## HM3.1Bonus_SQL.sql
This SQL script combines data from four tables to determine the campaign with the highest ROMI among those with total spend greater than 500,000. Additionally, it identifies the ad set (adset_name) with the highest ROMI within that campaign.

## Google Looker Studio Dashboard Description

### Task Overview
Created a detailed dashboard in Google Looker Studio to visualize marketing campaign performance metrics using data from a PostgreSQL database.

### Steps Performed

1. Set Up Data Source
   - Created a new report in Google Looker Studio.
   - Connected to the PostgreSQL database using a custom query from **HM3_SQL.sql**.

2. Created New Fields
   - Added calculated fields: Sum of Ad Spend, CPC, CPM, CTR, and ROMI.

3. Added Charts
   - Combined Chart: Plotted ad display date on the horizontal axis, with Sum of Ad Spend and ROMI per month on the vertical axes.
   - Line Chart: Displayed the number of active campaigns per month.
   - Table with Heatmaps: Displayed campaign names with metrics (Sum of Ad Spend, CPC, CPM, CTR, ROMI).

4. Added Filters
   - Included filters for campaign names and ad display dates.


## HM5_SQL.sql
1. This SQL script uses a CTE to combine data from the provided tables to create a table with the following fields:
   - `ad_date`: The date of the ad display on Google and Facebook.
   - `url_parameters`: The part of the URL that includes UTM parameters.
   - `spend`, `impressions`, `reach`, `clicks`, `leads`, `value`: Campaign and ad set metrics for the respective days.
   - Null values in metrics are replaced with zeros.
2. From this combined table, it performs a selection to extract the following fields:
   - `ad_date`: The date of the ad display.
   - `utm_campaign`: The `utm_campaign` parameter from `utm_parameters`, converted to lowercase, and set to null if the value is 'nan'.
   - Aggregated metrics per date and campaign:
     - Total spend
     - Number of impressions
     - Number of clicks
     - Total conversion value
     - CTR, CPC, CPM, ROMI: Calculated metrics per date and campaign using a `CASE` statement to avoid division by zero.

## HM5Bonus_SQL.sql
This SQL script extends the query from the main task by decoding the `utm_campaign` values using a temporary function. The function code is sourced from the internet.

## HM6_SQL.sql
1. This SQL script uses a CTE from the previous homework to create a new (second) CTE for a selection with the following data:
   - `ad_month`: The first day of the month from `ad_date`.
   - `utm_campaign`, total spend, number of impressions, number of clicks, conversion value, CTR, CPC, CPM, ROMI: The same fields and conditions as in the previous task.
2. The resulting selection includes the following fields:
   - `ad_month`
   - `utm_campaign`, total spend, number of impressions, number of clicks, conversion value, CTR, CPC, CPM, ROMI.
3. For each `utm_campaign` in each month, it adds new fields to calculate the percentage difference in CPM, CTR, and ROMI from the previous month.


# Summary

By completing these tasks, I enhanced my skills in data extraction, aggregation, and transformation for BI reporting. I learned to calculate and analyze key marketing metrics such as conversion rates, ROMI, CPC, CPM, and CTR, gaining insights into user behavior across different campaigns and traffic sources. Additionally, developed proficiency in creating comprehensive dashboards to visualize these metrics effectively, utilizing SQL constructs such as CTEs (Common Table Expressions), window functions, and joins.

