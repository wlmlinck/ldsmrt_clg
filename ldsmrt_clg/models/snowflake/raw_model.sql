
with raw_source as (
    select * from  {{source('ldsmrt_clg','RAW')}} 
)

select * from raw_source 