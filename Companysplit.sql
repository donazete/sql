Select * from Acct_Subs
Where AccountID = '1007' and Sub in ('003', '002', '004')

union all

Select * from Acct_Subs
Where AccountID = '1701' and Sub in ('001', '002', '003')

union all

Select * from Acct_Subs
Where AccountID = '7100' and Sub in ('001', '002')

union all

Select * from Acct_Subs
Where AccountID = '2700' and Sub = '002'


union all

Select * from Acct_Subs
Where AccountID = '3201' and Sub in ('001', '002', '003', '004', '005', '006', '007')

union all

Select * from Acct_Subs
Where AccountID = '2400' and Sub = '004'

union all

Select * from Acct_Subs
Where AccountID = '2802' and Sub = '001'

union all

Select * from Acct_Subs
Where AccountID = '4502' and Sub in ('001', '002')

union all

Select * from Acct_Subs
Where AccountID = '4800' and Sub = '001'

union all

Select * from Acct_Subs
Where AccountID = '5015' and Sub in ('001', '002', '003')

union all

Select * from Acct_Subs
Where AccountID = '5016' and Sub = '001'

union all

Select * from Acct_Subs
Where AccountID = '6001' and Sub = '001'










Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '1007' and Sub in ('003', '002', '004')
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '1701' and Sub in ('001', '002', '003')
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '7100' and Sub in ('001', '002')
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '2700' and Sub = '002'
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '3201' and Sub in ('001', '002', '003', '004', '005', '006', '007')
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '2400' and Sub = '004'
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '2802' and Sub = '001'
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '4502' and Sub in ('001', '002')
Group by AccountID, Sub


union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '4800' and Sub = '001'
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '5015' and Sub in ('001', '002', '003')
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '5016' and Sub = '001'
Group by AccountID, Sub

union all

Select AccountID, SUB,  SUM(Amount) from Acct_Subs
Where AccountID = '6001' and Sub = '001'
Group by AccountID, Sub




bEGIN TRAN


Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '1007' and Sub in ('003', '002', '004')


Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '1701' and Sub in ('001', '002', '003')



Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '7100' and Sub in ('001', '002')


Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '2700' and Sub = '002'

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '3201' and Sub in ('001', '002', '003', '004', '005', '006', '007')

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '2400' and Sub = '004'

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '2802' and Sub = '001'

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '4502' and Sub in ('001', '002')


Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '4800' and Sub = '001'

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '5015' and Sub in ('001', '002', '003')

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '5016' and Sub = '001'

Update Acct_Subs
Set BranchCode = '008'
Where AccountID = '6001' and Sub = '001'

commit

