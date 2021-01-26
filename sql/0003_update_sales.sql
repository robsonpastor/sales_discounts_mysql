/*
Exercise 1

Question B: Define a strategy to allocate the discount values to the 
Sales table (e.g., in a new column) and define the necessary 
query/scripts to execute the logic.

*/

/*It creates a column to discount values at table sales */
ALTER TABLE sales ADD COLUMN discount_value DECIMAL(10,2);

SET SQL_SAFE_UPDATES = 0;
/*It updates sales table with discounts data*/
UPDATE sales 
SET 
    discount_value = (SELECT 
            discounts.discount_value
        FROM
            discounts
        WHERE
            discounts.sales_order_id = sales.sales_order_id
                AND discounts.customer_id = sales.customer_id)
WHERE
    EXISTS( SELECT 
            1
        FROM
            discounts
        WHERE
            discounts.sales_order_id = sales.sales_order_id
                AND discounts.customer_id = sales.customer_id);
SET SQL_SAFE_UPDATES = 1;   

/*
After check if everything is ok, you can drop discounts table.

Drop discounts table;

*/
