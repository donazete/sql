select * from Acct_GL
Where LEN(AccountID) = 3 and 
Month(EffectiveDate) in (11,12) and YEAR(EffectiveDate) = 2017
/*and (AccountID+Sub) in ('1007002',
'1007003',
'1007004',
'1701001',
'1701002',
'1701003',
'2400004',
'2700002',
'2802001',
'3201001',
'3201002',
'3201003',
'3201004',
'3201005',
'3201006',
'3201007',
'4502001',
'4502002',
'4800001',
'5015001',
'5015002',
'5015003',
'5016001',
'6001001',
'7100001',
'7100002')*/



select * from Acct_GL
Where LEN(AccountID) = 3 and 
Month(EffectiveDate) = (10) and YEAR(EffectiveDate) = 2017
and Batchno in (select Distinct BatchNo from Acct_GL
	Where LEN(AccountID) = 3 and 
	Month(EffectiveDate) in (10) and YEAR(EffectiveDate) = 2017 and BatchNo != 0)


select * from Acct_GL
Where --LEN(AccountID) = 3 and 
Month(EffectiveDate) in (10,11) and YEAR(EffectiveDate) = 2017
and Batchno in (select Distinct BatchNo from Acct_GL
Where --LEN(AccountID) = 3 and 
Month(EffectiveDate) in (10,11) and YEAR(EffectiveDate) = 2017 and BatchNo != 0
and (AccountID+Sub) in ('1007002',
'1007003',
'1007004',
'1701001',
'1701002',
'1701003',
'2400004',
'2700002',
'2802001',
'3201001',
'3201002',
'3201003',
'3201004',
'3201005',
'3201006',
'3201007',
'4502001',
'4502002',
'4800001',
'5015001',
'5015002',
'5015003',
'5016001',
'6001001',
'7100001',
'7100002'))

select * from Acct_GL
Where Batchno = 188557


188561
188661
188969
189086
189193
189217
189235
189236
189285
190207
190334
190367
190382
190539
190610

select SUM(Amount) from Acct_GL
Where LEN(AccountID) = 3 and Month(EffectiveDate) = 10 and YEAR(EffectiveDate) = 2017