/****** Script for SelectTopNRows command from SSMS  ******/
SELECT I.ID
      ,I.dDate
      ,I.DealID1
	  , C.CSName
	  , C.CFName
	  , C.CName
      ,I.iPrincipal
      ,I.InterestRate
      ,I.EffectiveDate
      ,I.iAccrualTodate
      ,I.IPTDay
      ,I.IPTDate
      ,I.LastEOD
      ,I.InterestAmount
      ,I.noOfDays
      ,I.scheduled
      ,I.BackDated
      ,I.suspendInterest
      ,I.DateSuspended
  FROM FinTrakFundManager.dbo.ts_Banking_DailyInterestAccrued I
	inner join FinTrakFundManager.dbo.ts_Banking_LoanLease L
		on I.DealID1 = L.productAcctNo
	inner join ts_Banking_Customers C
		on L.CustCode = C.CCode
  Where DealID1 in (select productAcctNo from FinTrakFundManager.dbo.ts_Banking_LoanLease where coycode = 7 and Disapprove = 0)
  order by dDate




  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 L.ID
      ,L.CustCode
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  , C.CSName
	  , C.CFName
	  , C.CName
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
      ,L.Moratorium
      ,L.Installments
      ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
      ,L.LastprincipalPaid
      ,L.InstalmentLeft
      ,L.Approved
      ,L.ApprovedBy
      ,L.DateApproved
      ,L.Status
      ,L.CurrentAcct
      ,L.Disapprove
      ,L.LastInterestPaid
      ,L.OperationId
      ,L.SBUMIS
      ,L.Officer1
      ,L.Officer2
      ,L.Disbursed
      ,L.Disburser
      ,L.DateOfDisburse
      ,L.DisburseComment
      ,L.OpeningComment
      ,L.ApprovalComment
      ,L.ApproveOpComment
      ,L.ApproveMaintainComment
      ,L.Email
      ,L.Sms
      ,L.InternetBanking
      ,L.SchMethod
      ,L.Lien
      ,L.GroupNo
      ,L.GroupID
      ,L.riskass
      ,L.Frequency
      ,L.BulletType
      ,L.BulletFreq
      ,L.FreqType
      ,L.BulletName
      ,L.BulletFReqName
      ,L.Legals
      ,L.Cam
      ,L.OfferLetter
      ,L.TargetAmount
      ,L.Ref
      ,L.profileLoan
      ,L.TenorMode
      ,L.MoraWinthInterest
      ,L.DisChargeLetter
      ,L.TempCam
      ,L.TempRisk
      ,L.RiskReceived
      ,L.LegalReceived
      ,L.InterestAmount
      ,L.MaturityAmount
      ,L.Upload
      ,L.SchPayment
      ,L.CategoryID
      ,L.pdTypeID
      ,L.Paid
      ,L.AmountPaid
      ,L.Currency
      ,L.PeriodicPay
      ,L.DatePaid
      ,L.NHF
      ,L.CreditMandate
      ,L.AgreeLoan
      ,L.SetOff
      ,L.CurrRate
      ,L.FeePercent
      ,L.FeeFrequency
      ,L.FirstpayDate
      ,L.SetEqualDate
      ,L.ApprovalType
      ,L.OutstandingPrincipal
      ,L.noOfPrincipalAddition
      ,L.noOfPrincipalReduction
      ,L.SuspendInterest
      ,L.CanDisburse
      ,L.PCcode1
      ,L.PCcode2
      ,L.Booked
      ,L.Scheduled
      ,L.ApprovedAmount
      ,L.PrincipalFrequency
      ,L.PrincipalFreqType
      ,L.FixedPrincipal
      ,L.CreatedBy
  FROM FinTrakFundManager.dbo.ts_Banking_LoanLease L
	inner join ts_Banking_Customers C
		on L.CustCode = C.CCode
  where L.coycode = 7 and L.Disapprove = 0

  

  SELECT TOP 1000 I.ID
      ,I.CustomerName
      ,I.Principal
      ,I.LastPrincipalPaid
      ,I.LastInterestPaid
      ,I.Tenor
      ,I.Rate
      ,I.Moratorium
      ,I.Instalment
      ,I.ProductName
      ,I.CustCode
      ,I.ProdCode
      ,I.DateCreated
      ,I.DateTerminated
      ,I.CoyCode
      ,I.ApprovedAdvance
      ,I.ApprovedLease
      ,I.ApprovedLoan
      ,I.ApprovedBy
      ,I.dateApproved
      ,I.ProductAccNo
      ,I.InstalmentLeft
      ,I.Remark
      ,I.BranchId
      ,I.DisapprovedAdvance
      ,I.DisapprovedLease
      ,I.DisapprovedLoan
      ,I.ProductType
      ,I.MisCode
      ,I.PenalCharge
      ,I.Comment
      ,I.OperationId
      ,I.CurrentAcctNo
      ,I.ExcessInterest
      ,I.BatchRef
  FROM I.FinTrakFundManager.I.dbo.I.ts_Banking_Termination
  Where coycode = 7

  SELECT H.[ID]
      ,[dDate]
      ,[DealID1]
	  , C.CSName
	  , C.CFName
	  , C.CName
      ,[iPrincipal]
      ,[InterestRate]
      ,[EffectiveDate]
      ,[iAccrualTodate]
      ,[IPTDay]
      ,[IPTDate]
      ,[LastEOD]
      ,H.[InterestAmount]
      ,[noOfDays]
      ,H.[scheduled]
      ,[TransDate]
  FROM [FinTrakFundManager].[dbo].[ts_Banking_DailyInterestAccruedHistory] H
  inner join FinTrakFundManager.dbo.ts_Banking_LoanLease L
		on DealID1 = L.productAcctNo
	inner join ts_Banking_Customers C
		on L.CustCode = C.CCode
  Where DealID1 in (select productAcctNo from FinTrakFundManager.dbo.ts_Banking_LoanLease where coycode = 7 and Disapprove = 0)
  order by dDate