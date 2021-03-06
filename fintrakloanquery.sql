/****** Script for SelectTopNRows command from SSMS  ******/
SELECT L.ID
      ,L.CustCode
	  ,C.CustCode
	  ,C.AccountName
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  ,(select Sum(debitamt) from FinTrakFundManager.dbo.ts_finance_transaction  where LEGTYPE = L.ProductAcctNo  and Description like 'Daily%') as interestaccruedasat17thMar
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
      ,L.Installments
      ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
      ,L.LastprincipalPaid
      ,L.InstalmentLeft
      ,L.CurrentAcct
	  , C.ProductAcctNo
      ,L.Disapprove
      ,L.LastInterestPaid
      ,L.Disbursed
      ,L.Disburser
      ,L.DateOfDisburse
      ,L.InterestAmount
      ,L.MaturityAmount
      ,L.Paid
      ,L.AmountPaid
      ,L.Currency
      ,L.PeriodicPay
      ,L.DatePaid
      ,L.OutstandingPrincipal
      ,L.noOfPrincipalAddition
      ,L.Booked
      ,L.Scheduled
      ,L.ApprovedAmount
      ,L.CreatedBy
  FROM FinTrakFundManager.dbo.ts_Banking_LoanLease L
	inner join [FinTrakFundManager].[dbo].[ts_Banking_CASA] C
		on L.CurrentAcct = C.ProductAcctNo
  where L.Approved = 1
  -- = '1014446000'