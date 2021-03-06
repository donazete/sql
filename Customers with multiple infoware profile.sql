/****** Script for SelectTopNRows command from SSMS  *****/
IF EXISTS (Select name from sysobjects Where name = N'vwFintrak_CustwithMultProfile') 
	DROP VIEW vwFintrak_CustwithMultProfile
GO
CREATE VIEW vwFintrak_CustwithMultProfile
AS
	SELECT [NID#]
		, CC.ID#
		, CC.CustAID
		, IM.ParentCustomerID
		, (Select CustAID from IWGI.dbo.Cust_Customers where ID# = IM.ParentCustomerID) as parentcust
		, (Select [FintrakCustAID] from [dbo].[Fintrak_CustMapping] Where SourceCustAID = (Select CustAID from IWGI.dbo.Cust_Customers where ID# = IM.ParentCustomerID)) as ParentFintrakNo
			  FROM [Fintrak].[dbo].[InfoWARECustomerCleanup] ic
			  LEFT JOIN [Fintrak].[dbo].[InfoWAREMatchedCustomer] IM ON IM.MatchedCustomerID = IC.NID#
			  left join IWGI.dbo.Cust_Customers CC on IC.NID# = CC.ID#
			  WHERE IM.MatchedCustomerID <> IM.ParentCustomerID



Begin tran

UPDATE F
SET [FintrakCustAID] = P.ParentFintrakNo
from [dbo].[Fintrak_CustMapping] F
	inner join vwFintrak_CustwithMultProfile P
		on F.SourceCustAID = P.CustAID
Where F.[SourceCustAID] IN (Select Custaid from vwFintrak_CustwithMultProfile) and P.parentcust not like '%AGNT%'

commit
rollback


Select * from [dbo].[Fintrak_CustMapping] F
Where F.[SourceCustAID] IN (Select Custaid from vwFintrak_CustwithMultProfile)



Select [SourceCustAID], [FintrakCustAID] 
from [dbo].[Fintrak_CustMapping] F
Where F.[SourceCustAID] IN (Select Custaid from vwFintrak_CustwithMultProfile)
order by SourceCustAID



(Select [FintrakCustAID] 
							from [dbo].[Fintrak_CustMapping] C 
							Where SourceCustAID = (Select ParentCust from vwFintrak_CustwithMultProfile where CustAID ='10026'))




= (Select [FintrakCustAID] 
							from [dbo].[Fintrak_CustMapping] C 
							Where SourceCustAID = (Select ParentCust from vwFintrak_CustwithMultProfile where CustAID = F.[SourceCustAID]))




--Query for customer information extraction

Select CC.Custaid, F.FintrakCustAID, C.* from 
[dbo].[InfoWARECustomerCleanup] C
left join IWGI.dbo.Cust_Customers CC
	on C.NID# = CC.ID#
left join [dbo].[Fintrak_CustMapping] F
	on CC.Custaid = F.SourceCustAID
Where C.NID# not in (SELECT [NID#]     
		  FROM [Fintrak].[dbo].[InfoWARECustomerCleanup] ic
		  LEFT JOIN [Fintrak].[dbo].[InfoWAREMatchedCustomer] IM ON IM.MatchedCustomerID = IC.NID#
		  WHERE IM.MatchedCustomerID <> IM.ParentCustomerID)



/*
Select * from vwFintrak_CustwithMultProfile




Select [FintrakCustAID] 
from [dbo].[Fintrak_CustMapping] C 
Where SourceCustAID = (Select ParentCust from vwFintrak_CustwithMultProfile where CustAID = F.[SourceCustAID]) */