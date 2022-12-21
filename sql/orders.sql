SELECT
  ord.orderID,
  cust.companyName,
  cust.country,
  cust.region,
  ord.orderDate,
  shippers.companyName as shipper,
  emp.employeeID,
  emp.firstName,
  emp.lastName,
  det.productID,
  prod.productName,
  prod.supplierID,
  sup.companyName as supplier,
  det.quantity,
  det.unitPrice
  -- det.quantity * det.unitPrice as total
FROM
  orders ord
  inner join order_details det on ord.orderID = det.orderID
  inner join products prod on det.productID = prod.productID
  inner join categories cat on prod.categoryID = cat.categoryID
  inner join suppliers sup on prod.supplierID = sup.supplierID
  inner join customers cust on ord.customerID = cust.customerID
  inner join employees emp on ord.employeeID = emp.employeeID
  inner join shippers on ord.shipVia = shippers.shipperID
