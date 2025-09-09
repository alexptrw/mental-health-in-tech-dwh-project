/*
Bronze Layer Load Script
__________________________________________
Purpose:
This script loads raw mental health data from a CSV file into the bronze layer table 
created in bronze_ddl.sql. Each execution of this script will overwrite existing data in the table.
Steps are logged in the meta.etl_log table.
__________________________________________
Make sure to update the file path in the BULK INSERT command to point to the location of the survey_data.csv file on your system.

*/

DECLARE @starttime DATETIME2
SET @starttime = GETDATE();
BEGIN TRY
	DECLARE @endtime DATETIME2, @stg_rows INT, @rows INT		
	PRINT '===============================';
	PRINT 'Load Bronze Layer';
	PRINT '===============================';

	BULK INSERT bronze.mental_health_raw_data_stg
	FROM 'C:\Users\USER\Desktop\DEProjects\mental_health_tech\dataset\survey_data.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			KEEPNULLS,
			TABLOCK
		);
	SET @stg_rows = @@ROWCOUNT
	SET @endtime = GETDATE();
	PRINT 'Data loaded successfully into bronze layer staging. Total of ' + CAST(@stg_rows AS NVARCHAR) 
	+ 
	' records loaded. Time to load: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' sec.';
	INSERT INTO bronze.mental_health_raw_data SELECT * FROM bronze.mental_health_raw_data_stg;
	SET @rows = (SELECT COUNT(*) FROM bronze.mental_health_raw_data);
	INSERT INTO meta.etl_log(layer, status, rows_loaded, error_msg, error_num, error_on_line, start_time, end_time, load_time_sec)
    VALUES 
	('bronze', 'Success', @rows, NULL, NULL, NULL, @starttime, @endtime, DATEDIFF(second, @starttime, @endtime));
	TRUNCATE TABLE bronze.mental_health_raw_data_stg;
	PRINT 'Staging tale cleaned'
END TRY
	BEGIN CATCH
		PRINT '===============================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message:	 ' + ERROR_MESSAGE();
		PRINT 'Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '===============================';
		INSERT INTO meta.etl_log(layer, status, rows_loaded, error_msg, error_num, error_on_line, start_time, end_time, load_time_sec)
		VALUES ('bronze', 'Error', NULL, ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), @starttime, GETDATE(), NULL);
	END CATCH;
