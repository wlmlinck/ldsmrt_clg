with final_cleaning

-- Selection from the cleaning model.

as (
    select * from {{ ref('cleaning_model') }}
),

first_refining_boolean 

-- Refine the booleans which aim to calculate the deadlines' success.
-- True/False becomes Yes/No for better dataviz on PowerBI

as (
    select  *, 
            case 
                when carrier_on_time_to_pickup = true 
                then 'Yes'
                else 'No'
            end  as carrier_on_time_to_pickup_yes_no,
                case 
                    when carrier_on_time_to_delivery = true 
                    then 'Yes'
                    else 'No'
                end  as carrier_on_time_to_delivery_yes_no,
                    case  
                        when carrier_on_time_overall = true 
                        then 'Yes'
                        else 'No'
                    end  as carrier_on_time_overall_yes_no

    from final_cleaning
),

final_refining

-- This part is for calculations of leadtimes:
    -- Book_Date to Pickup_Date
    -- Pickup_Date to Delivery_Date
    -- Quote_Date to Delivery_Date
    -- Book_Date to Delivery_Date


as (
    select  *,
            datediff(day, book_date, pickup_date) as leadtime_book_to_pickup,
            datediff(day, pickup_date, delivery_date) as leadtime_pickup_to_delivery,
            datediff(day, quote_date, delivery_date) as leadtime_quote_to_delivery,
            datediff(day, book_date, delivery_date) as leadtime_book_to_delivery

    from first_refining_boolean 
)

select * from final_refining