/*
Exercise 1

Question C: Consider different scenarios/edge cases (e.g., depending on 
the data quality) and, optionally, propose possible solutions and/or 
scripts to handle such cases. 
*/

/*Scenario 1: Sales table and discounts table have a huge number of rows.
In that case, if you try to update the whole table you could crache the database.

Solutions:
You can create a script with a loop to update sales in batches.
Each iteration of the loop could update a batch of an interval of custumer_id 
or an interval of dates and then commit transaction.

If you want to test this solution, then run the following scripts:
	sql/regular_case/0001_create_tables.sql
	sql/regular_case/0002_insert_test_data.sql
Then run this script below.
*/
DROP PROCEDURE IF EXISTS UpdateSalesInBatches;
SET SQL_SAFE_UPDATES = 0;
DELIMITER $$

CREATE PROCEDURE UpdateSalesInBatches()
BEGIN
	DECLARE bDone INTEGER DEFAULT 0;
	DECLARE customerIdStart INTEGER;
	DECLARE customerIdEnd INTEGER;
	/*this cursor returns intervals of 100 custumer_id(eg: [0,99],[100,199],[200,299]... )*/
	DECLARE curCustomers CURSOR FOR  SELECT MIN(customer_id) INTERVAL_START, MAX(customer_id) INTERVAL_END FROM discounts GROUP BY FLOOR(customer_id / 100) ORDER BY FLOOR(customer_id / 100);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone = 1;

	OPEN curCustomers;

	
	REPEAT
		FETCH curCustomers INTO customerIdStart, customerIdEnd;
		IF NOT bDone THEN
			START TRANSACTION;
			UPDATE sales 
				SET 
					discount_value = (SELECT 
							discounts.discount_value
						FROM
							discounts
						WHERE
							discounts.sales_order_id = sales.sales_order_id
								AND discounts.customer_id = sales.customer_id
								AND discounts.customer_id between customerIdStart and customerIdEnd)
				WHERE
					EXISTS( SELECT 
							1
						FROM
							discounts
						WHERE
							discounts.sales_order_id = sales.sales_order_id
								AND discounts.customer_id = sales.customer_id
								AND discounts.customer_id between customerIdStart and customerIdEnd);
			COMMIT;
		END;
	UNTIL bDone END REPEAT;
	CLOSE curCustomers;
END$$

DELIMITER ;

CALL UpdateSalesInBatches();
SET SQL_SAFE_UPDATES = 1;

DROP PROCEDURE IF EXISTS UpdateSalesInBatches;
