/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1 [ID#]
      ,[FundCode]
      ,[IntRate]
      ,[EffectiveDate]
      ,[UserID]
      ,[TxnDate]
  FROM [dbo].[IOFS_FIFundRates]
  Where EffectiveDate <= @Dt and FundCode = @MFCode
  Order by EffectiveDate desc, ID# desc