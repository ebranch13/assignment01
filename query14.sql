/*
    Which station is closest to Meyerson Hall? Use latitude 39.952415 and longitude -75.192584.

    Your query should return only one line, and only give the station id
    (station_id), station name (station_name), and distance (distance) from
    Meyerson Hall, rounded to the nearest 50 meters.
*/

-- Enter your SQL query here

SELECT
    station_statuses.id AS station_id,
    station_statuses.name AS station_name,
    ROUND(
        ST_DISTANCE(
            indego.station_statuses.geog,
            ST_SETSRID(ST_MAKEPOINT(-75.192584, 39.952415), 4326)::geography
        ) / 50
    ) * 50 AS distance

FROM indego.station_statuses
ORDER BY distance ASC
LIMIT 1;
