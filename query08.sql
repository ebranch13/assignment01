/*
    Give the five most popular starting stations across all years between 7am
    and 9:59am.

    Your result should have 5 records with three columns, one for the station id
    (named `station_id`), one for the point geography of the station (named
    `station_geog`), and one for the number of trips that started at that
    station (named `num_trips`).
*/

-- Enter your SQL query here



select 
    station_id, 
    station_geog, 
    count(*) as num_trips
from (
    select 
        ts.start_station as station_id, 
        ss.geog::geography as station_geog,  
        ts.start_time
    from indego.trips_2021_q3 ts
    join indego.station_statuses ss 
        on ts.start_station = ss.id::text 
    where extract(hour from ts.start_time) >= 7
    and extract(hour from ts.start_time) < 10  
    union all
    select 
        ts.start_station as station_id, 
        ss.geog::geography as station_geog,  
        ts.start_time
    from indego.trips_2022_q3 ts
    join indego.station_statuses ss 
        on ts.start_station = ss.id::text  
    where extract(hour from ts.start_time) >= 7
    and extract(hour from ts.start_time) < 10
) as union_result 
group by station_id, station_geog 
order by num_trips desc
limit 5;

