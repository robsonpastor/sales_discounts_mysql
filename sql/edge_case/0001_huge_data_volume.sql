/*
Exercise 1

Question C: Consider different scenarios/edge cases (e.g., depending on 
the data quality) and, optionally, propose possible solutions and/or 
scripts to handle such cases. 
*/

/*Scenario 1: table sales primary key is only column sales_order_id.
			And column customer_id is nullable.
*/

CREATE TABLE sales (
    sales_order_id INTEGER NOT NULL,
    customer_id INTEGER ,
    sales_order_item VARCHAR(100) NOT NULL,
    sales_date DATE NOT NULL,
    transaction_value DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_sales PRIMARY KEY (sales_order_id)/*,
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)*/
);

CREATE TABLE discounts (
    sales_order_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    discount_value DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_discounts PRIMARY KEY (sales_order_id),
    
    CONSTRAINT fk_discounts_sales FOREIGN KEY (sales_order_id)
        REFERENCES sales (sales_order_id)
     /*,
    CONSTRAINT fk_discounts_customer FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)*/
);

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
