# Sales x Discounts Problem
SQL solution for Sales x Discount Problem

## Requirements

*	MySQL 5.7.29 >=

## Regular Case
Connected to a MySQL database run the following scrits:

1. Create sales and discounts tables

	[sql/regular_case/0001_create_tables.sql](sql/regular_case/0001_create_tables.sql)
	

2. Insert test data

	[sql/regular_case/0002_insert_test_data.sql](sql/regular_case/0002_insert_test_data.sql)
	

3. Update sales table with discounts information
	[sql/regular_case/0003_update_sales.sql](sql/regular_case/0003_update_sales.sql)

	
## Edge Case
You can drop sales and dicounts tables and then run the following scripts:

1. Create sales and discounts tables

	[sql/regular_case/0001_create_tables.sql](sql/regular_case/0001_create_tables.sql)
	

2. Insert test data

	[sql/regular_case/0002_insert_test_data.sql](sql/regular_case/0002_insert_test_data.sql)
	

3. Update sales table with discounts information in batches for huge data volume
	[sql/edge_case/0003_update_sales.sql](sql/edge_case/0001_huge_data_volume.sql)
