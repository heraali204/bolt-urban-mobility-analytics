-- Question: How do completion/cancellation outcomes differ by city tier?
-- Tables: fact_trips, dim_city
-- Approach:
-- 1) Join trips -> city
-- 2) Group by city_tier
-- 3) Conditional counts for statuses + rates

SELECT
  c.city_tier,
  COUNT(*) AS total_trips,
  COUNTIF(t.status = 'completed') AS completed_trips,
  COUNTIF(t.status = 'cancelled_user') AS cancelled_user_trips,
  COUNTIF(t.status = 'cancelled_driver') AS cancelled_driver_trips,
  SAFE_DIVIDE(COUNTIF(t.status = 'completed'), COUNT(*)) AS completion_rate,
  SAFE_DIVIDE(COUNTIF(t.status != 'completed'), COUNT(*)) AS cancellation_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_trips` t
JOIN `cogent-presence-482914-s0.bolt_urban_mobility.dim_city` c
  ON t.city_id = c.city_id
GROUP BY c.city_tier
ORDER BY c.city_tier;