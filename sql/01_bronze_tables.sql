-- DineDash Bronze ingestion
-- Update /Volumes/<catalog>/<schema>/dinedash_volume/ to your Databricks Volume.

CREATE OR REPLACE TABLE customers_bronze AS
SELECT
  current_timestamp() AS ingestion_timestamp,
  _metadata.file_name AS source_file_name,
  CAST(customer_id AS STRING) AS customer_id,
  CAST(name AS STRING) AS name,
  CAST(email AS STRING) AS email,
  CAST(signup_date AS DATE) AS signup_date,
  CAST(dob AS DATE) AS dob,
  CAST(location_id AS STRING) AS location_id
FROM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/customers.csv',
  format => 'csv',
  header => true,
  inferSchema => false
);

CREATE OR REPLACE TABLE restaurants_bronze AS
SELECT
  current_timestamp() AS ingestion_timestamp,
  _metadata.file_name AS source_file_name,
  CAST(restaurant_id AS STRING) AS restaurant_id,
  CAST(name AS STRING) AS name,
  CAST(cuisine AS STRING) AS cuisine,
  CAST(location_id AS STRING) AS location_id,
  CAST(rating AS DOUBLE) AS rating,
  CAST(delivery_fee AS DOUBLE) AS delivery_fee
FROM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/restaurants.csv',
  format => 'csv',
  header => true,
  inferSchema => false
);

CREATE OR REPLACE TABLE locations_bronze AS
SELECT
  current_timestamp() AS ingestion_timestamp,
  _metadata.file_name AS source_file_name,
  CAST(location_id AS STRING) AS location_id,
  CAST(area AS STRING) AS area,
  CAST(city AS STRING) AS city,
  CAST(state AS STRING) AS state,
  CAST(latitude AS DOUBLE) AS latitude,
  CAST(longitude AS DOUBLE) AS longitude
FROM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/locations.csv',
  format => 'csv',
  header => true,
  inferSchema => false
);

CREATE OR REPLACE TABLE delivery_agents_bronze AS
SELECT
  current_timestamp() AS ingestion_timestamp,
  _metadata.file_name AS source_file_name,
  CAST(agent_id AS STRING) AS agent_id,
  CAST(name AS STRING) AS name,
  CAST(phone AS STRING) AS phone,
  CAST(rating AS DOUBLE) AS rating
FROM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/delivery_agents.csv',
  format => 'csv',
  header => true,
  inferSchema => false
);

CREATE OR REPLACE TABLE menu_items_bronze AS
SELECT
  current_timestamp() AS ingestion_timestamp,
  _metadata.file_name AS source_file_name,
  CAST(item_id AS STRING) AS item_id,
  CAST(restaurant_id AS STRING) AS restaurant_id,
  CAST(item_name AS STRING) AS item_name,
  CAST(price AS DOUBLE) AS price,
  CAST(category AS STRING) AS category
FROM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/menu_items.csv',
  format => 'csv',
  header => true,
  inferSchema => false
);

-- Orders are intentionally loaded incrementally because the case study supplies monthly files.
-- Run COPY INTO once per arriving month; Databricks tracks already-loaded files.
CREATE TABLE IF NOT EXISTS orders_bronze;

COPY INTO orders_bronze
FROM '/Volumes/<catalog>/<schema>/dinedash_volume/orders/'
FILEFORMAT = CSV
FORMAT_OPTIONS ('header' = 'true', 'inferSchema' = 'true')
COPY_OPTIONS ('mergeSchema' = 'true');

-- Validation
SELECT COUNT(*) AS orders_loaded FROM orders_bronze;
SELECT source_file_name, COUNT(*) AS records_loaded
FROM orders_bronze
GROUP BY source_file_name
ORDER BY source_file_name;
