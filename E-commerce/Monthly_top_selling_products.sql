SELECT p.ProductName,
       SUM(od.quantity) AS TotalSold
FROM Order_Details od
JOIN Orders o ON o.orderId = od.orderId
JOIN Product p ON od.productId = p.productId
WHERE MONTH(o.orderDate) = 8
GROUP BY p.productId, p.ProductName
ORDER BY TotalSold DESC
LIMIT 3;
