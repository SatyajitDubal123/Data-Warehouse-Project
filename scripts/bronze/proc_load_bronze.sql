/*
Strored procedure: Load Bronze Layer(Source-> Bronze)
 Script Purpose:
    This Stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    -Truncate the bronze table before loading date
    - uses the bulk insert command to load data from csv file to bronze tables
Parameters:
    This Stored procedure does not accept any parameters or any values

Usage eg:
  EXEC bronze.load_bronze

*/

Create or Alter procedure Bronze.load_bronze as
Begin
	Declare @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DateTime
	Begin Try
		Set @batch_start_time= GETDATE();
		print'====================================================';
		print'Loading Bronze Layer';
		print'====================================================';

		print'-----------------------------------------------------';
		print'loading CRM Tables';
		print'------------------------------------------------------';

		set @start_time =getdate();
		Truncate table bronze.crm_cust_info;
		Bulk insert bronze.crm_cust_info
		from 'C:\source_crm\cust_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock --improve the performance
		);
		set @end_time =getdate();
		print'>>Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'

		set @start_time=GETDATE();
		Truncate table bronze.crm_prd_info
		Bulk insert bronze.crm_prd_info
		from 'C:\source_crm\prd_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(datediff(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'


		set @start_time=GETDATE();
		Truncate table bronze.crm_sales_details;
		Bulk insert bronze.crm_sales_details
		from'C:\source_crm\sales_details.csv'
		with(                        -- how to handle inside stuff.
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(datediff(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'



		print'-----------------------------------------------------';
		print'loading ERP Tables';
		print'------------------------------------------------------';


		set @start_time=GETDATE();
		Truncate table bronze.erp_cust_az12;
		Bulk insert bronze.erp_cust_az12
		from 'C:\source_erp\cust_az12.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(datediff(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'


		set @start_time=GETDATE();
		Truncate table bronze.erp_loc_a101;
		Bulk insert bronze.erp_loc_a101
		from 'C:\source_erp\LOC_A101.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(datediff(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'


		set @start_time=GETDATE();
		Truncate table bronze.erp_px_cat_g1v2;
		Bulk insert bronze.erp_px_cat_g1v2
		from 'C:\source_erp\px_cat_g1v2.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(datediff(second,@start_time,@end_time) as NVARCHAR) +' Seconds';
		print'>>------------'

		Set @batch_end_time=GETDATE();
		print'==============================================='
		print'Loading Bronze Layer is Completed';
		print' - Total Load Duration: '+ cast(DATEDIFF(second,@batch_start_time,@batch_end_time) as NVARCHAR) +' Seconds';
		print'================================================'
	End Try
	Begin catch
		print '==============================================='
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER'	
		print'Error Message: ' + error_message();
		print'Error Message: '+ cast(Error_number() as NVARCHAR);
		print'Error Message: '+ cast(Error_State() as NVARCHAR)
		print '==============================================='
	End catch
END

