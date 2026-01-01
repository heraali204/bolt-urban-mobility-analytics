-- Question: Are higher surge trips cancelled more often?
-- Tables: fact_trips
-- MetricL cancellation rate by surge bucket
-- Approach:
-- 1) Create surge buckets (CASE)
-- 2) Aggregate counts per bucket (total, cancelled, completed)
-- 3) Compute cancellation rate (cancelled / total)

SELECT 
CASE
WHEN surge_multiplier < 1.2 THEN 'low surge'
WHEN surge_multiplier < 1.5 THEN 'medium surge'
WHEN surge_multiplier < 2.0 THEN 'high surge'
ELSE 'very high surge'
END AS surge_bucket,
COUNT(*) AS total_trips,
COUNTIF(status != 'completed') AS cancelled_trips,
SAFE_DIVIDE(COUNTIF(status!='completed'), COUNT(*)) AS cancellation_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_trips`
GROUP BY surge_bucket
ORDER BY total_trips;