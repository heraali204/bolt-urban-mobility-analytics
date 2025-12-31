# Data Validation & Exploration Notes

This document captures intermediate validation checks and exploratory findings used to build confidence in the data before formal analysis.
These notes are not final deliverables, but support the analytical rigor behind the conclusions presented in the README.

## dim_city
- Total cities: 10
- Tier 1: 7
- Tier 2: 3
- All cities belong to Country_A
- Distribution looks reasonable

## dim_date
- Date range: Jan 1, 2024 – Mar 31, 2024
- Total days: 91
- No missing dates

## dim_user
- Total users: 200
- Signups per month: jan - 65, feb - 67, mar - 68
- Channel distribution: organic - 65, paid - 67, referral - 68
- No missing or duplicate users
- Data looks consistent and usable

## dim_driver
- Total drivers: 50
- Drivers per city: non-uniform distribution
	- City 10 → 11 drivers
	- City 1 → 8 drivers
	- Some cities → 1–5 drivers
- Some cities act as supply hubs
- Active vs inactive drivers: All drivers active

## dim_product
- 3 products: ride_hailing, scooter, ebike
- One row per product_type
- Dimension is clean and consistent

## dim_incentive
- 2 incentive programs
- Types: discount, cashback
- Both target users
- Incentive coverage is consistent across data range

## dim_experiment
- 2 experiments defined
- Both span Jan–Mar 2024
- Feature metadata complete and consistent

## fact_trips
- Total trips: 2,000
- Completion rate ~79%
- User cancellations higher than driver cancellations
- Trips present for every day in Jan–Mar 2024
- Daily demand shows realistic variation with no gaps

## Trips by product
- Trips are evenly distributed across ride_hailing, scooter, and ebike
- No product dominates volume
- Suitable for comparative product analysis

## Trips by city tier
- Tier 1 cities account for ~68% of trips
- Tier 2 cities account for ~32% of trips
- Demand is concentrated in larger markets, as expected

## Completion & cancellation by city tier
- Completion rates are similar across Tier 1 (~80%) and Tier 2 (~79%)
- User cancellations significantly exceed driver cancellations in both tiers
- No major operational degradation observed in Tier 2 cities

## Driver Context
- Ride-hailing → human driver
- Scooter → fleet unit / operator / rebalancing agent
- E-bike → fleet asset owner

## Cancellation vs surge multiplier
- Cancellation rates rise as surge increases from low to high
- Very high surge does not significantly exceed high surge cancellation rates
- Suggests price sensitivity up to a threshold, after which remaining users are more committed

## Incentive impact on completion
- Completion rates are nearly identical for incentivized and non-incentivized trips (~79%)
- Incentives do not significantly improve trip completion
- Suggests incentives influence demand, not operational execution

## Validation Summary
- All core dimensions validated
- No missing keys or date gaps detected
- Fact tables internally consistent
- Data deemed fit for product and experiment analysis