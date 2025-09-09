/*
Bronze Layer DDL Script
__________________________________________
Purpose:
Creates staging and main tables in the bronze schema to hold raw mental health data.
Staging is used to accommodate the autoincrementing primary key in the main table.
__________________________________________

*/

IF OBJECT_ID('bronze.mental_health_raw_data_stg', 'U') IS NOT NULL
	DROP TABLE bronze.mental_health_raw_data_stg;
GO
CREATE TABLE bronze.mental_health_raw_data_stg (
    Timestamp DATETIME2,
    Age INT,
    Gender NVARCHAR(50),
    Country NVARCHAR(100),
    state NVARCHAR(255),
    self_employed NVARCHAR(50),
    family_history NVARCHAR(50),	
    treatment NVARCHAR(50),	
    work_interfere NVARCHAR(100),	
    no_employees NVARCHAR(50),	
    remote_work NVARCHAR(50),
    tech_company NVARCHAR(50),
    benefits NVARCHAR(100),	
    care_options NVARCHAR(100),	
    wellness_program NVARCHAR(100),	
    seek_help NVARCHAR(100),	
    anonymity NVARCHAR(100),	
    leave NVARCHAR(255),	
    mental_health_consequence NVARCHAR(100),	
    phys_health_consequence NVARCHAR(100),	
    coworkers NVARCHAR(100),	
    supervisor NVARCHAR(100),	
    mental_health_interview NVARCHAR(100),	
    phys_health_interview NVARCHAR(100),	
    mental_vs_physical NVARCHAR(100),	
    obs_consequence NVARCHAR(100),	
    comments NVARCHAR(MAX) 
);
GO
IF OBJECT_ID('bronze.mental_health_raw_data', 'U') IS NOT NULL
	DROP TABLE bronze.mental_health_raw_data;

CREATE TABLE bronze.mental_health_raw_data (
	ID INT IDENTITY(1,1) PRIMARY KEY,
    Timestamp DATETIME2,
    Age INT,
    Gender NVARCHAR(50),
    Country NVARCHAR(100),
    state NVARCHAR(255),
    self_employed NVARCHAR(50),
    family_history NVARCHAR(50),	
    treatment NVARCHAR(50),	
    work_interfere NVARCHAR(100),	
    no_employees NVARCHAR(50),	
    remote_work NVARCHAR(50),
    tech_company NVARCHAR(50),
    benefits NVARCHAR(100),	
    care_options NVARCHAR(100),	
    wellness_program NVARCHAR(100),	
    seek_help NVARCHAR(100),	
    anonymity NVARCHAR(100),	
    leave NVARCHAR(255),	
    mental_health_consequence NVARCHAR(100),	
    phys_health_consequence NVARCHAR(100),	
    coworkers NVARCHAR(100),	
    supervisor NVARCHAR(100),	
    mental_health_interview NVARCHAR(100),	
    phys_health_interview NVARCHAR(100),	
    mental_vs_physical NVARCHAR(100),	
    obs_consequence NVARCHAR(100),	
    comments NVARCHAR(MAX) 
);
PRINT'>> Created table bronze.mental_health_raw_data';
