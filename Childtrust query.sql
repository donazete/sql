/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Distinct M.[FundCode]
      ,M.[CustAID]
	  ,C.CustAID
	  , C.Name
	  , C.Address1
	  , C.Address2
	  , C.City
	  , C.CreateDate
	 -- , Sum(Case Txntype
		--	When 0 then M.Amount
		--	else M.Amount * -1
		--end) as RYTDCont
	, Case
		When A.amount > 0 then A.Amount
		Else 0
	End as YTDCont
	, (Select top 1 Date from [dbo].[OP_MFTxns2] Where Custaid = M.[CustAID] order by Date desc) as lasttxndate
  FROM [dbo].[OP_MFTxns2] M
	inner join IWVW_Cust_Customers C
		on C.Custaid = M.CustAID
	left join (Select Fundcode, Custaid, Sum(Case Txntype
					When 0 then Amount
					else Amount * -1
					end) as amount 
				from [dbo].[OP_MFTxns2]
				 --Where Fundcode = 'CHDTRST' and CustAID = C.CustAID
				 Group by Fundcode, CustAID ) as A
		on M.CustAID = A.Custaid
WHERE M.FundCode = 'CHDTRST'
order by Name


Select * from OP_MFTxns2
Where CustAID = '4988'

Select * from Acct_GL
Where AccountID = '3002' and Sub = '4988'