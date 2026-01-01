-- Question: Do completion/cancellation outcomes differ by product type?
-- Tables: fact_trips, dim_product
-- Approach:
-- 1) Join trips -> product
-- 2) Group by product_type
-- 3) Conditional counts for statuses + rates

SELECT
  p.product_type,
  COUNT(*) AS total_trips,
  COUNTIF(t.status = 'completed') AS completed_trips,
  COUNTIF(t.status = 'cancelled_user') AS cancelled_user_trips,
  COUNTIF(t.status = 'cancelled_driver') AS cancelled_driver_trips,
  SAFE_DIVIDE(COUNTIF(t.status = 'completed'), COUNT(*)) AS completion_rate,
  SAFE_DIVIDE(COUNTIF(t.status != 'completed'), COUNT(*)) AS cancellation_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_trips` t
JOIN `cogent-presence-482914-s0.bolt_urban_mobility.dim_product` p
  ON t.product_id = p.product_id
GROUP BY p.product_type
ORDER BY p.product_type;