/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [IOERMS].[dbo].[ts_Finance_PaymentDetails]
  where TransCode = 'CAD0002090'
  --pMadeBy = 'michael.dokpesi'

  --OPR0022429-1
  --PVN00400


  select * from ts_OperationApproval
  where UserName = 'CAD0002090'


Select * from [IOERMS].[dbo].[ts_Finance_AdvanceRequisition]
where careqno =  'CAD0002090'


Select * from [dbo].[ts_ApprovalTrail]
where RequestID = 'CAD0002090'

select * from [IOERMS].[dbo].[FA_OPEXREQ]
where oreqid =  'OPR0022430'


select * from ts_Captured_Error order by id desc 



Select * from [IOERMS].[dbo].[ts_Finance_AdvanceRequisition]
where purpose like '%ijeoma%'




use IOERMS


exec loadopreview


--select distinct OperationID from ts_OperationApproval where username like 'CAD%'

select * from ts_OperationApproval where Username = 'CAD0002090' and  OperationID = 68 order by ApprovingLevel 


select * from Security_Users where StaffNumber = 'ademola.aofolaju'


exec sp_FetchPaymentByTypeOmaster 5,68,'oladapo.sonuga'

exec sp_FetchPaymentByTypeOmaster 5,82,'oladapo.sonuga'




select * from ts_Finance_PaymentDetails where TransCode = 'CAD0002090' -- TID = '17404'


select * from ts_ApprovalTrail where UniqueOpID = 82 and TransactionTypeID = '12352' order by id desc

select * from FA_OPEXREQ where oreqid ='OPR0022430' order by id desc 


select * from FA_AUDIT_TRAIL where RequestCode = 'OPR0022430'