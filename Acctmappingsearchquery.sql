/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID#]
      ,[LedgerID]
      ,[OldLedgerCode1]
      ,[OldLedgerCode2]
      ,[OldLedgerCode3]
      ,[OldLedgerCode4]
      ,[OldLedgerCode5]
      ,[OldLedgerCode6]
      ,[OldLedgerCode7]
      ,[OldLedgerCode8]
      ,[Company]
      ,[CompanyID]
  FROM [Fintrak].[dbo].[Fintrak_AcctMapping]
  Where [OldLedgerCode1] = '161784' OR [OldLedgerCode2] = '161784' OR [OldLedgerCode3] = '161784' OR [OldLedgerCode4] = '161784' OR [OldLedgerCode5] = '161784' OR [OldLedgerCode6] = '161784'
      OR [OldLedgerCode7]  = '161784' OR [OldLedgerCode8] = '161784'

select * from [Fintrak].[dbo].[Fintrak_AcctMapping]
  Where companyID = 3
  order by LedgerID
--Select * from acct_G



SELECT [ID#]
      ,[LedgerID]
      ,[OldLedgerCode1]
      ,[OldLedgerCode2]
      ,[OldLedgerCode3]
      ,[OldLedgerCode4]
      ,[OldLedgerCode5]
      ,[OldLedgerCode6]
      ,[OldLedgerCode7]
      ,[OldLedgerCode8]
      ,[Company]
      ,[CompanyID]
  FROM [Fintrak].[dbo].[Fintrak_AcctMapping]
  Where [OldLedgerCode1] like '7000%' OR [OldLedgerCode2] like '7000%' OR [OldLedgerCode3] like '7000%' OR [OldLedgerCode4] like '7000%' OR [OldLedgerCode5] like '7000%' OR [OldLedgerCode6] like '7000%'
      OR [OldLedgerCode7]  like '7000%' OR [OldLedgerCode8] like '7000%'



SELECT *
  FROM [Fintrak].[dbo].[Fintrak_AcctMapping]
  Where LedgerID = '400008'


  SELECT *
  FROM [Fintrak].[dbo].[Fintrak_AcctMapping]
  Where id# = 2017

  Begin tran

  --Delete from [Fintrak].[dbo].[Fintrak_AcctMapping]
  --Where ID# = 1992

  Update [Fintrak].[dbo].[Fintrak_AcctMapping]
  set [OldLedgerCode1] = '', [OldLedgerCode3] = '', [OldLedgerCode4] = '', [OldLedgerCode6] = '', [OldLedgerCode7] = ''
  Where ID# = 474

  --Update [Fintrak].[dbo].[Fintrak_AcctMapping]
  --set [OldLedgerCode1] = '', [OldLedgerCode2] = '', [OldLedgerCode4] = '', [OldLedgerCode5] = ''
  --Where ID# = 522

  Update [Fintrak].[dbo].[Fintrak_AcctMapping]
  set [OldLedgerCode2] = '', [OldLedgerCode3] = '', [OldLedgerCode4] = '', [OldLedgerCode6] = '', [OldLedgerCode7] = '', [OldLedgerCode8] = ''
  Where ID# = 183

  --Update [Fintrak].[dbo].[Fintrak_AcctMapping]
  --set [OldLedgerCode1] = '', [OldLedgerCode2] = '', [OldLedgerCode3] = '', [OldLedgerCode6] = '', [OldLedgerCode7] = '', [OldLedgerCode8] = ''
  --Where ID# = 935


  Update [Fintrak].[dbo].[Fintrak_AcctMapping]
  set Company = 'CAPMGT', CompanyID = 5
  Where ID# = 2017


  commit


  Select * from Acct_Subs
  Where AccountID = '0' and Sub = '320'