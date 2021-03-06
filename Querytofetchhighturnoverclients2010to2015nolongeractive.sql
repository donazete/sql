/****** Script for SelectTopNRows command from SSMS  ******/
Select A.CustAID, C.Name, C.Phone1, C.Email1, Sum(TotalAmt) as Turnover
	, (Select top 1 DateAlloted
		 from  (SELECT DateAlloted
		  FROM [IWGI].[dbo].[IWVW_Stkb_SoldEx]
		  Where CustAID =  A.CustAID
		  union
		  SELECT DateAlloted
		  FROM [IWGI].[dbo].[IWVW_Stkb_PurchasesEx]
		  Where CustAID =  A.CustAID) B
			order by DateAlloted desc) as LastTradeDt
From (SELECT [ID#]
      ,[DateAlloted]
      ,[CustAID]
      ,[StockCode]
      ,[Qty]
      ,[UnitPrice]
      ,[Consideration]
      ,[SecFee]
      ,[Commision]
      ,[VAT]
      ,[TotalAmt]
      ,[PM_ID]
      ,[Posted]
      ,[JbkTxnNum]
      ,[StampDuty]
      ,[NSEFee]
      ,[CSCSFee]
      ,[NASDFEE]
      ,[TxnType]
      ,[UserID]
      ,[TxnDate]
      ,[CSCSAcct#]
  FROM [IWGI].[dbo].[IWVW_Stkb_SoldEx]
  union all
  SELECT [ID#]
      ,[DateAlloted]
      ,[CustAID]
      ,[StockCode]
      ,[Qty]
      ,[UnitPrice]
      ,[Consideration]
      ,[SecFee]
      ,[Commision]
      ,[VAT]
      ,[TotalAmt]
      ,[PM_ID]
      ,[Posted]
      ,[JbkTxnNum]
      ,[StampDuty]
      ,[NSEFee]
      ,[CSCSFee]
      ,[NASDFEE]
      ,[TxnType]
      ,[UserID]
      ,[TxnDate]
      ,[CSCSAcct#]
  FROM [IWGI].[dbo].[IWVW_Stkb_PurchasesEx]) A
  inner join IWVW_Cust_Customers C
	on C.CustAID = A.Custaid
  Where Year(DateAlloted) between 2010 and 2015 and A.CustAID not in (
														  SELECT [CustAID]
														  FROM [IWGI].[dbo].[IWVW_Stkb_SoldEx]
														  Where Year(DateAlloted) = 2016
														  union
														  SELECT [CustAID]
														  FROM [IWGI].[dbo].[IWVW_Stkb_PurchasesEx]
														  Where Year(DateAlloted) = 2016)
  Group by A.CustAID, C.Name, C.Phone1, C.Email1
  Having Sum(TotalAmt)>= 15000000
  order by Turnover desc


--Select top 1 DateAlloted
-- from  (SELECT DateAlloted
--  FROM [IWGI].[dbo].[IWVW_Stkb_SoldEx]
--  Where CustAID =  A.CustAID
--  union
--  SELECT DateAlloted
--  FROM [IWGI].[dbo].[IWVW_Stkb_PurchasesEx]
--  Where CustAID =  A.CustAID) B
--  order by DateAlloted desc