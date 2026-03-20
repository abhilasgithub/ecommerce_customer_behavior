import streamlit as st
import pandas as pd
import plotly.express as px
import psycopg2

@st.cache_resource
def get_conn():
    return psycopg2.connect(st.secrets["DATABASE_URL"])

st.set_page_config(page_title="E-Commerce Analytics", layout="wide")
st.title("📦 E-Commerce Customer Behavior Analysis")

conn = get_conn()

# CLV
df_clv = pd.read_sql("""
    SELECT c.name, c.city, COUNT(o.order_id) AS orders,
           SUM(o.amount) AS lifetime_value
    FROM customers c JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.name, c.city ORDER BY lifetime_value DESC
""", conn)
fig1 = px.bar(df_clv, x='name', y='lifetime_value', color='city',
              title='Customer Lifetime Value')
st.plotly_chart(fig1, use_container_width=True)

col1, col2 = st.columns(2)

with col1:
    df_ret = pd.read_sql("""
        SELECT category,
               ROUND(100.0 * SUM(CASE WHEN status='Returned' THEN 1 ELSE 0 END)/COUNT(*), 2) AS return_rate
        FROM orders GROUP BY category
    """, conn)
    fig2 = px.pie(df_ret, names='category', values='return_rate',
                  title='Return Rate by Category')
    st.plotly_chart(fig2, use_container_width=True)

with col2:
    df_city = pd.read_sql("""
        SELECT c.city, SUM(o.amount) AS revenue
        FROM customers c JOIN orders o ON c.customer_id = o.customer_id
        WHERE o.status = 'Delivered'
        GROUP BY c.city ORDER BY revenue DESC
    """, conn)
    fig3 = px.bar(df_city, x='city', y='revenue',
                  title='Revenue by City', color='city')
    st.plotly_chart(fig3, use_container_width=True)

st.subheader("⚠️ Churn Risk Customers")
df_churn = pd.read_sql("""
    SELECT c.name, MAX(o.order_date) AS last_order,
           CURRENT_DATE - MAX(o.order_date) AS days_inactive
    FROM customers c JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.name HAVING CURRENT_DATE - MAX(o.order_date) > 60
    ORDER BY days_inactive DESC
""", conn)
if df_churn.empty:
    st.info("No churn risk customers at the moment.")
else:
    st.dataframe(df_churn, use_container_width=True)