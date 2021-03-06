/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW vwFintrakCusttoAcctOfficerMISCodePerCompany
AS

SELECT 'IOSTK' as Company
		, 2 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 17 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 31

  union all

  SELECT 'IOFS' as Company
		, 1 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 18 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 32

  union all

  SELECT 'IOFM' as Company
		, 3 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 19 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 33

  union all

  SELECT 'VENCAP' as Company
		, 6 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 21 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 34

  union all

  SELECT 'ORANGE' as Company
		, 7 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 20 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 35

  union all

  SELECT 'CAPMGT' as Company
		, 5 as CoyCode
		,V.[AttribSetID]
		, C.CustAID
		, C.Name as  Customer
      ,V.[OwnerTableID]
      ,V.[Value] as AccountofficerNo
	  , (Select Officer from IWGI.dbo.OP_Officers Where IDNumber = V.Value) as AcctOfficer
	  , (Select Value from [IWGI].[dbo].[Attrib_Values] where AttribSetID = 22 
		and OwnerTableID = (Select ID# from IWGI.dbo.OP_Officers Where IDNumber = V.Value)) as MISCode
  FROM [IWGI].[dbo].[Attrib_Values] V
  left join IWGI.dbo.Cust_Customers C
	on C.ID# = V.OwnerTableID
  Where AttribSetID = 36

 -- order by AcctOfficer desc

GO