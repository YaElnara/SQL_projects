CREATE OR REPLACE FUNCTION public.decode_url_elnara(p varchar) RETURNS varchar AS $$
SELECT 
convert_from(
CAST(E'\\x' || string_agg(
      CASE WHEN length (r.m[1]) = 1 THEN encode (convert_to(r.m[1],  'SQL_ASCII'), 'hex') 
      ELSE substring (r.m[1] FROM 2 FOR 2) END, '') AS bytea), 'UTF8' )
FROM regexp_matches($1, '%[0-9a-f][0-9a-f]|.', 'gi')  AS r(m);
$$ Language SQL IMMUTABLE STRICT;

SELECT public.decode_url_elnara(url_parameters) 
FROM facebook_ads_basic_daily fabd 

 
