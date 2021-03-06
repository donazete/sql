/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[PdName]
      ,[PdCode]
      ,[PdID]
      ,[PdTypeID]
      ,[CustCode]
      ,[ProductAcctNo]
      ,[Customer]
      ,[DisbursedBy]
      ,[DateDisbursed]
      ,[DateCreated]
      ,[AccountID]
      ,[PrincipalAmt]
      ,[Rate]
      ,[Moratorium]
      ,[Tenor]
      ,[Instalment]
      ,[CoyCode]
      ,[BrCode]
      ,[MisCode]
      ,[EffectiveDate]
      ,[MaturityDate]
      ,[CoyClass]
      ,[LoanAccount]
      ,[Ref]
      ,[CurrentAccount]
      ,[Paid]
      ,[AmountPaid]
      ,[Balance]
      ,[Frequency]
      ,[BulletType]
      ,[BulletFreq]
      ,[FreqType]
      ,[BulletName]
      ,[BulletFReqName]
      ,[SchMethod]
      ,[Approved]
      ,[Disapproved]
      ,[DateApproved]
      ,[comment]
      ,[OperationID]
      ,[AddingPrincipal]
      ,[OutstandingPrincipal]
      ,[AccruedInterest]
      ,[ApproveRemark]
      ,[ApprovedBy]
      ,[PrincipalReview]
  FROM [FinTrakFundManager].[dbo].[ts_Banking_Disbursement]
  WHERE ProductAcctNo IN ('101794620000')

  SELECT * FROM ts_Banking_LoanLease
  WHERE custcode = '1017946'   --ProductAcctNo = '101873220004'

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [FinTrakFundManager].[dbo].[ts_Banking_PrincipalReduction]
  where ProductAcctNo = '101794620000'


select * from [dbo].[ts_Banking_Termination]
where ProductAccNo = '101794620000'

select * from ts_Finance_Transaction
where LEGTYPE = '101794620000'


  --begin tran

  --UPDATE ts_Banking_LoanLease
  --SET Approved = 0, Disapprove = 1, CanDisburse = 0
  --WHERE ProductAcctNo = '101873220004'

  --commit