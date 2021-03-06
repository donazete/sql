/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID#]
      ,[Type]
      ,[Source]
      ,[Description]
      ,[UserID]
      ,[TxnDate]
  FROM [IWGI].[dbo].[USysEventLog]
  where [TxnDate] between '01/06/2017' and '01/07/2017' and Type = 'Informational' and Source = 'IWReportForm' and UserID like 'Adesanya%'



  Select * from Acct_GL
Where TxnDate > '2017-01-06 11:09:23.357' and YEAR(EffectiveDate) = 2016 and BranchCode = '000'
order by TxnDate


Select * from Acct_GL
Where AccountID = '5015' and Sub = '002' and TxnDate >= '2017-01-06 11:09:23.357'

Select Sum(Amount) from Acct_GL
Where AccountID = '7100' and Sub = '001' and TxnDate >= '2017-01-06 11:09:23.357'


Select * from Acct_Subs
Where AccountID = '7100' and Sub = '002'