-- Question: What does the funnel look like (request -> pickup -> completion)?
-- Tables: fact_trips
-- Metric: funnel counts and rates
-- Approach:
-- 1) Define stages (requested, picked_up, completed)
-- 2) Count each stage + compute stage rates

SELECT COUNT(*) AS requested_trips,
COUNTIF(pickup_date_id IS NOT NULL) AS picked_up_trips,
COUNTIF(status = 'completed') AS completed_trips,
SAFE_DIVIDE(COUNTIF(pickup_date_id IS NOT NULL), COUNT(*)) AS request_to_pickup_rate,
SAFE_DIVIDE(COUNTIF(status = 'completed'), COUNT(*)) AS request_to_completion_rate
FROM `cogent-presence-482914-s0.bolt_urban_mobility.fact_trips`;