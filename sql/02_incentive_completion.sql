-- Question: Are incentivized trips completed more often than non-incentivized ones?
-- Tables: fact_trips
-- Metric: completion rate by incentive group
-- Approach:
-- 1) Create incentive_group (incentivized vs not)
-- 2) Aggregate total + completed
-- 3) Compute completion rate

SELECT 
CASE
WHEN incentive_id IS NOT NULL THEN 'incentivized'
ELSE 'not incentivized'
END AS incentive_group,
COUNT(*) AS total_groups,
COUNTIF(status = 'completed') AS completed_trips,
SAFE_DIVIDE(COUNTIF(status='completed'), COUNT(*)) AS completion_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_trips`
GROUP BY incentive_group
ORDER BY incentive_group;