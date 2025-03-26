/*
    What is the longest duration trip across the two quarters?

    Your result should have a single row with a single column named max_duration.
*/

-- Enter your SQL query here

select greatest(
    (select max(duration) from indego.trips_2021_q3),
    (select max(duration) from indego.trips_2022_q3)
) as max_duration;