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
All the codes used in the integration of dbt and snowflake are in the ldsmrt_clg file.

First of all, dbt is run by models. So, to transform the raw data into a final view, three models were created. They are located in ldsmrt/models/snowflake.
- Cleaning Model: this model is set to clean data and make the dataframe quicker to run.
- Refining Model: this model aimed to refine a little a few columns, as taking just the code out of the carrier/shipper field, or creating some metrics.
- Final Model: this model is the representative of what's going to appear on PowerBI.
 
 After 'dbt run' on VS Code the views were created on Snowflake, as below.
 ![image](https://user-images.githubusercontent.com/87134636/176785959-624c350b-12ef-4284-9144-5392cb8d5816.png)

3. Provide a visual analysis so you can make a proof of concept of how your data model works, and how we
can use it, for a self-service data analysis. You can use any data visualization of your preference.

After the 2. was set and done, it was time to create a propper dashboard to analyse the data. For this stage I used PowerBI, as recommended.
To connect the database with PowerBI Desktop I used the Get Data tool, as below.

![image](https://user-images.githubusercontent.com/87134636/176786457-8cbbc3e9-a043-42d6-aea0-4a9268dba808.png)

I didn't use any PowerQuery editing or measure/dimension creation on PowerBI, as the dataframe was cleaned and refined by dbt modeling.
With the final version of the database, all it was left to do was to develop the dashboard itself.

It's safe to say that not all the information provided by the database were used on the dashboard. I judged what could be the best visualization with the data I had.
As I don't take part of the business, I might have missed a few important informations, but overall, the General Dashboard can bring a whole lot of awareness on
how many loads were done, the most common senders/receivers by US State, Carriers and Shippers information and total revenue. Here's a static print of how it looks:

![image](https://user-images.githubusercontent.com/87134636/176787042-5ca0ac90-05c5-4852-aaf4-f8b2e31b49a9.png)

PS. I took the liberty of using the colors as I find in Loadsmart's Website. It wasn't suppost to be any accurate, just to visualize it as a simulation of the company's routine.

Thanks,
William.




