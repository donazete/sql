Declare @Dt as datetime

Set @Dt = '05/09/2017'

While @Dt < '06/14/2017'
Begin

INSERT INTO Fintrak.dbo.Commission_Fees ([Trans_DT]
      ,[Value_DT]
      ,[Amount]
      ,[Narration]
      ,[Ref]
      ,[MISCode]
      ,[OrigBranch]
      ,[Currency]
      ,[Contra]
      ,[FintrakAcctNum]
      ,[InfowareAcctNum]
      ,[FintrakCustID]
      ,[CustAID]
      ,[AcctOfficercode])
Select TxnDate as Trans_DT
	, DateAlloted as Value_DT
	, Commision as Amount
	, 'Stock Purchase CustNo: '+S.CustAID+' Symbol: '+S.StockCode+' Qty: '+Convert(varchar, S.Qty) as Description
	, '413001' as Ref
	, F.MISCode
	, 'VIC100' as OrigBranch
	, 'NGN' as CurrencyCode
	, '' as Contra
	, F.FintrakAcctNum
	, '300'+S.CustAID as InfowareAcctNum
	, F.FintrakCustID
	, F.CustAID
	, F.MISCode as AcctOfficercode
from IWGI.dbo.IWVW_Stkb_Soldex S
	left join [Fintrak].[dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompanyPerProduct] F
	on S.CustAID = F.CustAID and F.SourcePrdCode = '300'
Where S.DateAlloted = @Dt

union all

Select TxnDate as Trans_DT
	, DateAlloted as Value_DT
	, Commision as Amount
	, 'Stock Sale CustNo: '+S.CustAID+' Symbol: '+S.StockCode+' Qty: '+Convert(varchar, S.Qty) as Description
	, '413002' as Ref
	, F.MISCode
	, 'VIC100' as OrigBranch
	, 'NGN' as CurrencyCode
	, '' as Contra
	, F.FintrakAcctNum
	, '300'+S.CustAID as InfowareAcctNum
	, F.FintrakCustID
	, F.CustAID
	, F.MISCode as AcctOfficercode
from IWGI.dbo.IWVW_Stkb_PurchasesEx S
	left join [Fintrak].[dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompanyPerProduct] F
	on S.CustAID = F.CustAID and F.SourcePrdCode = '300'
Where S.DateAlloted = @Dt

	Set @Dt = Dateadd(dd,1,@Dt)

end