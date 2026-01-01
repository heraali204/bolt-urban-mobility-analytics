-- Question: Did "Upfront ETA Transparency" improve conversion?
-- Tables: fact_experiment_events, dim_experiment
-- Metric: Conversion rate by variant
-- Approach:
-- 1) Filter to the ETA experiment
-- 2) Group by variant (control/treatment)
-- 3) Compute conversion rate

SELECT 
e.feature_name,
f.variant,
COUNT(*) AS exposed_users,
COUNTIF(f.conversion_flag = 1) AS conversions,
SAFE_DIVIDE(COUNTIF(f.conversion_flag=1), COUNT(*)) AS conversion_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_experiment_events` f
JOIN `cogent-presence-482914-s0.bolt_urban_mobility.dim_experiment` e
ON f.experiment_id = e.experiment_id
WHERE e.feature_name = 'Upfront ETA Transparency'
GROUP BY e.feature_name, f.variant
ORDER BY f.variant;