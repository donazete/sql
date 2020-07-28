select * from ts_OperationApproval
where ApprovingAuthority like 'sam%'


select * from CreditApprovalTrack


select * from ts_Banking_Disbursement
where coycode = 7 and approved = 0 and disapproved = 0


select * from ts_Banking_Disbursement
where coycode = 7 and DateDisbursed = '04/03/2017'



select * from ts_Banking_Disbursement
where id in (2026,2033,2037,2038,2039)


select * from ts_Banking_Disbursement
where coycode = 7 and ProductAcctNo in ('101536210044','101536210045','101444610041')

select * from ts_Finance_Transaction
where LEGTYPE in ('101536210044','101536210045','101444610041')

101536210044
101536210045
101444610041