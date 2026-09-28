-- Remaining case-study analysis questions only.
-- Questions 1-12 are intentionally excluded.

-- Q13: Top 10 customers who ordered from the widest variety of restaurants.
SELECT
  customer_id,
  COUNT(DISTINCT restaurant_id) AS distinct_restaurants
FROM orders_bronze
GROUP BY customer_id
ORDER BY distinct_restaurants DESC
LIMIT 10;

-- Q14: Restaurants with frequent repeat customers.
SELECT
  restaurant_id,
  customer_id,
  COUNT(*) AS customer_order_count
FROM orders_bronze
GROUP BY restaurant_id, customer_id
HAVING COUNT(*) > 1
ORDER BY customer_order_count DESC;

-- Q15: Preferred payment methods for high-value orders across cuisines.
SELECT
  r.cuisine,
  o.payment_method,
  COUNT(*) AS high_value_orders
FROM orders_bronze o
JOIN restaurants_filtered r
  ON o.restaurant_id = r.restaurant_id
WHERE o.total_amount > 40
GROUP BY r.cuisine, o.payment_method
ORDER BY r.cuisine, high_value_orders DESC;
