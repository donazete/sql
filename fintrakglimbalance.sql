select scoycode, MONTH(Valuedate) Mont, Sum((DebitAmt * -1) + creditamt) as amt 
from ts_Finance_Transaction 
--where scoycode = 7
Group by scoycode, MONTH(Valuedate)
order by Mont, Scoycode

select Ref, Sum((DebitAmt * -1) + creditamt) as amt 
from ts_Finance_Transaction
where ValueDate between '09/01/2017' and '10/31/2017' and sCoyCode = 7
Group by Ref
Having Sum((DebitAmt * -1) + creditamt) != 0
order by amt


select * from ts_Finance_Transaction 
where Ref = 'JE-188940' -- scoycode = 7



select Ref, Count(*) as amt 
from ts_Finance_Transaction
where ValueDate = '07/31/2017' and ApplicationID = 'Treasuryreversal'
Group by Ref
order by ref




select ValueDate, Sum((DebitAmt * -1) + creditamt) as amt 
from ts_Finance_Transaction
Group by ValueDate
order by amt



select *
from ts_Finance_Transaction
Where ValueDate = '07/31/2017' and Ref = 'IF_MR-114210' in ('IF_MR-114209', 'IF_MR-114210', 'IF_MR-114211', 'IF_MR-114212', 'IF_MR-114213', 'IF_MR-114214', 'IF_MR-114215', 'IF_MR-114216', 
                      'IF_MR-114217', 'IF_MR-114218', 'IF_MR-114219', 'IF_MR-114220', 'IF_MR-114221', 'IF_MR-114222', 'IF_MR-114223', 'IF_MR-114224', 'IF_MR-114225', 
                      'IF_MR-114226', 'IF_MR-114227', 'IF_MR-114228', 'IF_MR-114229', 'IF_MR-114230', 'IF_MR-114231', 'IF_MR-114232', 'IF_MR-114233', 'IF_MR-114234', 
                      'IF_MR-114235', 'IF_MR-114236', 'REVERSAL', 'REVERSED')
order by Ref


select *
from ts_Finance_Transaction
Where ValueDate = '07/31/2017' and Ref in ('REVERSAL', 'REVERSED')
order by Ref


select * from ts_Banking_PrincipalReduction
where Approved = 0 and Disapproved = 0


select * from ts_Banking_Termination
where ApprovedLoan = 0 and DisapprovedLoan = 0


