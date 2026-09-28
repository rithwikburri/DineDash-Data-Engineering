# DineDash Food Delivery Data Engineering

A Databricks data engineering capstone for ingesting, transforming, incrementally processing, and analyzing DineDash food-delivery data using Delta Lake, Databricks SQL, Lakeflow Declarative Pipelines / Delta Live Tables, and Databricks Workflows.

## Project scope

This repository intentionally excludes the first **12 analysis questions** from the supplied case study. The implementation starts with **Q13-Q15** and includes the subsequent **DLT pipeline + Workflow/Job + dashboard + incremental monthly ingestion** requirements.

## End-to-end architecture

```text
Monthly CSV order files
        |
        v
Databricks Volume / cloud storage
        |
        v
read_files() + Auto Loader-style incremental ingestion
        |
        v
Bronze streaming Delta table
        |
        v
Silver-quality order table
        |
        +--------------------------+
        |                          |
        v                          v
Q13 / Q14 / Q15 analytical     Restaurant KPI
materialized views             total_orders_per_restaurant
        |                          |
        +------------+-------------+
                     |
                     v
            Databricks SQL Dashboard
                     |
                     v
              Databricks Workflow
                     |
                     v
       Add monthly files → rerun → validate
```

## Case-study requirements implemented

### Q13
**Find the top 10 customers who have ordered from the widest variety of restaurants.**

Implementation: `q13_top_10_customer_restaurant_variety`

### Q14
**Identify restaurants with frequent repeat customers.**

Implementation: `q14_repeat_customers`

### Q15
**Which payment methods are most preferred for high-value orders across cuisines?**

Implementation: `q15_high_value_payment_by_cuisine`

### DLT / pipeline requirements

The case study starts with order details through **June** in the orders folder. Additional order files are then added for **July and August**, followed by the remaining files. The documented pipeline execution stages are January-June, January-August, and January-December.

The repository therefore demonstrates:

- Incremental file ingestion
- Streaming Bronze ingestion
- Silver data-quality filtering
- Gold/materialized analytical outputs
- Reprocessing when new monthly files arrive
- Dashboard-ready KPI tables

### Workflow / Job requirements

The case study's Workflow section explicitly includes:

- **Task 1:** Execute the DLT pipeline.
- **Task 2:** Create/refresh a dashboard displaying `total_orders_per_restaurant`.
- Add additional order files and run the workflow again.
- Observe incremental updates through the January-August and January-December stages.

## Technologies

- Databricks
- Apache Spark
- Databricks SQL
- Delta Lake
- Lakeflow Declarative Pipelines / Delta Live Tables
- Databricks Workflows / Jobs
- Databricks SQL Dashboards
- SQL

## Repository structure

```text
.
├── README.md
├── .gitignore
├── sql/
│   ├── 01_bronze_tables.sql
│   ├── 02_cleaned_tables.sql
│   └── 03_analysis_q13_q15.sql
├── dlt/
│   └── dinedash_pipeline.sql
├── docs/
│   ├── architecture.md
│   ├── source-scope.md
│   └── workflow.md
└── data/sample/
    └── README.md
```

## Running in Databricks

1. Upload the supplied source CSV files to a Databricks Volume or configure an external cloud location.
2. Update the source path in `sql/01_bronze_tables.sql` and `dlt/dinedash_pipeline.sql`.
3. Run the Bronze and cleaned-table SQL.
4. Configure the Lakeflow/DLT pipeline using `dlt/dinedash_pipeline.sql`.
5. Configure the Workflow with the tasks in `docs/workflow.md`.
6. Create a Databricks SQL Dashboard using `total_orders_per_restaurant` and the other analytical outputs.
7. Add later monthly order files and rerun the workflow to validate incremental processing.

## Data engineering concepts demonstrated

- Delta Lake tables
- Explicit schemas
- Data-quality filtering
- Incremental ingestion
- `read_files()` / streaming file ingestion
- Aggregations and joins
- `COUNT(DISTINCT ...)`
- Repeat-customer analysis
- High-value order analysis
- Materialized analytical tables
- Pipeline orchestration
- Dashboard refresh
- Incremental validation

## Security

Do not commit credentials, tokens, passwords, connection strings, or private workspace URLs. Use Databricks Secrets, environment configuration, or workspace-managed credentials.

## Source

Implementation is based on the supplied DineDash capstone case study. Questions 1-12 are intentionally omitted from the repository scope.
