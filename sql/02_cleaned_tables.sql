-- DineDash cleaned / filtered Delta tables

CREATE OR REPLACE TABLE customers_filtered AS
SELECT *
FROM customers_bronze
WHERE customer_id IS NOT NULL
  AND location_id IS NOT NULL
  AND signup_date IS NOT NULL
  AND dob IS NOT NULL
  AND email IS NOT NULL
  AND name IS NOT NULL;

CREATE OR REPLACE TABLE restaurants_filtered AS
SELECT *
FROM restaurants_bronze
WHERE restaurant_id IS NOT NULL
  AND name IS NOT NULL
  AND cuisine IS NOT NULL
  AND location_id IS NOT NULL
  AND rating IS NOT NULL
  AND delivery_fee IS NOT NULL;

CREATE OR REPLACE TABLE locations_filtered AS
SELECT *
FROM locations_bronze
WHERE location_id IS NOT NULL
  AND area IS NOT NULL
  AND city IS NOT NULL
  AND state IS NOT NULL
  AND latitude IS NOT NULL
  AND longitude IS NOT NULL;

CREATE OR REPLACE TABLE delivery_agents_filtered AS
SELECT *
FROM delivery_agents_bronze
WHERE agent_id IS NOT NULL
  AND name IS NOT NULL
  AND phone IS NOT NULL
  AND rating IS NOT NULL;

CREATE OR REPLACE TABLE menu_items_filtered AS
SELECT *
FROM menu_items_bronze
WHERE item_id IS NOT NULL
  AND restaurant_id IS NOT NULL
  AND item_name IS NOT NULL
  AND price IS NOT NULL
  AND category IS NOT NULL;
