/****** Script for SelectTopNRows command from SSMS  ******/
Begin tran

Update [IWGI].[dbo].[Attrib_Values]
Set Value = 125
 Where AttribSetID = 31 and OwnerTableID IN (Select ID# from [IWGI].[dbo].Cust_Customers where CustAID IN (Select CustAID from [IOFS].dbo.FrancisCust))

 --commit


 Select * from  [IWGI].[dbo].[Attrib_Values]
 Where AttribSetID = 31 and OwnerTableID IN (Select ID# from [IWGI].[dbo].Cust_Customers where CustAID IN (Select CustAID from [IOFS].dbo.FrancisCust))





  Select F.CustAID, C.ID#, A.Value from Cust_Customers C
  inner join [IOFS].dbo.FrancisCust F
  on F.CustAID = C.CustAID
  Left Join [IWGI].[dbo].[Attrib_Values] A
	on A.OwnerTableID = C.ID# and A.AttribSetID = 31
  Order by A.Value

  Select * from OP_Officers
  Where IDNumber = '142'