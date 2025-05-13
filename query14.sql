/*
    Which station is closest to Meyerson Hall? Use latitude 39.952415 and longitude -75.192584.

    Your query should return only one line, and only give the station id
    (station_id), station name (station_name), and distance (distance) from
    Meyerson Hall, rounded to the nearest 50 meters.
*/

-- Enter your SQL query here

SELECT 
    start_station AS station_id, 
    start_station AS station_name, 
    ROUND(
        ST_Distance(
            ST_MakePoint(start_lon, start_lat)::geography, 
            ST_MakePoint(-75.192584, 39.952415)::geography
        ) / 50
    ) * 50 AS distance
FROM (
    SELECT DISTINCT start_station, start_lat, start_lon
    FROM indego.trips_2021_q3
    WHERE start_lat IS NOT NULL AND start_lon IS NOT NULL
    UNION
    SELECT DISTINCT start_station, start_lat, start_lon
    FROM indego.trips_2022_q3
    WHERE start_lat IS NOT NULL AND start_lon IS NOT NULL
) AS stations
ORDER BY distance ASC
LIMIT 1;
