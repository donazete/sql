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
  where StaffName like '%redemi%' or StaffName like '%ajibade%'

  select * from Security_Users
  where StaffName like '%redemi%' or StaffName like '%ajibade%'

  select * from ts_OperationApproval
  where ApprovingAuthority like '%redemi%' or ApprovingAuthority like '%ajibade%'


  update ts_OperationApproval
  set CompanyCode = 1
  where ApprovingAuthority like '%redemi%' or ApprovingAuthority like '%ajibade%'

  update Security_Users
  set CoyCode= 1
  where StaffName like '%redemi%' or StaffName like '%ajibade%'

 update  [FinTrakFundManager].[dbo].[ts_StaffInfo]
 set coyid = 1
  where StaffName like '%redemi%' or StaffName like '%ajibade%'