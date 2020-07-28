select c.* 
	, format(c.CreateDate, 'yyyy-MM-dd') CreateDate
	, format(c.BirthDay, 'yyyy-MM-dd') BirthDay
	, (sELECT top 1 P.Description FROM Op_ContactsBankInfo B  left join pParams P on B.BankCode = P.Code and P.Type = 'BANKNAMES' Where ParentRowID = C.ID# and ContactInfoOwnerID = 2) as Bank
	, (sELECT top 1 AcctNumber FROM Op_ContactsBankInfo Where ParentRowID = C.ID# and ContactInfoOwnerID = 2) as AcctNum
	, 'CURRENT' as AcctType
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 51 and OwnerTableID = C.ID#) as VGIFCustomerNumber
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 54 and OwnerTableID = C.ID#) as VGIFDivOpt
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 13 and OwnerTableID = C.ID#) as Occupation
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 14 and OwnerTableID = C.ID#) as BusinessType
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 15 and OwnerTableID = C.ID#) as DateofInc
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 16 and OwnerTableID = C.ID#) as PEP
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 37 and OwnerTableID = C.ID#) as BVN
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 38 and OwnerTableID = C.ID#) as RCNum_Idnum
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 40 and OwnerTableID = C.ID#) as IDType
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 41 and OwnerTableID = C.ID#) as LGA
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 42 and OwnerTableID = C.ID#) as Employer
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 43 and OwnerTableID = C.ID#) as EmployerAddy
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 44 and OwnerTableID = C.ID#) as Fundsource
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 45 and OwnerTableID = C.ID#) as NextofKinAddy
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 46 and OwnerTableID = C.ID#) as NextofKinPhone
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 47 and OwnerTableID = C.ID#) as MaidenName
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 48 and OwnerTableID = C.ID#) as VBFRegNum
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 49 and OwnerTableID = C.ID#) as AbacusRegNum
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 50 and OwnerTableID = C.ID#) as IsVGIFCust
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 52 and OwnerTableID = C.ID#) as VGIFRegNum
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 53 and OwnerTableID = C.ID#) as AbacusDivOpt
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 59 and OwnerTableID = C.ID#) as SMSSub
	--, Replace(Replace(REPLACE(C.Address1, CHAR(10), ''), CHAR(13), ''), CHAR(9), '') as Address1
from IWVW_Cust_Customers c
Where ID# > 62418 --and (sELECT top 1 AcctNumber FROM Op_ContactsBankInfo Where ParentRowID = C.ID# and ContactInfoOwnerID = 2) IS NOT NULL
order by ID#

select * from pParams
Where [Type] = 'BANKNAMES'

select * from IWVW_Cust_Customers
Where CustAID = '28712'


--select * from Stkb_Portfolio
--Where [Customer Acct] = '2514' and StockCode = 'fbnh'
--order by CSCSAcct#, [Purchase Date]



--select CSCSAcct#, Stockcode, SUM(Units) from Stkb_Portfolio
--Where [Customer Acct] = '2514' --and StockCode = 'guaranty'
--group by Stockcode,CSCSAcct#
----order by [Purchase Date]



--select * from Stkb_Portfolio
--Where [Customer Acct] = '2514' and StockCode = 'guaranty' and ABS(units) = 390
--order by [Purchase Date]


--select * from Stkb_Portfolio
--Where ID# in (150957,286833,295530)

--begin tran

--update Stkb_Portfolio
--set CSCSAcct# = '0011163564'
--Where ID# in (150957,286833,295530)

--commit



select * from Stkb_JobbingBookTxn
where CustNo = '5280' and Cancelled= 0 and Alloted = 0


select * from Stkb_JobbingBookTxn
where CustNo = '5280' and EffectiveDate = '10/17/2017'


select * from Stkb_JobbingBookTxn
where CustNo = '11881' 