select * from Acct_GL
Where SysRef like 'API%' and BranchCode = '000' and YEAR(EffectiveDate) = 2018 and LEN(AccountID) = 3

Begin tran

Update Acct_GL
Set BranchCode = '006'
Where SysRef like 'API%' and BranchCode = '000' and YEAR(EffectiveDate) = 2018 and LEN(AccountID) = 3

commit


select * from Acct_Branches