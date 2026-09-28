# Architecture

The supplied case study proposes a Databricks + Apache Spark big-data pipeline with a centralized data lake, ETL, real-time streaming, dashboards, machine-learning use cases, and optimized routing.

For the GitHub implementation, the data-engineering portion is organized as:

1. **Landing** — monthly order files and dimension CSVs in a Databricks Volume.
2. **Bronze** — raw Delta tables with ingestion timestamp and source file metadata.
3. **Silver** — null-filtered/cleaned dimension tables and transformed order streams.
4. **Gold** — analytical aggregates for customer, restaurant, payment/cuisine, and dashboard use cases.
5. **Workflow** — orchestrates the pipeline and dashboard refresh when new monthly files arrive.

The original case study shows orders initially through June, then adds July/August and later remaining files for incremental execution. The repository preserves that incremental pattern rather than treating the data as a one-time batch.
