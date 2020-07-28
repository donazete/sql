/****
Title: Script to create LocationReference database and the table structures
Author: Donald Oyeleye
Create Date: 02 - Feb- 2020
*****/

-- Check to see if LocationReference database exists. If not create it 
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ReferenceLocation')
BEGIN
	CREATE DATABASE [ReferenceLocation]
END

-- Create LocationRef schema used for the tables on the Location Reference database
CREATE SCHEMA [location]

USE [ReferenceLocation]
GO

-- Create Customers table
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [location].[tblCustomer](
	[CustomerGuid] [uniqueidentifier] NOT NULL,
	[CustomerName] [varchar](100) NULL,
	[CustomerId] [varchar](10) NULL,
	[CustId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ContactId] [uniqueidentifier] NULL,
	[CarrierGuid] [uniqueidentifier] NULL,
	[AccountTypeId] [tinyint] NULL,
	[MainAddressId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[AccountStatus] [varchar](20) NULL,
	[Status] [varchar](1) NULL,
	[BillingRep] [uniqueidentifier] NULL,
	BillingRepOffice [varchar](50) NULL,
	BillingRepBusinessUnitId [int] NULL,
	BillingRepBusinessUnit [varchar](50) NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [AK_tblCustomer_CustID] UNIQUE NONCLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[tblCustomer] ADD  CONSTRAINT [DF_tblCustomer_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO



-- Create Contact table
CREATE TABLE [location].[tblContact](
	[ContactGuid] [uniqueidentifier] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[AddressId] [int] NULL,
	[Title] [varchar](100) NULL,
	[CompanyName] [varchar](100) NULL,
	[ChatIm] [varchar](100) NULL,
	[Role] [varchar](15) NULL,
	[Notes] [varchar](200) NULL,
	[Department] [varchar](20) NULL,
	[ContactID] [int] NULL,
	[PrimaryPhoneNumber] [varchar](20) NULL,
	[PrimaryPhoneExt] [varchar](20) NULL,
	[PrimaryPhoneITUCode] [int] NULL,
	[SecondaryPhoneNumber] [varchar](20) NULL,
	[SecondaryPhoneExt] [varchar](20) NULL,
	[SecondaryPhoneITUCode] [int] NULL,
	[MobileNumber] [varchar](20) NULL,
	[MobileITUCode] [int] NULL,
	[FaxNumber] [varchar](20) NULL,
	[FaxITUCode] [int] NULL,
	[BusinessEmail] [varchar](100) NULL,
	[PersonalEmail] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tblContact] PRIMARY KEY CLUSTERED 
(
	[ContactGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[tblContact] ADD  CONSTRAINT [DF_tblContact_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO


-- Create MasterWarehouse table
CREATE TABLE [location].[ParentWarehouse](
	[Id] [uniqueidentifier] NOT NULL,
	[FriendlyId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GNumber] [varchar](12) NULL,
	[Name] [varchar](100) NOT NULL,
	[AddressId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[VersionStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_ParentWarehouse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [AK_ParentWarehouse_FriendlyId] UNIQUE NONCLUSTERED 
(
	[FriendlyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[ParentWarehouse] ADD  CONSTRAINT [DF_ParentWarehouse_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO


-- Create Clientwarehouse table
CREATE TABLE [location].[ChildWarehouse](
	[Id] [uniqueidentifier] NOT NULL,
	[MasterWarehouseId] [uniqueidentifier] NOT NULL,
	[AccountId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[VersionStamp] [timestamp] NOT NULL,
	[OriginDefaultLocationType] [int] NOT NULL,
	[DestinationDefaultLocationType] [int] NOT NULL,
 CONSTRAINT [PK_Warehouse_CChildWarehouse_Id_CreatedDate] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC,
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

ALTER TABLE [location].[ChildWarehouse] ADD  DEFAULT ((1)) FOR [OriginDefaultLocationType]
GO

ALTER TABLE [location].[ChildWarehouse] ADD  DEFAULT ((1)) FOR [DestinationDefaultLocationType]
GO

ALTER TABLE [location].[ChildWarehouse]  WITH NOCHECK ADD  CONSTRAINT [FK_ChildWarehouse_ToCustomersAccountId] FOREIGN KEY([AccountId])
REFERENCES [location].[tblCustomer] ([CustomerGuid])
GO

ALTER TABLE [location].[ChildWarehouse] CHECK CONSTRAINT [FK_ChildWarehouse_ToCustomersAccountId]
GO

ALTER TABLE [location].[ChildWarehouse]  WITH NOCHECK ADD  CONSTRAINT [FK_ChildWarehouse_ToParentWarehouse] FOREIGN KEY([ParentWarehouseId])
REFERENCES [location].[ParentWarehouse] ([Id])
GO

ALTER TABLE [location].[ChildWarehouse] CHECK CONSTRAINT [FK_ChildWarehouse_ToParentWarehouse]
GO
ALTER TABLE [location].[ChildWarehouse] ADD  CONSTRAINT [DF_ChildWarehouse_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO



--Create Address Enriched table
CREATE TABLE [location].[AddressEnriched](
	[AddressId] [int] NOT NULL,
	[Address1] [varchar](200) NULL,
	[Address2] [varchar](200) NULL,
	[CityId] [int] NULL,
	[City] [varchar](100) NULL,
	[StateId] [int] NULL,
	[StateCode] [varchar](5) NULL,
	[State] [varchar](100) NULL,
	[Postal] [varchar](10) NULL,
	[CountryID] [int] NULL,
	[CountryCode] [varchar](3) NULL,
	[Country] [varchar](100) NULL,
	[Latitude] [numeric](10, 6) NULL,
	[Longitude] [numeric](10, 6) NULL,
	[StandardCode] [varchar](10) NULL,
	[TimeZoneName] [varchar](50) NULL,
	[SQLServerTimeZoneName] [varchar](50) NULL,
	[StandardGMTOffset] [decimal](3, 1) NULL,
	[DaylightGMTOffset] [decimal](3, 1) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[EnrichedDate] [datetime] NULL,
	[RDI] [Varchar](1) NULL,
	[GeocodeStatus] [varchar](10) NULL,
	[DayLightSavingIndicator] [varchar](2) NULL
 CONSTRAINT [PK_AddressEnriched_AddressId] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[AddressEnriched] ADD  CONSTRAINT [DF_AddressEnriched_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO



--Create WarehouseLoadCount table
CREATE TABLE [location].[WarehouseLoadCount](
	[Id] [int] NOT NULL,
	[AccountId] [uniqueidentifier] NOT NULL,
	[MasterWarehouseId] [uniqueidentifier] NOT NULL,
	LoadCount [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_WarehouseLoadCount_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[WarehouseLoadCount] ADD  CONSTRAINT [DF_WarehouseLoadCount_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO



--Create Location table
CREATE TABLE [location].[Location](
	[LocationGuid] [uniqueidentifier] NOT NULL,
	[AddressId] [uniqueidentifier] NOT NULL,
	[AddressCertificationStatus] [int] NOT NULL,
	[AddressValidationOverrideIndicator] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Location_Id] PRIMARY KEY CLUSTERED 
(
	[LocationGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [location].[Location] ADD  CONSTRAINT [DF_Location_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO



