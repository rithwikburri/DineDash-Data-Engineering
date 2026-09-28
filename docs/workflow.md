# Databricks Workflow / Job

The case study's Workflow/Job section has two explicit tasks and an incremental rerun step.

## Task 1 — Execute the DLT/Lakeflow pipeline

Run the DineDash pipeline created in the DLT section. The source starts with order details through **June**, then receives additional monthly files.

Pipeline outputs include:

- `orders_bronze_stream`
- `orders_silver`
- `total_orders_per_restaurant`
- Q13: `q13_top_10_customer_restaurant_variety`
- Q14: `q14_repeat_customers`
- Q15: `q15_high_value_payment_by_cuisine`

The case study documents pipeline execution for **January-June**, then **January-August**, and finally the full set through **January-December** as more order files are added.

## Task 2 — Dashboard

Create/refresh a Databricks SQL Dashboard displaying:

- `total_orders_per_restaurant`
- Other downstream KPI queries as required

The case study specifically names a dashboard displaying **total_orders_per_restaurant**.

## Incremental Job Run

After adding additional monthly order files:

1. Run the DLT/Lakeflow pipeline.
2. Wait for the pipeline to complete.
3. Refresh the dashboard query/task.
4. Validate that the new monthly records are reflected in the analytical tables.
5. Compare record counts and KPI values before and after the run.

## Case-study execution milestones

| Stage | Order data available | Job action |
|---|---|---|
| Initial | January-June | Execute DLT pipeline |
| Increment 1 | January-August | Add July/August, run pipeline, refresh dashboard |
| Increment 2 | Remaining monthly files | Add remaining files, run pipeline again |
| Final | January-December | Validate final dashboard and analytical outputs |

## Questions / requirements covered by the pipeline and job

### Analysis questions implemented as pipeline outputs

- **Q13:** Find the top 10 customers who have ordered from the widest variety of restaurants.
- **Q14:** Identify restaurants with frequent repeat customers.
- **Q15:** Identify preferred payment methods for high-value orders across cuisines.

### Workflow / Job requirements implemented

- Execute the DLT pipeline.
- Create/refresh the dashboard showing total orders per restaurant.
- Add monthly order files incrementally.
- Rerun the pipeline and observe incremental data updates.
- Validate the January-August and January-December execution stages.

Questions 1-12 are intentionally excluded from this repository, including their standalone view/analysis requirements.
