/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [client_code]
      ,[ClientName]
      ,[client_FName]
      ,[client_SName]
      ,[client_TName]
      ,[BackOfficeCodeEquity] as MilesCode
      ,[MainClientCode]
      ,[MapinCode]
      ,[MapCode]
      ,[UCC]
  FROM [MWIntegra].[dbo].[HDR_Client_maker]