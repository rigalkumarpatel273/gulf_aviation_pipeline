-- 1. Create Dimension Table for Gulf Airports
CREATE TABLE IF NOT EXISTS dim_airports (
    hub_code VARCHAR(10) PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude NUMERIC(8,4) NOT NULL,
    longitude NUMERIC(8,4) NOT NULL
);

-- Seed static hub airport metadata
INSERT INTO dim_airports (hub_code, airport_name, city, country, latitude, longitude)
VALUES 
    ('DXB', 'Dubai International Airport', 'Dubai', 'United Arab Emirates', 25.2532, 55.3657),
    ('AUH', 'Zayed International Airport', 'Abu Dhabi', 'United Arab Emirates', 24.4330, 54.6511),
    ('DOH', 'Hamad International Airport', 'Doha', 'Qatar', 25.2731, 51.6081),
    ('RUH', 'King Khalid International Airport', 'Riyadh', 'Saudi Arabia', 24.9576, 46.6988)
ON CONFLICT (hub_code) DO NOTHING;

-- 2. Create Fact Table for Telemetry Snapshots
CREATE TABLE IF NOT EXISTS fact_flight_states (
    state_id SERIAL PRIMARY KEY,
    icao24 VARCHAR(10) NOT NULL,
    callsign VARCHAR(20),
    origin_country VARCHAR(50),
    snapshot_time TIMESTAMP WITH TIME ZONE NOT NULL,
    latitude NUMERIC(8,4),
    longitude NUMERIC(8,4),
    altitude_ft NUMERIC(10,2),
    velocity_knots NUMERIC(10,2),
    vertical_rate_fpm NUMERIC(10,2),
    on_ground BOOLEAN,
    flight_status VARCHAR(20),
    nearest_hub VARCHAR(10) REFERENCES dim_airports(hub_code),
    dist_to_hub_km NUMERIC(10,2)
);
