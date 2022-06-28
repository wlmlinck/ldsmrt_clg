
with raw_source --Single selection to get the raw data from the source.

as (  
    select * from  {{source('ldsmrt_clg','RAW')}} 
),

first_cleaning_timestamp

--The goal in this part is just to establish the correct type of the columns.
--I couldn't set the timestamp correctly on Snowflake, because some dates were missing the seconds part.

as ( 
    select  loadsmart_id as id,
            lane,
            to_timestamp(quote_date, 'MM/DD/YYYY HH24:MI') as quote_date,
            to_timestamp(book_date, 'MM/DD/YYYY HH24:MI') as book_date,
            to_timestamp(source_date, 'MM/DD/YYYY HH24:MI') as source_date,
            to_timestamp(pickup_date, 'MM/DD/YYYY HH24:MI') as pickup_date,
            to_timestamp(delivery_date, 'MM/DD/YYYY HH24:MI') as delivery_date,
            book_price,
            source_price,
            pnl,
            mileage,
            equipment_type,
            carrier_rating,
            sourcing_channel,
            vip_carrier,
            carrier_dropped_us_count,
            carrier_name,
            shipper_name,
            carrier_on_time_to_pickup,
            carrier_on_time_to_delivery,
            carrier_on_time_overall,
            to_timestamp(pickup_appointment_time, 'MM/DD/YYYY HH24:MI') as pickup_appointment_time,
            to_timestamp(delivery_appointment_time, 'MM/DD/YYYY HH24:MI') as delivery_appointment_time,
            has_mobile_app_tracking,    
            has_macropoint_tracking,
            has_edi_tracking,
            contracted_load,    
            load_booked_autonomously,
            load_sourced_autonomously,
            load_was_cancelled 

    from raw_source
),

second_cleaning_removal

-- In this part let's remove a few columns which informations are incomplete.
-- Here they are: carrier_rating, sourcing_channel.
-- Also, some booleans at the end of the table are all false, so these informations are not relevant in the clean view.
-- Here they are: has_mobile_app_tracking, has_macropoint_tracking, has_edi_tracking, contracted_load, 
-- load_booked_autonomously, load_sourced_autonomously, load_was_cancelled. 

as (
    select  id,
            lane,
            quote_date,
            book_date,
            source_date,
            pickup_date,
            delivery_date,
            book_price,
            source_price,
            pnl,
            mileage,
            equipment_type,
            vip_carrier,
            carrier_dropped_us_count,
            carrier_name,
            shipper_name,
            carrier_on_time_to_pickup,
            carrier_on_time_to_delivery,
            carrier_on_time_overall,
            pickup_appointment_time,
            delivery_appointment_time

from first_cleaning_timestamp

),

final_cleaning_creation

-- In this part some news columns are created, especially from the Lane information.
-- So, after this we should have: 
    -- sender_location: the sender's full location
    -- receiver_location: the receiver's full location
    -- sender_state: the sender's state
    -- receiver_state: the receiver's state
-- Also, the carrier and shipper names should turn into numbers only, as:
    -- cd_carrier: carrier's code
    -- cd_shipper: shipper's code

as ( 
    select  id,
            concat(left(lane,charindex(' ->',lane)-1),',USA') as sender_location,
            concat(right(lane,(len(lane) - charindex('>',lane))),',USA') as receiver_location,
            right(left(lane,charindex(' ->',lane)-1),2) as sender_state,
            right(lane,2) as receiver_state,
            mileage,
            quote_date,
            book_date,
            source_date,
            pickup_date,
            delivery_date,
            book_price,
            source_price,
            pnl,
            equipment_type,
            vip_carrier,
            carrier_dropped_us_count,
            right(carrier_name,(len(carrier_name) - charindex(' ',carrier_name))) as cd_carrier,
            right(shipper_name,(len(shipper_name) - charindex(' ',shipper_name))) as cd_shipper,
            carrier_on_time_to_pickup,
            carrier_on_time_to_delivery,
            carrier_on_time_overall,
            pickup_appointment_time,
            delivery_appointment_time


from second_cleaning_removal

)

select * from final_cleaning_creation
