-- Customer Lifetime Value
SELECT 
  c.name, c.city,
  COUNT(o.order_id) AS total_orders,
  SUM(o.amount) AS lifetime_value,
  MAX(o.order_date) AS last_purchase
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name, c.city
ORDER BY lifetime_value DESC;

-- Return Rate by Category
SELECT 
  category,
  COUNT(*) AS total_orders,
  SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) AS returns,
  ROUND(100.0 * SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 2) AS return_rate_pct
FROM orders
GROUP BY category;

-- Churn Risk (no orders in last 60 days)
SELECT 
  c.name,
  MAX(o.order_date) AS last_order,
  CURRENT_DATE - MAX(o.order_date) AS days_since_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING CURRENT_DATE - MAX(o.order_date) > 60
ORDER BY days_since_order DESC;

-- Revenue by City
SELECT 
  c.city,
  SUM(o.amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.city
ORDER BY total_revenue DESC;
