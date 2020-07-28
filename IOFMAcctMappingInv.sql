select * from ts_Finance_ChartOfAccount
Where AccountID IN ('115004', '115054')


select * from ts_Finance_ChartOfAccount
Where AccountTypeID = '113000'
order by AccountName


select * from ts_Finance_ChartOfAccount
Where AccountName like '%NITDA%'
order by AccountName

select * from acct_subs
where accountid = '50' and sub in ('0211', '0504', '0507','0508', '0513', '0532', '1520')