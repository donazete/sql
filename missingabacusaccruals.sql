/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[FundCode]
      ,[AllotDate]
      ,[CustAID]
      ,[UnitHolding]
      ,[FundReturnPerUnit]
      ,[DailyReturn]
      ,[Txndate]
      ,[AllotType]
  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
  where custaid = '19872' and allotdate in ('08/25/2017','08/27/2017')

  select * from IOFS_MMFundDailyReturns
  where ValDate = '08/25/2017'

  

  select Sum(Case TxnType
		When 0 then Qty
		else Qty * -1
	end) as units
from OP_MFTxns2
Where custaid = '19872' and Date <= '08/25/2017' and FundCode = 'abacus'

select * from OP_MFTxns2
Where custaid = '19872' and Date <= '08/25/2017' and FundCode = 'abacus'


select * from [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
  where allotdate in ('08/25/2017','08/27/2017')


  declare @EnDate as datetime
  declare @MFCode as varchar(10)

  set @MFCode = 'abacus'
  set @EnDate = '08/25/2017'

  --Select Sum(Case txnType
		--			When 0 Then Qty
		--			Else Qty * -1
		--		End) as TotalUnits
		--From [dbo].[OP_MFTxns2]
		--Where Date <= @EnDate and FundCode = @MFCode

  --Select @EnDate as Dt,
		--	CustAID,
		--	Fundcode,
		--	Sum(Case txnType
		--			When 0 Then Qty
		--			Else Qty * -1
		--		End) as TotalUnits
		--From [dbo].[OP_MFTxns2]
		--Where Date <= @EnDate and FundCode = @MFCode --and custaid = '19872'
		--Group by CustAID, Fundcode

Select distinct CustAID
		From [dbo].[OP_MFTxns2]
		Where Date <= @EnDate and FundCode = @MFCode --and custaid = '19872
		


Select Distinct Custaid
		From [dbo].[OP_MFTxns2]
		Where Date <= '08/25/2017' and FundCode = 'ABACUS' and CustAID not in (select custaid from [IWGI].[dbo].[IOFS_MMFundReturnsAllot] where AllotDate ='08/25/2017')

select * from [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
Where Custaid in (Select CustAID
		From [dbo].[OP_MFTxns2]
		Where Date <= @EnDate and FundCode = @MFCode) and AllotDate = @EnDate

		
		select * from [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
  where allotdate ='08/27/2017'



  Select '08/27/2017' as Dt,
			CustAID,
			Fundcode,
			Sum(Case txnType
					When 0 Then Qty
					Else Qty * -1
				End) as TotalUnits
		From [dbo].[OP_MFTxns2]
		Where Date <= '08/27/2017' and FundCode = 'ABACUS' and custaid in (Select Distinct Custaid
		From [dbo].[OP_MFTxns2]
		Where Date <= '08/27/2017' and FundCode = 'ABACUS' and CustAID not in (select custaid from [IWGI].[dbo].[IOFS_MMFundReturnsAllot] where AllotDate ='08/27/2017'))
		Group by CustAID, Fundcode
		order by CustAID



  Select Distinct Custaid
		From [dbo].[OP_MFTxns2]
		Where Date <= '08/27/2017' and FundCode = 'ABACUS' and CustAID not in (select custaid from [IWGI].[dbo].[IOFS_MMFundReturnsAllot] where AllotDate ='08/27/2017')


		select Allotdate, Count(Allotdate), 
		from [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
		group by allotdate order by allotdate desc 

		select *
		from [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
		Where custaid = '19963'
		order by allotdate desc


		select * from OP_MFTxns2
		Where FundCode = 'abacus' and custaid = '19963'