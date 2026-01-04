# KPI Measures (DAX)

Core DAX measures used in the **Urban Mobility Analytics** Power BI dashboard (Power BI Service).
Measures are grouped by report pages: **Executive Overview**, **Product & Ops**, **User Behavior**, **Experiments**.

> Notes
- Table names used: `fact_trips`, `dim_driver`, `dim_user`, `dim_city`, `dim_date`, `fact_user_daily_metrics`, `fact_driver_daily_metrics`, `fact_experiment_events`
- Status values assumed: `"completed"`, `"cancelled_user"`, `"cancelled_driver"`
- Incentive is considered “incentivized” when `fact_trips[incentive_id]` is not blank.

---

## Executive KPIs

### Total Trips
```DAX
Total Trips =
COUNT(fact_trips[trip_id])
```

### Completed Trips
```DAX
Completed Trips =
CALCULATE(
    [Total Trips],
    fact_trips[status] = "completed"
)
```

### Cancelled Trips
```DAX
Cancelled Trips =
CALCULATE(
    [Total Trips],
    fact_trips[status] IN { "cancelled_user", "cancelled_driver" }
)
```

### Completion Rate
```DAX
Completion Rate =
DIVIDE([Completed Trips], [Total Trips])
```

### Cancellation Rate
```DAX
Cancellation Rate =
DIVIDE([Cancelled Trips], [Total Trips])
```

### Completion Rate %
```DAX
Completion Rate % =
[Completion Rate] * 100
```

### Cancellation Rate %
```DAX
Cancellation Rate % =
[Cancellation Rate] * 100
```

## Revenue & Economics (Product & Ops)

### Total Fare Revenue
```DAX
Total Fare Revenue =
SUM(fact_trips[fare])
```

### Average Fare per Trip
```DAX
Avg Fare per Trip =
DIVIDE([Total Fare Revenue], [Total Trips])
```

### Average Distance per Trip
```DAX
Avg Distance per Trip =
AVERAGE(fact_trips[distance_km])
```

## Supply (Drivers)

### Registered Drivers
```DAX
Registered Drivers =
DISTINCTCOUNT(dim_driver[driver_id])
```

### Active Drivers
```DAX
Active Drivers =
CALCULATE(
    DISTINCTCOUNT(dim_driver[driver_id]),
    dim_driver[active_status] = TRUE()
)
```

### Trips per Active Drivers
```DAX
Trips per Active Driver =
DIVIDE([Total Trips], [Active Drivers])
```

## Coverage

### Cities Covered
```DAX
Cities Covered =
DISTINCTCOUNT(dim_city[city_id])
```
## Incentives

### Incentivized Trips
```DAX
Incentivized Trips =
CALCULATE(
    [Total Trips],
    NOT(ISBLANK(fact_trips[incentive_id]))
)
```
## Non-Incentivized Trips
```DAX
Non-Incentivized Trips =
CALCULATE(
    [Total Trips],
    ISBLANK(fact_trips[incentive_id])
)
```

### Incentivized Completion Rate
```DAX
Incentivized Completion Rate =
DIVIDE(
    CALCULATE([Completed Trips], NOT(ISBLANK(fact_trips[incentive_id]))),
    [Incentivized Trips]
)
```
### Non-incentivized Completion Rate
```DAX
Non-Incentivized Completion Rate =
DIVIDE(
    CALCULATE([Completed Trips], ISBLANK(fact_trips[incentive_id]))),
    [Non-Incentivized Trips]
)
```

## User Behavior (Acquisition, Activation, Engagement)

### Registered Users
```DAX
Registered Users =
DISTINCTCOUNT(dim_user[user_id])
```
### Activated Users
```DAX
Activated Users =
CALCULATE(
    DISTINCTCOUNT(dim_user[user_id]),
    dim_user[is_activated] = TRUE()
)
```

### Activation Rate
```DAX
Activation Rate =
DIVIDE([Activated Users], [Registered Users])
```

### Converted Users
```DAX
Converted Users =
CALCULATE(
    DISTINCTCOUNT(dim_user[user_id]),
    dim_user[is_converted] = TRUE()
)
```

### Conversion Rate
```DAX
Conversion Rate =
DIVIDE([Converted Users], [Registered Users])
```
### Average Trips per User
```DAX
Avg Trips per User =
DIVIDE([Total Trips], DISTINCTCOUNT(fact_trips[user_id]))
```

## Funnel (Request -> Completion)
In this dataset, each row in fact_trips represents a trip request, so Total Trips = Requested Trips.

### Requested Trips
```DAX
Requested Trips =
[Total Trips]
```
### Trip Funnel Stage Table (helper)
```DAX
Trip Funnel Stage =
DATATABLE(
    "Stage", STRING,
    {
        {"Requested"},
        {"Completed"},
        {"Cancelled"}
    }
)
```
### Trips by Funnel Stage
```DAX
Trips by Funnel Stage =
SWITCH(
    SELECTEDVALUE('Trip Funnel Stage'[Stage]),
    "Requested", [Total Trips],
    "Completed", [Completed Trips],
    "Cancelled", [Cancelled Trips]
)
```
## Trip Frequency Segmentation
In this dataset, all users have more than one trip; a trip-frequency distribution is used instead of one-time vs repeat segmentation.

### User Trip Summary Table (helper)
```DAX
User Trip Summary =
SUMMARIZE(
    fact_trips,
    fact_trips[user_id],
    "Trips", COUNTROWS(fact_trips)
)
```
### Trip Frequency Bucket (column on User Trip Summary
```DAX
Trip Frequency Bucket =
SWITCH(
    TRUE(),
    'User Trip Summary'[Trips] = 1, "1 trip",
    'User Trip Summary'[Trips] <= 3, "2–3 trips",
    'User Trip Summary'[Trips] <= 7, "4–7 trips",
    "8+ trips"
)
```
### Users (Trip Summary)
```DAX
Users (Trip Summary) =
COUNTROWS('User Trip Summary')
```
## Experiments (A/B Testing)

### Exposed Users
```DAX
Exposed Users =
DISTINCTCOUNT(fact_experiment_events[user_id])
```

### Conversions
```DAX
Conversions =
CALCULATE(
    DISTINCTCOUNT(fact_experiment_events[user_id]),
    fact_experiment_events[conversion_flag] = 1
)
```

### Conversion Rate (Experiment)
```DAX
Experiment Conversion Rate =
DIVIDE([Conversions], [Exposed Users])
```

## Helper Labels

### Status Label
```DAX
Status Label =
SWITCH(
    fact_trips[status],
    "completed", "Completed",
    "cancelled_user", "Cancelled by User",
    "cancelled_driver", "Cancelled by Driver",
    fact_trips[status]
)
```
### Product Type Label
```DAX
ProductType Label = 
SWITCH(
    dim_product[product_type],
    "ebike", "E-Bike",
    "scooter", "Scooter",
    "ride_hailing", "Car",
    dim_product[product_type]
)
```
