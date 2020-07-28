select * from OP_IFund_Trans
Where CustID = '16804' and Liquidated = 0
order by Trans#



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID]
      ,[CustNo]
      ,V.[Name]
      ,[ValDt]
      ,[Amount]
      ,[Units]
      ,[Fund]
      ,C.[Address1]
      ,[Price]
      ,C.Email1
  FROM [Fintrak].[dbo].[VDFVEIF] V
	inner join IWVW_Cust_Customers C
		on V.CustNo = C.CustAID



  delete FROM [Fintrak].[dbo].[VDFVEIF]
  Where custno = ''