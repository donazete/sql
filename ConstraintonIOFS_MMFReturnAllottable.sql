/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[FundCode]
      ,[ValDate]
      ,[DailyReturn]
      ,[TotalUnits]
      ,[AccrualRate]
      ,[Txndate]
  FROM [IWGI].[dbo].[IOFS_FIFundDailyReturns]
  Where Valdate > = '12/13/2019'


  Begin tran

--  ALTER TABLE IOFS_MMFundReturnsAllot
--ALTER COLUMN AllotType int NOT NULL

  ALTER TABLE IOFS_MMFundReturnsAllot
ADD CONSTRAINT PK_Allotment PRIMARY KEY ([FundCode]
      ,[AllotDate]
      ,[CustAID], Allottype)

	  commit

	  rollback


	  select * from IOFS_MMFundReturnsAllot
	  Where FundCode = 'ABACUS' and Custaid = '18185' and AllotDate ='08/31/2017'