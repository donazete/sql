/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[CoyID]
      ,[StaffNo]
      ,[MIsCode]
      ,[BranchID]
      ,[StaffName]
      ,[Department]
      ,[JobTitle]
      ,[Rank]
      ,[Phone]
      ,[Email]
      ,[Address]
      ,[Age]
      ,[Gender]
      ,[NameOfNOK]
      ,[PhoneOfNOK]
      ,[EmailOfNOK]
      ,[AddrOfNOK]
      ,[GenderOfNOK]
      ,[Comment]
      ,[State]
      ,[Nationality]
      ,[RelationShip]
      ,[Updated]
      ,[Staffsignature]
      ,[DeptCode]
      ,[UnitCode]
      ,[Unit]
      ,[pcCode]
      ,[pcCode2]
      ,[MISCode2]
      ,[pcCode3]
      ,[MISCode3]
  FROM [FinTrakFundManager].[dbo].[ts_StaffInfo]
  where StaffName like '%adeyeye%'

  select * from [dbo].[Security_Users]
  where staffname like '%adeyeye%'


  Begin tran

  Update [FinTrakFundManager].[dbo].[ts_StaffInfo]
  set CoyID = 1
  where id in (56, 112)

  update [dbo].[Security_Users]
  set CoyCode = 1
  Where StaffName in ('victor.redemi', 'segun.adeyeye')

  commit

  begin tran

  Update [FinTrakFundManager].[dbo].[ts_OperationApproval]
  set CompanyCode = 1
  where ApprovingAuthority like '%adeyeye%'

  commit