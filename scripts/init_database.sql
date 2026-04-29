/*
  Create Database and Schemas:
Script purpose :
This script creates a new database named 'Datawarehouse' after checking if it is already exist.
IF the exists, it is dropped and recreated. Additionally, the scripts set up three schemas
within the database: "Bronze","Silver","Gold"

Warning:
Running this script will drop the database 'DataWarehouse' if it is exists.
All the data in the database will be permanantly deleted.Proceed with caution.
and ensure you have proper backups before running this scripts.

*/

Use master;
go

-- Drop and recreate the Database 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM SYS.databases where name='DataWarehouse')
Begin
    Alter database DataWarehouse set SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
End;
Go

--Create database
create database DataWarehouse;
use DataWarehouse;

-- Create Schemas
create  schema bronze;
Go
create  schema silver;
Go
create  schema gold;






