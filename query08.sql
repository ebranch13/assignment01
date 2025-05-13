/*
    Give the five most popular starting stations across all years between 7am
    and 9:59am.

    Your result should have 5 records with three columns, one for the station id
    (named `station_id`), one for the point geography of the station (named
    `station_geog`), and one for the number of trips that started at that
    station (named `num_trips`).
*/

-- Enter your SQL query here



SELECT 
    station_id, 
    station_geog, 
    COUNT(*) AS num_trips
FROM (
    SELECT 
        ts.start_station AS station_id, 
        ss.geog::geography AS station_geog,  
        ts.start_time
    FROM indego.trips_2021_q3 ts
    JOIN indego.station_statuses ss 
        ON ts.start_station = ss.id::text 
    WHERE EXTRACT(hour FROM ts.start_time) >= 7
      AND EXTRACT(hour FROM ts.start_time) < 10  
    UNION ALL
    SELECT 
        ts.start_station AS station_id, 
        ss.geog::geography AS station_geog,  
        ts.start_time
    FROM indego.trips_2022_q3 ts
    JOIN indego.station_statuses ss 
        ON ts.start_station = ss.id::text  
    WHERE EXTRACT(hour FROM ts.start_time) >= 7
      AND EXTRACT(hour FROM ts.start_time) < 10
) AS union_result 
GROUP BY station_id, station_geog 
ORDER BY num_trips DESC
LIMIT 5;

