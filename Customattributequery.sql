/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [AttribSetID]
      ,[OwnerTableID]
	  , C.CustAID
      ,[Value]
	  , C.Name
	  , C.Email1
	  , C.Phone1
  FROM [IWGI].[dbo].[Attrib_Values] V
	Inner join IWVW_Cust_Customers C
		ON C.ID# = V.OwnerTableID
Where AttribSetID = 53 and Value = 'Payout'