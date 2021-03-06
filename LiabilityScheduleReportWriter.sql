/****** Script for SelectTopNRows command from SSMS  ******/
SELECT I.ID#
      ,I.Trans#
      ,I.CustID
	  , C.Name
      ,I.Principal
      ,I.InterestRate
      ,I.EffectiveDate
      ,I.Tenure
      ,I.MaturityDate
      ,I.[Principal + Interest]
      ,I.RollOverDate
      ,I.BrokeragePaid
      ,I.InterestAmount
      ,I.UpfrontInterest
      ,I.BackendInterest
      ,I.EffectiveCost
      ,I.WeightedCost
      ,I.AccountOfficer
      ,I.[BackEndInt?]
      ,I.CPGLAid
      ,I.CPGLSub
      ,I.SuspenseAID
      ,I.SuspenseSub
      ,I.PerAnnumInterest
      ,I.OrigPrincipal
      ,I.Liquidated
      ,I.FirstRec
      ,I.UserID
      ,I.TxnDate
      ,I.PnLAID
      ,I.PnLSub
      ,I.InterestRecAID
      ,I.InterestRecSub
      ,I.InstrumentType
	  ,(Select top 1 Amount from Acct_GL
			Where AccountID = I.PnLAID and Sub = I.PnLSub and EffectiveDate >= '01/01/2016' and SysRef = 'IFLQ-'+Convert(Varchar(10),I.ID#)) as InterestPaid
  FROM [IWGI].[dbo].[OP_IFund_Trans] I
	inner join Cust_Customers C
		on C.Custaid = I.CustID
Where I.Liquidated = 1 and I.FirstRec = 1 and (I.EffectiveDate >= '01/01/2016' or I.MaturityDate >= '01/01/2016') and I.PnLAID = '5300' and I.PnLSub = '002'
	--and I.CPGLAid = '3001'
order by I.InterestRecSub, Trans#




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT I.ID#
      ,I.Trans#
      ,I.CustID
	  , C.Name
      ,I.Principal
      ,I.InterestRate
      ,I.EffectiveDate
      ,I.Tenure
      ,I.MaturityDate
      ,I.[Principal + Interest]
      ,I.RollOverDate
      ,I.BrokeragePaid
      ,I.InterestAmount
      ,I.UpfrontInterest
      ,I.BackendInterest
      ,I.EffectiveCost
      ,I.WeightedCost
      ,I.AccountOfficer
      ,I.[BackEndInt?]
      ,I.CPGLAid
      ,I.CPGLSub
      ,I.SuspenseAID
      ,I.SuspenseSub
      ,I.PerAnnumInterest
      ,I.OrigPrincipal
      ,I.Liquidated
      ,I.FirstRec
      ,I.UserID
      ,I.TxnDate
      ,I.PnLAID
      ,I.PnLSub
      ,I.InterestRecAID
      ,I.InterestRecSub
      ,I.InstrumentType
	 ,(Select Sum(TotalAccrued) from [dbo].[OP_IFundMthlyRun]
			Where Trans# = I.Trans# Group by Trans#) as InterestPaid 
  FROM [IWGI].[dbo].[OP_IFund_Trans] I
	inner join Cust_Customers C
		on C.Custaid = I.CustID
Where I.Liquidated = 0 and I.FirstRec = 1 and (I.EffectiveDate >= '01/01/2016' or I.MaturityDate >= '01/01/2016') and I.PnLAID = '5300' and I.PnLSub = '002'
	--and I.CPGLAid = '3001'
order by I.InterestRecSub, Trans#




Select [EffectiveDate]
      ,[Amount]
      ,[Description]
      ,[SysRef] from Acct_GL
Where AccountID = '4500' and Sub = '008' and EffectiveDate >= '01/01/2016' and SysRef Not Like 'REVERS%' and SysRef Like 'IFLQ-%'
Group by [EffectiveDate]
      ,[Amount]
      ,[Description]
      ,[SysRef]
Having Count(SysRef) > 1
order by ID# 

IFund Liq (Int) - Deposit#: 3766178; Cust: 10752
Invest. Fund Interest accrual - Deposit#: 3764536, Cust ID: 5003, Month: 3

Select * from OP_IFund_Trans
Where trans# =  3764536 --ID# = 48717



Select * from Acct_GL
Where AccountID = '5300' and Sub = '002' and EffectiveDate >= '01/01/2016' and SysRef Not Like 'REVERS%' and SysRef Not Like 'IFLQ-%' 
	and SYSRef Like 'IF_MR-'+Convert(varchar(10), (Select top 1 ID# from [dbo].[OP_IFundMthlyRun] Where Trans# = 3764536 order by ID# desc))
and BatchNo = 0



Select * from Acct_GL
Where SysRef like 'IFMR-%'