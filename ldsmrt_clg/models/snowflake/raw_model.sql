
with raw_source as (
    select * from {{ source('ldsmrt_clg','raw') }}
)

select * from raw_source 