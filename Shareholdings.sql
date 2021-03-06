/****** Script for SelectTopNRows command from SSMS  ******/
SELECT P.[Customer Acct]
	  , C.Name
	  , C.Email1
	  , C.Phone1
      ,P.[StockCode]
      ,Sum(P.[Units]) as Units
  FROM [IWGI].[dbo].[Stkb_Portfolio] P
	inner join IWVW_Cust_Customers C
		on C.CustAID = P.[Customer Acct]
  where [Purchase Date] <= '03/14/2017' and StockCode = 'guinness'
  Group by [Customer Acct]
		, C.Name
      ,[StockCode]
	   , C.Email1
	  , C.Phone1
Having Sum([Units]) > 0