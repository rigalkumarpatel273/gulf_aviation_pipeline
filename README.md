# ✈️ GCC Real-Time Flight Telemetry & Analytics Pipeline

A data engineering pipeline that ingests live flight state vectors over the GCC region from the OpenSky Network API, cleans and computes geospatial metrics in Python, stores structured data in a PostgreSQL Star Schema, and visualizes airspace telemetry in Power BI.

---

## 🛠️ Stack Summary
* **ETL & Calculations:** Python (`pandas`, `numpy`, `sqlalchemy`) | Haversine Formula
* **Database & SQL:** PostgreSQL | Star Schema (`dim_airports` & `fact_flight_states`)
* **Analytics & BI:** Power BI Desktop | DAX | Spatial Mapping

---

## 📊 Operational Dashboard

> <img width="665" height="377" alt="Gulf_aviation" src="https://github.com/user-attachments/assets/d6a32b84-909c-4f92-8f6c-cf9c0d45986c" />

> ![GCC Flight Telemetry Dashboard](Dashboard/dashboard_screenshot.png)

## 📁 Repository Structure

* **`Dashboard/`**: Power BI report file (`gulf_aviation.pbix`).
* **`notebooks/`**: OpenSky API ingestion and transformation script (`01_flight_ingestion.ipynb`).
* **`sql/`**: Schema DDL (`tables.sql`) and analytical queries (`Queries.sql`).
* **`data/`**: Staging directory for snapshot exports.
