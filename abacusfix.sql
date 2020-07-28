select * from AMPL_IFundMthlyRun
Where MonthIndex = '201805' and Comments like '% Cust ID: 14137%' 


select * from Acct_GL
Where BranchCode = '004' and TransType = 'PLM' and EffectiveDate between '05/15/2018' and '05/23/2018' and SysRef like 'REVERS%'


Begin tran

delete from Acct_GLRev
Where GLID in (select ID# from Acct_GL
	Where BranchCode = '004' and TransType = 'PLM' and EffectiveDate between '05/15/2018' and '05/23/2018' and SysRef like 'REVERS%')


delete from Acct_GL
Where BranchCode = '004' and TransType = 'PLM' and EffectiveDate between '05/15/2018' and '05/23/2018' and SysRef like 'REVERS%'

commit