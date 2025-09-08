/*
This script create the database and schemas - bronze, silver, gold, meta - if they do not exist already.
In addition creates the etl_log table in the meta schema to log ETL process information.
______________________

*/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'mental_health_tech')
BEGIN
    CREATE DATABASE mental_health_tech;
	PRINT'>> Creating mental_health_tech database';
END;
GO

USE mental_health_tech;
GO

IF NOT EXISTS(SELECT name FROM sys.schemas WHERE name = 'bronze')
BEGIN
	EXEC('CREATE SCHEMA bronze');
	PRINT'>> Bronze schema created';
END;
GO
	
IF NOT EXISTS(SELECT name FROM sys.schemas WHERE name = 'silver')
BEGIN
	EXEC('CREATE SCHEMA silver');
	PRINT'>> Silver schema created';
END;
GO

IF NOT EXISTS(SELECT name FROM sys.schemas WHERE name = 'gold')
BEGIN
	EXEC('CREATE SCHEMA gold');
	PRINT'>> Gold schema created';
END;

IF NOT EXISTS(SELECT name FROM sys.schemas WHERE name = 'meta')
BEGIN
	EXEC('CREATE SCHEMA meta');
	PRINT'>> Meta schema created';
END;

IF OBJECT_ID('meta.etl_log', 'U') IS NOT NULL
	DROP TABLE meta.etl_log;

CREATE TABLE meta.etl_log (
    id INT IDENTITY(1,1) PRIMARY KEY,
    layer NVARCHAR(50),
    status NVARCHAR(50),
    rows_loaded INT NULL,
    error_msg NVARCHAR(MAX) NULL,
    error_num NVARCHAR(MAX) NULL,
    error_on_line NVARCHAR(MAX) NULL,
    start_time DATETIME2,
    end_time DATETIME2,
	load_time_sec INT NULL
);

PRINT'>> Created table meta.etl_log';