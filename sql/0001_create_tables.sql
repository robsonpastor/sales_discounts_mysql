
/*
Exercise 1
Question A: Define Create Table statements for both tables
*/

/*
Creates table Sales using columns sales_order_id , customer_id as 
Primary Key

Commented code with a foreing key to customers table is there just for reference.
*/

CREATE TABLE sales (
    sales_order_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    sales_order_item VARCHAR(100) NOT NULL,
    sales_date DATE NOT NULL,
    transaction_value DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_sales PRIMARY KEY (sales_order_id , customer_id)/*,
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)*/
);


/*
Creates table Discounts using columns sales_order_id , customer_id as 
Primary Key and as Foreign Key to table sales
*/


CREATE TABLE discounts (
    sales_order_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    discount_value DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_discounts PRIMARY KEY (sales_order_id , customer_id),
    CONSTRAINT fk_discounts_sales FOREIGN KEY (sales_order_id , customer_id)
        REFERENCES sales (sales_order_id , customer_id)
);

