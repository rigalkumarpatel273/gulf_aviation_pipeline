Select * from fact_flight_states LIMIT 20;

Select * from dim_airports;

-- 1. Hub Traffic Distribution
-- Provide a breakdown of the total number of telemetry records captured for each airport hub.
-- The final output should show the airport's official name, country, and the total count of flight records
-- associated with it, ordered from highest traffic volume to lowest.

Select da.airport_name, da.country, Count(*) as "Flight Records"
From fact_flight_states ffs
Inner join dim_airports da on ffs.nearest_hub = da.hub_code
Group by da.airport_name, da.country
Order by COUNT(*) DESC;

-- 2. Active Airspace Fleet Snapshot
-- Identify the unique fleet size currently being tracked in the region. Find the total number of unique 
-- aircraft (icao24) that have been recorded across the entire dataset, broken down by their current country 
-- of registration (origin_country).
Select COUNT(DISTINCT icao24), origin_country
From fact_flight_states
Group by origin_country
Order by COUNT(DISTINCT icao24) DESC;

-- 3. Hub Approach Congestion Analysis
-- Stakeholders want to identify which airport has the most aircraft currently on approach. For flights that
-- are actively categorized as Descending, find the average distance (dist_to_hub_km) and the maximum 
-- distance to their nearest hub, grouped by each airport code.

Select ROUND(AVG(dist_to_hub_km), 2), MAX(dist_to_hub_km), COUNT(nearest_hub), nearest_hub
from fact_flight_states
WHERE flight_status = 'Descending'
Group by nearest_hub
ORDER by COUNT(nearest_hub) DESC;

-- 4. High-Velocity Fleet Identification
-- Operational safety wants to flag fast-moving flights operating at lower altitudes. Find all unique flight 
-- callsigns that have been recorded traveling at a velocity greater than 400 knots while maintaining an 
-- altitude below 15,000 feet.

Select DISTINCT callsign
from fact_flight_states
where altitude_ft < 15000 AND velocity_knots > 400;

-- 5. Fleet Dynamic Tracking
-- For each unique aircraft callsign, extract its complete operational timeline. The output must display the
-- callsign, the snapshot timestamp, the altitude, and the flight status, ordered chronologically so we can 
-- visually trace a flight's transition from climbing to cruising or descending.

Select callsign, snapshot_time, altitude_ft, flight_status
from fact_flight_states
order by callsign, snapshot_time;