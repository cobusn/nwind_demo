# Create entity relationships
set -x

dk m add -O categories -M products --oc categoryID --mc categoryID
dk m add -O suppliers -M products --oc supplierID --mc supplierID
dk m add -O products -M order_details --oc productID --mc productID
dk m add -O orders -M order_details --oc orderID --mc orderID
dk m add -O customers -M orders --oc customerID --mc customerID
dk m add -O shippers -M orders --oc shipperID --mc shipperID
dk m add -O employees -M orders --oc employeeID --mc employeeID
dk m add -O employees -M employee_territories --oc employeeID --mc employeeID
dk m add -O employees -M employees --oc employeeID --mc reports_to 
dk m add -O territories -M employee_territories --oc territoryID --mc territoryID
dk m add -O regions -M territories --oc regionID --mc regionID
dk m add -O shippers -M orders --oc shipperID --mc shipVia
