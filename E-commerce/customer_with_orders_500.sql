SELECT c.FirstName,
       c.LastName,
       SUM(od.quantity * od.unit_price) AS TotalSpent
FROM Order_Details od
JOIN Orders o ON od.orderId = o.orderId
JOIN Customer c ON c.customerId = o.customerId
WHERE o.orderDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.customerId, c.FirstName, c.LastName
HAVING TotalSpent > 500
ORDER BY TotalSpent DESC;
