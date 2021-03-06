/******

18th Jan 2017 Vuew created by Oyeleye Donald

View gets the MIS code for the account officer assigned to each customer per business.

Ver 1.0 18-01-2017 Oyeleye Donald View created

*/

CREATE VIEW vwFintrak_CusttoAcctOfficerMISCode
AS

Select Distinct C.CustAID
	, C.Name
	, A.AccountID
	, Case 
		When A.AccountID = '3000' Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 17 and OwnerTableID =(Select ID# from IWGI.[dbo].[OP_Officers] Where IDNUMber = (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 31 and OwnerTableID = C.ID#)))
		When A.AccountID = '3001' or A.AccountID = '3005' or A.AccountID = '3006' or A.AccountID = '3007' or A.AccountID = '3008' or A.AccountID = '1004'  
			Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 18 and OwnerTableID = (Select ID# from IWGI.[dbo].[OP_Officers] Where IDNUMber = (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 32 and OwnerTableID = C.ID#)))
		When A.AccountID = '3002' or A.AccountID = '3003' or A.AccountID = '3004' or A.AccountID = '250001' or A.AccountID = '22001' or A.AccountID = '2204'  
			Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 19 and OwnerTableID = (Select ID# from IWGI.[dbo].[OP_Officers] Where IDNUMber = (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 33 and OwnerTableID = C.ID#)))
	End as MISCode
	, Case 
		When A.AccountID = '3000' Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 31 and OwnerTableID = C.ID#)
		When A.AccountID = '3001' or A.AccountID = '3005' or A.AccountID = '3006' or A.AccountID = '3007' or A.AccountID = '3008' or A.AccountID = '1004'  
			Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 32 and OwnerTableID = C.ID#)
		When A.AccountID = '3002' or A.AccountID = '3003' or A.AccountID = '3004' or A.AccountID = '250001' or A.AccountID = '22001' or A.AccountID = '2204'  
			Then (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 33 and OwnerTableID = C.ID#)
	End as AcctOfficerCode
	, Case 
		When A.AccountID = '3000' Then (Select Officer from IWGI.[dbo].[OP_Officers] Where IDNumber in (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 31 and OwnerTableID = C.ID#))
		When A.AccountID = '3001' or A.AccountID = '3005' or A.AccountID = '3006' or A.AccountID = '3007' or A.AccountID = '3008' or A.AccountID = '1004'  
			Then (Select Officer from IWGI.[dbo].[OP_Officers] Where IDNumber in (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 32 and OwnerTableID = C.ID#))
		When A.AccountID = '3002' or A.AccountID = '3003' or A.AccountID = '3004' or A.AccountID = '250001' or A.AccountID = '22001' or A.AccountID = '2204'  
			Then (Select Officer from IWGI.[dbo].[OP_Officers] Where IDNumber in (Select Value from IWGI.[dbo].[Attrib_Values] Where AttribSetID = 33 and OwnerTableID = C.ID#))
	End as AcctOfficerName
From IWGI.dbo.IWVW_Cust_Customers C
	left join IWGI.dbo.Acct_Subs A
		on C.CustAID = A.Sub
Where A.AccountID IN (SELECT Distinct [AID]
						FROM IWGI.[dbo].[OP_InvolvmentAccts])
--Order by C.CustAID

GO