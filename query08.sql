/*
    Give the five most popular starting stations across all years between 7am
    and 9:59am.

    Your result should have 5 records with three columns, one for the station id
    (named `station_id`), one for the point geography of the station (named
    `station_geog`), and one for the number of trips that started at that
    station (named `num_trips`).
*/

-- Enter your SQL query here


/*
    Hint: Use the `EXTRACT` function to get the hour of the day from the
    timestamp.
*/


-- SELECT 
--     station_id, 
--     station_geog, 
--     SUM(num_trips) AS num_trips
-- FROM (
--     SELECT 
--         ts.start_station AS station_id, 
--         ss.geog AS station_geog, 
--         COUNT(*) AS num_trips
--     FROM indego.trips_2021_q3 ts
--     JOIN indego.station_statuses ss 
--         ON ts.start_station = CAST(ss.id AS TEXT)
--     WHERE EXTRACT(HOUR FROM ts.start_time) BETWEEN 7 AND 9
--     GROUP BY ts.start_station, ss.geog

--     UNION ALL
     
--     SELECT 
--         ts.start_station AS station_id, 
--         ss.geog AS station_geog, 
--         COUNT(*) AS num_trips
--     FROM indego.trips_2022_q3 ts
--     JOIN indego.station_statuses ss 
--         ON ts.start_station = CAST(ss.id AS TEXT)
--     WHERE EXTRACT(HOUR FROM ts.start_time) BETWEEN 7 AND 9
--     GROUP BY ts.start_station, ss.geog
-- ) AS union_result 
-- GROUP BY station_id, station_geog 
-- ORDER BY num_trips DESC
-- LIMIT 5;

select 
    station_id, 
    station_geog, 
    count(*) as num_trips
from (
    select 
        ts.start_station as station_id, 
        ss.geog::geography as station_geog,  -- ensure geography type
        ts.start_time
    from indego.trips_2021_q3 ts
    join indego.station_statuses ss 
        on ts.start_station = ss.id::text  -- ensure correct type matching
    where extract(hour from ts.start_time) >= 7
    and extract(hour from ts.start_time) < 10  -- ensures 9:59am is included
    union all
    select 
        ts.start_station as station_id, 
        ss.geog::geography as station_geog,  -- ensure geography type
        ts.start_time
    from indego.trips_2022_q3 ts
    join indego.station_statuses ss 
        on ts.start_station = ss.id::text  -- ensure correct type matching
    where extract(hour from ts.start_time) >= 7
    and extract(hour from ts.start_time) < 10
) as union_result 
group by station_id, station_geog 
order by num_trips desc
limit 5;

