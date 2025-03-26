/*
    How many stations are within 1km of Meyerson Hall? Use latitude 39.952415 and longitude -75.192584

    Your query should have a single record with a single attribute, the number
    of stations (num_stations).
*/

-- Enter your SQL query here

select count(*) as num_stations
from (
    select distinct start_lat, start_lon
    from indego.trips_2021_q3
    where start_lat is not null and start_lon is not null
    union
    select distinct start_lat, start_lon
    from indego.trips_2022_q3
    where start_lat is not null and start_lon is not null
) as stations
where st_distance(
    st_makepoint(start_lon, start_lat)::geography,
    st_makepoint(-75.192584, 39.952415)::geography
) <= 1000;
