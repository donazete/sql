/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Custaid, Name
	, Sum(TotalConsideration) TotalConsideration
	, Sum(TotalCommission) TotalCommission
	, Sum(TotalAmountTraded) TotalAmountTraded
	, AccountOfficer 
FROM (SELECT S.[CustAID], C.Name
      , Sum(S.[Consideration]) as TotalConsideration
      ,Sum(S.[Commision]) as TotalCommission
      ,Sum(S.[TotalAmt]) as TotalAmountTraded
	  , C.AccountOfficer
	  , C.AccountOfficer_ID
  FROM [dbo].[IWVW_Stkb_SoldEx] S
	inner join IWVW_Cust_Customers C
		on C.CustAID = S.CustAID
  Where Year(DateAlloted) = 2016 --and C.AccountOfficer_ID IN ('185', '142')
  Group by S.[CustAID] , C.Name, C.AccountOfficer, C.AccountOfficer_ID
  --Order by C.AccountOfficer, S.CustAID
  UNION ALL

  SELECT S.[CustAID], C.Name
      , Sum(S.[Consideration]) as TotalConsideration
      ,Sum(S.[Commision]) as TotalCommission
      ,Sum(S.[TotalAmt]) as TotalAmountTraded
	  , C.AccountOfficer
	  , C.AccountOfficer_ID
  FROM [dbo].[IWVW_Stkb_PurchasesEx] S
	inner join IWVW_Cust_Customers C
		on C.CustAID = S.CustAID
  Where Year(DateAlloted) = 2016 --and C.AccountOfficer_ID IN ('185', '142')
  Group by S.[CustAID], C.Name, C.AccountOfficer, C.AccountOfficer_ID) A
  Group by Custaid, Name, AccountOfficer
  Order by AccountOfficer, CustAID, Name