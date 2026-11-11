/*
================================================================================
 File    : sql/02_bronze/01_create_bronze_tables.sql
 Purpose : Creates the six Bronze tables, one per source CSV file.

 Rules   : - Column names and order match the CSV header exactly, because
             BULK INSERT fills columns by position.
           - Data types are kept simple and close to the file; no cleaning here.
           - Re-runnable: each table is dropped first if it already exists.

 Source files -> tables
   source_crm/cust_info.csv     -> bronze.crm_cust_info
   source_crm/prd_info.csv      -> bronze.crm_prd_info
   source_crm/sales_details.csv -> bronze.crm_sales_details
   source_erp/CUST_AZ12.csv     -> bronze.erp_cust_az12
   source_erp/LOC_A101.csv      -> bronze.erp_loc_a101
   source_erp/PX_CAT_G1V2.csv   -> bronze.erp_px_cat_g1v2
================================================================================
*/

USE DataWarehouse;

------------------------------- CRM ------------------------------------------
IF OBJECT_Id ('bronze.crm_cust_info', 'U') IS NOT NULL
DROP TABLE bronze.crm_cust_info;
GO
  
CREATE TABLE bronze.crm_cust_info (
cst_id INT, 
cst_key NVARCHAR (50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);
Go

IF OBJECT_Id ('bronze.crm_prd_info', 'U') IS NOT NULL
DROP TABLE bronze.crm_prd_info;
Go
  
CREATE TABLE bronze.crm_prd_info(
prd_id INT,
prd_key NVARCHAR(50), 
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);
Go

IF OBJECT_Id ('bronze.crm_sales_details', 'U') IS NOT NULL
DROP TABLE bronze.crm_sales_details;
Go
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT, 
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
Go

IF OBJECT_Id ('bronze.erp_cust_az12', 'U') IS NOT NULL
DROP TABLE bronze.erp_cust_az12;
Go
  
CREATE TABLE bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);
Go 
  
IF OBJECT_Id ('bronze.erp_loc_a101', 'U') IS NOT NULL
DROP TABLE bronze.erp_loc_a101;
Go
  
CREATE TABLE bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);
Go

IF OBJECT_Id ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
DROP TABLE bronze.erp_px_cat_g1v2;
Go 
  
CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50), 
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)

);
Go
PRINT 'Bronze tables created.';
