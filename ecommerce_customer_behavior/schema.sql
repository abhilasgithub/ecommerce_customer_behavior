CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(50),
  signup_date DATE
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  product VARCHAR(100),
  category VARCHAR(50),
  amount DECIMAL(10,2),
  order_date DATE,
  status VARCHAR(20)
);

INSERT INTO customers VALUES
(1,'Arjun','Mumbai','2023-01-10'),
(2,'Priya','Delhi','2023-03-15'),
(3,'Ravi','Hyderabad','2023-05-20'),
(4,'Sneha','Chennai','2023-07-08'),
(5,'Karan','Bangalore','2023-09-12');

INSERT INTO orders VALUES
(1,1,'Shoes','Fashion',1500,'2024-01-05','Delivered'),
(2,1,'Watch','Accessories',5000,'2024-02-10','Delivered'),
(3,2,'Laptop','Electronics',45000,'2024-01-20','Delivered'),
(4,3,'Book','Education',500,'2024-03-01','Delivered'),
(5,3,'Phone','Electronics',20000,'2024-03-15','Returned'),
(6,4,'Dress','Fashion',2000,'2024-02-28','Delivered'),
(7,5,'Headphones','Electronics',3000,'2024-04-05','Delivered'),
(8,2,'Tablet','Electronics',15000,'2024-04-10','Pending');
