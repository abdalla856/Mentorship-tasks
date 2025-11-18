SELECT DATE(o.orderDate) AS SaleDate,
       SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM Orders o
JOIN Order_Details od ON o.orderId = od.orderId
WHERE DATE(o.orderDate) = '2002-08-14'
GROUP BY DATE(o.orderDate);
