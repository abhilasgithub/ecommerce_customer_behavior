# E-Commerce Customer Behavior Analysis

A data analysis web application built with Python and Streamlit that explores customer behavior patterns in an e-commerce dataset — including lifetime value, churn risk, return rates, and revenue trends.

---

## About the Project

This project connects to a PostgreSQL database and provides an interactive dashboard to analyze key business metrics:

- **Customer Lifetime Value (CLV)** — Identify high-value customers based on purchase history
- **Return Rate by Category** — Understand which product categories have the highest return rates
- **Churn Risk Detection** — Flag customers who are likely to stop purchasing
- **Revenue by City** — Visualize geographic revenue distribution

---

## Tech Stack

- **Python** — Core language
- **Streamlit** — Frontend dashboard
- **PostgreSQL** — Database (hosted on Neon or Supabase)
- **SQL** — Data modeling and queries

---

## Setup

1. Create a free PostgreSQL database at [neon.tech](https://neon.tech) or [supabase.com](https://supabase.com)

2. Run `schema.sql` to create and populate the tables:
```bash
   psql your-db-url -f schema.sql
```

3. Set your database connection string:
```bash
   export DATABASE_URL="your-db-url"
```

4. Install dependencies:
```bash
   pip install -r requirements.txt
```

5. Run the app:
```bash
   streamlit run app.py
```

---

## Project Structure
```
retail-sales-analysis/
├── app.py               # Main Streamlit application
├── schema.sql           # Database schema and seed data
├── requirements.txt     # Python dependencies
└── README.md            # Project documentation
```

---

## Key Features

| Feature | Description |
|---|---|
| Customer Lifetime Value | Ranks customers by total spend and purchase frequency |
| Return Rate Analysis | Breaks down return rates by product category |
| Churn Risk Detection | Flags customers inactive for a defined period |
| Revenue by City | Maps revenue contributions across cities |
