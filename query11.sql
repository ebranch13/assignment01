/*
    What is the average distance (rounded to the nearest km) of all stations
    from Meyerson Hall? Use latitude 39.952415 and longitude -75.192584 Your result should have a single record with a single
    column named avg_distance_km.
*/

-- Enter your SQL query here
select round(avg(st_distance(
    st_makepoint(start_lon, start_lat)::geography,
    st_makepoint(-75.192584, 39.952415)::geography
)) / 1000) as avg_distance_km
from (
    select distinct start_lat, start_lon
    from indego.trips_2021_q3
    where start_lat is not null and start_lon is not null
    union
    select distinct start_lat, start_lon
    from indego.trips_2022_q3
    where start_lat is not null and start_lon is not null
) as stations;

