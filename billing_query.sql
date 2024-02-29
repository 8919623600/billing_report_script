create or replace procedure demo.test_stored_proc (app_name string)

BEGIN

EXPORT DATA OPTIONS (
  url='gs://bucket/folder/*.csv' ,
   format='CSV' ,
   overwrite=true,
   header=true,
   field_delimiter=',') AS
SELECT billing_account_id, currency,SUM(cost) as total_cost,labels.value as Application
FROM 'billing_info.gcp_billing_export_xyz_abc'
LEFT JOIN UNNEST (labels) as labels
  ON labels.value = app_name
WHERE
cast (usage_start_time as date) >= date_add(current_date(), INTERNAL -8 day)
and cast (usage_end_time as date) <= date_add (current_date(), INTERVAL -2 day)
GROUP BY Application,billing_account_id,currency;


END;
