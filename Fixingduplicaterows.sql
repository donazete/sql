--USE [Fintrak]
--GO

--/****** Object:  View [dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompanyPerProduct]    Script Date: 09/05/2017 10:59:32 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--CREATE VIEW [dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompanyPerProduct]
--AS
--	SELECT distinct V.[Company]
--      ,V.[CoyCode]
--      ,V.[AttribSetID]
--      ,V.[CustAID]
--      ,V.[Customer]
--      ,V.[OwnerTableID]
--      ,V.[AccountofficerNo]
--      ,V.[AcctOfficer]
--      ,V.[MISCode]
--	  ,C.[FintrakCustID]
--      ,C.[SrcAcctNum]
--      ,C.[FintrakAcctNum]
--      ,C.[SourcePrdCode]
--  FROM [IWGI].[dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompany] V
--	left join (SELECT [ID#]
--				  ,[SourcePrdCode]
--				  ,[FintrakPrdCode]
--				  ,[SrcCustAID]
--				  ,[FintrakCustID]
--				  ,[SrcAcctNum]
--				  ,[FintrakAcctNum]
--				  ,[ProdType]
--				  ,[Company]
--				  ,C.FintrakCoyID
--			  FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping] A
--				inner join [Fintrak].[dbo].[FintrakCompany] C
--					on A.Company = C.fcCompanyID) C
--		on C.SrcCustAID = V.CustAID and C.FintrakCoyID = V.CoyCode
--	--order by V.[CustAID] -- C.[SourcePrdCode]
	



--GO


SELECT distinct V.[Company]
      ,V.[CoyCode]
      ,V.[AttribSetID]
      ,V.[CustAID]
      ,V.[Customer]
      ,V.[OwnerTableID]
      ,V.[AccountofficerNo]
      ,V.[AcctOfficer]
      ,V.[MISCode]
	  ,C.[FintrakCustID]
      ,C.[SrcAcctNum]
      ,C.[FintrakAcctNum]
      ,C.[SourcePrdCode]
  FROM [IWGI].[dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompany] V
	left join (SELECT [ID#]
				  ,[SourcePrdCode]
				  ,[FintrakPrdCode]
				  ,[SrcCustAID]
				  ,[FintrakCustID]
				  ,[SrcAcctNum]
				  ,[FintrakAcctNum]
				  ,[ProdType]
				  ,[Company]
				  ,C.FintrakCoyID
			  FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping] A
				inner join [Fintrak].[dbo].[FintrakCompany] C
					on A.Company = C.fcCompanyID) C
		on C.SrcCustAID = V.CustAID and C.FintrakCoyID = V.CoyCode
where V.[CustAID] = '10026'


select * from [Fintrak].[dbo].[Fintrak_CustAcctMapping]
where SrcCustAID = '10026'

select SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company,  Count(*) as Cnt
from [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company--, Createdby, CreatedDatetime
order by Cnt desc


select SourcePrdCode, SrcCustAID, Count(*) as Cnt
from [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, SrcCustAID--, Createdby, CreatedDatetime
order by Cnt desc


drop table HoldingTable
drop table Holder


select * from holder


select SourcePrdCode, SrcCustAID, Count(*) as Cnt
into Holder
from [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, SrcCustAID
Having Count(*) > 1


select Distinct C.SourcePrdCode, FintrakPrdCode, C.SrcCustAID, FintrakCustID, SrcAcctNum
	, (Select top 1 FintrakAcctNum from [Fintrak_CustAcctMapping] where SourcePrdCode = C.SourcePrdCode and SrcCustAID = C.SrcCustAID) as FintrakAcctNum
	, ProdType, Company
into HoldingTable
from [Fintrak].[dbo].[Fintrak_CustAcctMapping] C, Holder
Where Holder.SourcePrdCode = C.SourcePrdCode and Holder.SrcCustAID = C.SrcCustAID
--Group by SourcePrdCode, SrcCustAID
--Having Count(*) > 1


select SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company, Count(*) as Cnt
into HoldingTable
from [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, SrcCustAID
Having Count(*) > 1


select * from HoldingTable
where SrcCustAID = '10026'

Begin tran

Delete C 
from [Fintrak].[dbo].[Fintrak_CustAcctMapping] C, HoldingTable T
where C.SourcePrdCode = T.SourcePrdCode and C.SrcCustAID = T.SrcCustAID 

commit


Begin tran

insert into [Fintrak].[dbo].[Fintrak_CustAcctMapping] (SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company)
select SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company
from HoldingTable


commit
rollback


select * from Fintrak_CustAcctMapping
where SrcCustAID = '2609'


USE [Fintrak]
GO

/****** Object:  Index [IX_EndofDayBalance_1]    Script Date: 09/05/2017 10:56:06 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustAcctMapping_1] ON [dbo].[Fintrak_CustAcctMapping]
(
	SourcePrdCode ASC, SrcCustAID ASC, ProdType ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
