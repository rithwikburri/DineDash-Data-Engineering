# Source Scope and Requirement Mapping

This repository is based on the supplied DineDash capstone case study.

## Included

### Analysis questions

| Requirement | Repository implementation |
|---|---|
| Q13 — Top 10 customers by restaurant variety | `dlt/dinedash_pipeline.sql` + `sql/03_analysis_q13_q15.sql` |
| Q14 — Restaurants with frequent repeat customers | `dlt/dinedash_pipeline.sql` + `sql/03_analysis_q13_q15.sql` |
| Q15 — High-value payment methods across cuisines | `dlt/dinedash_pipeline.sql` + `sql/03_analysis_q13_q15.sql` |

### DLT / pipeline section

The case study starts the pipeline with orders through June and then adds additional monthly order files. The repository models this as an incremental file-ingestion pipeline using `read_files()` and a streaming table.

The documented execution stages are:

1. January-June
2. January-August after adding July and August
3. January-December after adding the remaining order files

### Workflow / Job section

The repository also models the explicit workflow tasks from the case study:

1. Execute the DLT/Lakeflow pipeline.
2. Refresh/create a dashboard showing `total_orders_per_restaurant`.
3. Rerun after adding monthly files and validate incremental dashboard/table updates.

## Excluded

The first 12 analysis questions are intentionally excluded at the user's request. They are not represented as standalone analysis requirements in this repository.

## Important implementation note

The case study's DLT screenshots show the pipeline/table definitions and the Workflow/Job section shows the execution and dashboard stages. The repository converts those documented requirements into clean, reusable source files rather than copying workspace-specific IDs, URLs, credentials, or screenshots.
