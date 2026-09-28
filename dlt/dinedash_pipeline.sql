-- DineDash Lakeflow Declarative Pipeline / Delta Live Tables SQL
-- Source data is expected under the orders folder. The case study starts with
-- January-June data and then adds July-August and the remaining monthly files.
-- Replace the placeholder path with your Databricks Volume path.

CREATE OR REFRESH STREAMING TABLE orders_bronze_stream
AS
SELECT
  *,
  current_timestamp() AS pipeline_ingestion_timestamp,
  _metadata.file_path AS source_file_name
FROM STREAM read_files(
  '/Volumes/<catalog>/<schema>/dinedash_volume/orders/',
  format => 'csv',
  header => true,
  inferSchema => true
);

-- Silver-quality order records used by the downstream analytical tables.
CREATE OR REFRESH STREAMING TABLE orders_silver
AS
SELECT *
FROM STREAM orders_bronze_stream
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND restaurant_id IS NOT NULL;

-- Dashboard KPI: total orders by restaurant.
CREATE OR REFRESH MATERIALIZED VIEW total_orders_per_restaurant
AS
SELECT
  restaurant_id,
  COUNT(*) AS total_orders,
  ROUND(SUM(total_amount), 2) AS total_revenue,
  ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders_silver
GROUP BY restaurant_id;

-- Q13: Top 10 customers by number of distinct restaurants ordered from.
CREATE OR REFRESH MATERIALIZED VIEW q13_top_10_customer_restaurant_variety
AS
SELECT
  customer_id,
  COUNT(DISTINCT restaurant_id) AS distinct_restaurants
FROM orders_silver
GROUP BY customer_id
ORDER BY distinct_restaurants DESC
LIMIT 10;

-- Q14: Restaurants with frequent repeat customers.
CREATE OR REFRESH MATERIALIZED VIEW q14_repeat_customers
AS
SELECT
  restaurant_id,
  customer_id,
  COUNT(*) AS customer_order_count
FROM orders_silver
GROUP BY restaurant_id, customer_id
HAVING COUNT(*) > 1
ORDER BY customer_order_count DESC;

-- Q15: Preferred payment methods for high-value orders across cuisines.
-- The restaurant-to-cuisine mapping is assumed to be available in a Delta
-- table created from the restaurant dataset during the ingestion stage.
CREATE OR REFRESH MATERIALIZED VIEW q15_high_value_payment_by_cuisine
AS
SELECT
  r.cuisine,
  o.payment_method,
  COUNT(*) AS high_value_orders
FROM orders_silver o
JOIN <catalog>.<schema>.restaurants_filtered r
  ON o.restaurant_id = r.restaurant_id
WHERE o.total_amount > 40
GROUP BY r.cuisine, o.payment_method;
