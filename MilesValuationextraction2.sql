/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [MFCode]
      ,[ValuationDate]
	  ,[OfferPrice]
      ,[UnitsOutstanding]
	  ,[MktValue]
      ,[BidPrice]
  FROM [IWGI].[dbo].[IWVW_MFValuation2]
  order by MFCode, ValuationDate