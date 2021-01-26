/*
  This script creates and executes a procedure to insert test data to 
  tables Sales and Discounts.
*/

/*It drops  instertSalesDiscountsTestData if it exists*/
DROP PROCEDURE IF EXISTS instertSalesDiscountsTestData ;

/*It truncates discounts table*/
TRUNCATE TABLE discounts;

/*It truncates sales table*/
TRUNCATE TABLE sales;

DELIMITER $$
/*
instertSalesDiscountsTestData: Procedure responsible to insert Test Data
into tables Sales and Discounts

numRows: Number of rows to be inserted into Sales table

minVal: Minimum value of column sales.transaction_value

minVal: Maximum value of column sales.transaction_value
*/
CREATE PROCEDURE instertSalesDiscountsTestData (IN numRows INT, IN minVal INT, IN maxVal INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= numRows DO
			/*
			Sales data simulation rules:
				sales_order_id: Iteration number
				custumer_id: Result of function mod(sales_order_id, 1000)
				sales_order_item: Concatanation of string "item " with sales_order_id
				sales_date: Random date from current date down to 1000 days before it.
				transaction_value: Random value between minVal to maxVal
			*/
            INSERT INTO sales (sales_order_id,customer_id,sales_order_item,sales_date,transaction_value)
            VALUES (i, mod(i,1000), concat("item ", i),date_add(CURRENT_DATE(), INTERVAL  ROUND(-1000*RAND()) day ), ceil(100*RAND() * (maxVal - minVal))/100);
            SET i = i + 1;
        END WHILE;
        /*
        Discounts data simulation rules:
			sales_order_id: Copy of respective value of column sales.sales_order_id
			customer_id: Copy of respective value of column sales.customer_id
			discount_value: Random value greater than or equal to zero and less than sales.transaction_value

			number of rows: Random number greater than zero and less than numRows
        */
        INSERT INTO discounts(sales_order_id,customer_id, discount_value ) 
			SELECT sales.sales_order_id,sales.customer_id, round(sales.transaction_value*RAND(),2)  FROM sales WHERE MOD(sales_order_id,10) <=rand()*10;
        COMMIT;
    END$$

DELIMITER ;
/*It cCalls procedure instertSalesDiscountsTestData to insert test data*/
CALL instertSalesDiscountsTestData (100000, 1, 1000);
/*It drops procedure instertSalesDiscountsTestData*/
DROP PROCEDURE IF EXISTS instertSalesDiscountsTestData ;
