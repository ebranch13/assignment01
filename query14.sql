/*
    Which station is closest to Meyerson Hall? Use latitude 39.952415 and longitude -75.192584.

    Your query should return only one line, and only give the station id
    (station_id), station name (station_name), and distance (distance) from
    Meyerson Hall, rounded to the nearest 50 meters.
*/

-- Enter your SQL query here

-- select start_station as station_id, 
--        start_station as station_name, 
--        round(st_distance(
--            st_makepoint(start_lon, start_lat)::geography, 
--            st_makepoint(-75.192584, 39.952415)::geography
--        ) / 50) * 50 as distance
-- from (
--     select distinct start_station, start_lat, start_lon
--     from indego.trips_2021_q3
--     where start_lat is not null and start_lon is not null
--     union
--     select distinct start_station, start_lat, start_lon
--     from indego.trips_2022_q3
--     where start_lat is not null and start_lon is not null
-- ) as stations
-- order by distance asc
-- limit 1;

select 
    start_station as station_id, 
    start_station as station_name, 
    round(st_distance(
        st_makepoint(start_lon, start_lat)::geography, 
        st_makepoint(-75.192584, 39.952415)::geography
    ) / 50) * 50 as distance
from (
    select distinct start_station, start_lat, start_lon
    from indego.trips_2021_q3
    where start_lat is not null and start_lon is not null
    union
    select distinct start_station, start_lat, start_lon
    from indego.trips_2022_q3
    where start_lat is not null and start_lon is not null
) as stations
order by distance asc
limit 1;
