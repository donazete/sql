/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Distinct [Trans#]
      ,[CustID]
      ,(Select top 1 principal from [IWGI].[dbo].[OP_IFund_Trans] where trans# = O.Trans# order by id# desc) as Principal
	  , InterestRate
	  , (Select top 1 MaturityDate from [IWGI].[dbo].[OP_IFund_Trans] where trans# = O.Trans# order by id# desc) as MaturityDate
      ,[CPGLAid]
  FROM [IWGI].[dbo].[OP_IFund_Trans] O
  Where Liquidated = 0 and (Select top 1 principal from [IWGI].[dbo].[OP_IFund_Trans] where trans# = O.Trans# order by id# desc) >= 50000000 and CPGLAid != '3009'
  order by Trans#