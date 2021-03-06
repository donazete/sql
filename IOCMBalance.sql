/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID#]
      ,[MasterAcct]
      ,[Sub]
      ,[MasterSub]
      ,[AcctDesc]
	  , A.Amt
  FROM [IWGI].[dbo].[IOCMSplit] C
  inner join (Select AccountID, Sub as Subacc, AccountID+Sub as comb, SUM(Amount) Amt
		  from Acct_GL
		  Where BranchCode = '000' --and EffectiveDate <= '12/31/2017'
		  Group by AccountID, Sub) A
	on C.MasterSub = A.comb
  Where Sub != ''

  
  Union all



  SELECT [ID#]
      ,[MasterAcct]
      ,[Sub]
      ,[MasterSub]
      ,[AcctDesc]
	  , A.Amt
  FROM [IWGI].[dbo].[IOCMSplit] C
	inner join (Select AccountID, SUM(Amount) Amt
		  from Acct_GL
		  Where BranchCode = '000' --and EffectiveDate <= '12/31/2017'
		  Group by AccountID) A
	on C.MasterSub = A.AccountID
  Where Sub = ''
  order by MasterAcct, Sub


Select AccountID, Sub as Subacc, AccountID+Sub as comb, SUM(Amount) Amt
from Acct_GL
Where BranchCode = '000' and (AccountID not in (SELECT [MasterAcct] FROM [IWGI].[dbo].[IOCMSplit]) and Sub not in (SELECT Sub FROM [IWGI].[dbo].[IOCMSplit]))
Group by AccountID, Sub


select * from Acct_GL
Where BranchCode = '000' and AccountID = '7000' and Sub = '003' and SysRef not like 'REVERS%' --and ABS(Amount) = 10371500
order by TxnDate EffectiveDate 


select Sum(Amount) from Acct_GL
Where BranchCode = '000' and AccountID = '7000' and Sub = '003' and SysRef not like 'REVERS%' --and ABS(Amount) = 10371500
order by TxnDate -- EffectiveDate 


select * from Acct_GL
Where BatchNo = '197913'

select Sum(Amount) from Acct_GL
Where AccountID = '2103' and Sub = '009'