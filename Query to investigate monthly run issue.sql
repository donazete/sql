Select * 
from AMPL_IFund_Trans
Where CustID = '000' and EffectiveDate <= '08/31/2016' and MaturityDate >= '08/31/2016' and FirstRec = 1-- and Liquidated = 0
order by trans#, Liquidated


Select * 
from Acct_GL
Where Month(EffectiveDate) = 08 and Year(EffectiveDate) = 2016 and AccountID IN ('4500') and Sub IN ('001','006','012', '011')
and SysRef like 'PLMMR%'