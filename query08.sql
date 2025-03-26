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

SELECT 
    start_station AS station_id, 
    ss.geog AS station_geog, 
    COUNT(*) AS num_trips
FROM indego.trips ts
JOIN indego.station_statuses ss 
    ON ts.start_station = CAST(ss.id AS TEXT)
WHERE EXTRACT(HOUR FROM ts.start_time) BETWEEN 7 AND 9
GROUP BY start_station, ss.geog
ORDER BY num_trips DESC
LIMIT 5;
