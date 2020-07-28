CREATE VIEW IOFSVW_ACCT_INTERCOMPBALRECON
AS


Select '2500' as AID
	, '006' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '006') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '006', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '260' as AID
	, '005' as Sub
	, (Select Description from Acct_Subs Where AccountID = '260' and Sub = '005') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '005', 'NGN', '006', GETDATE()) as ClosingBal

Union all

Select '2500' as AID
	, '007' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '007') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '007', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '260' as AID
	, '001' as Sub
	, (Select Description from Acct_Subs Where AccountID = '260' and Sub = '001') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '001', 'NGN', '006', GETDATE()) as ClosingBal

Union all

Select '2500' as AID
	, '014' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '014') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '014', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '20' as AID
	, '2003' as Sub
	, (Select Description from Acct_Subs Where AccountID = '20' and Sub = '2003') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('20', '2003', 'NGN', '005', GETDATE()) as ClosingBal

Union all

Select '2500' as AID
	, '016' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '016') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '016', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '001' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '001') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '001', 'NGN', '007', GETDATE()) as ClosingBal

Union all

Select '2500' as AID
	, '017' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '017') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '017', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '002' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '002') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '002', 'NGN', '008', GETDATE()) as ClosingBal

Union all

Select '2500' as AID
	, '020' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2500' and Sub = '020') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '020', 'NGN', '000', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '003' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '003') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '003', 'NGN', '009', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '005' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '005') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '005', 'NGN', '007', GETDATE()) as ClosingBal

Union all

Select '260' as AID
	, '006' as Sub
	, (Select Description from Acct_Subs Where AccountID = '260' and Sub = '006') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '006', 'NGN', '006', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '007' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '007') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '007', 'NGN', '007', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '009' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '009') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '009', 'NGN', '008', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '008' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '008') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '008', 'NGN', '007', GETDATE()) as ClosingBal

Union all

Select '2700' as AID
	, '010' as Sub
	, (Select Description from Acct_Subs Where AccountID = '2700' and Sub = '010') as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '010', 'NGN', '009', GETDATE()) as ClosingBal

Union all

Select '0000' as AID
	, '000' as Sub
	, Case
		When (Select [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '010', 'NGN', '009', GETDATE()) + 
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '008', 'NGN', '007', GETDATE()) + 
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '009', 'NGN', '008', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '007', 'NGN', '007', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '006', 'NGN', '006', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '005', 'NGN', '007', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '003', 'NGN', '009', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '020', 'NGN', '000', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '002', 'NGN', '008', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '017', 'NGN', '000', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '001', 'NGN', '007', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '016', 'NGN', '000', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('20', '2003', 'NGN', '005', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '014', 'NGN', '000', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '001', 'NGN', '006', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '007', 'NGN', '000', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '005', 'NGN', '006', GETDATE()) +
				[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '006', 'NGN', '000', GETDATE()) ) = 0 Then 'BALANCED'
			Else  'DIFFERENCE EXIST'
		END as AcctName
	, [dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '010', 'NGN', '009', GETDATE()) + 
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '008', 'NGN', '007', GETDATE()) + 
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '009', 'NGN', '008', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '007', 'NGN', '007', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '006', 'NGN', '006', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '005', 'NGN', '007', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '003', 'NGN', '009', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '020', 'NGN', '000', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '002', 'NGN', '008', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '017', 'NGN', '000', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2700', '001', 'NGN', '007', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '016', 'NGN', '000', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('20', '2003', 'NGN', '005', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '014', 'NGN', '000', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '001', 'NGN', '006', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '007', 'NGN', '000', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('260', '005', 'NGN', '006', GETDATE()) +
		[dbo].[IWfn_Acct_BalanceAsAtDtForBranch]('2500', '006', 'NGN', '000', GETDATE()) as ClosingBal

GO