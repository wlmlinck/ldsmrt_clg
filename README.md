# ldsmrt_clg
Loadsmart AE Challenge

This is the ReadMe file for the Analytics Engineer Challenge from Loadsmart.
It's based on three questions, which are disposed below.

1. Build a dimensional data model in a database of your choosing, so it can hold the data set we sent you
and make data analysis available through SQL.

The database used for this stage was Snowflake. As received, the csv-file which contained the data for this challenge was uploaded into Snowflake.
To make things a little bit more easier in the transformation stage, I set the types of most columns, using the code below:

    create table "LDSMRTCLG"."PUBLIC"."RAW" (
    loadsmart_id varchar,
    lane text,
    quote_date varchar,
    book_date varchar,
    source_date varchar,
    pickup_date varchar,
    delivery_date varchar,
    book_price numeric,
    source_price numeric,
    pnl numeric,
    mileage numeric,
    equipment_type varchar,
    carrier_rating varchar,
    sourcing_channel text,
    vip_carrier boolean,
    carrier_dropped_us_count varchar,
    carrier_name text,
    shipper_name text,
    carrier_on_time_to_pickup boolean,
    carrier_on_time_to_delivery boolean,
    carrier_on_time_overall boolean,
    pickup_appointment_time varchar,
    delivery_appointment_time varchar,
    has_mobile_app_tracking boolean,    
    has_macropoint_tracking boolean,
    has_edi_tracking boolean,
    contracted_load boolean,    
    load_booked_autonomously boolean,
    load_sourced_autonomously boolean,
    load_was_cancelled boolean
);

I should point out that all the date columns were originally set as Timestamp, but I kept getting an error that Snowflake didn't recognize the timestamp type for the
date-time columns as there were missing the seconds part of it. So, I set it as varchar to adjust it directly into DBT. I named this file as 'RAW'.

2. Load the data from the data set to the database model you've created, using any open source ETL tool or
Python, but dbt(data build tool) is preferred and is a great plus!

This stage was made entirely using DBT and GIT, all executed in a VS Code terminal.
