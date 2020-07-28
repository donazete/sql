/* Query for accounts to be mapped */
CREATE VIEW InfowareAccts
AS
	Select S.AccountID, S.Sub, (S.AccountID+S.Sub) as AcctNo, S.Description
	from IWGI.dbo.Acct_Subs S
	Where (BranchCode IS NULL OR BranchCode IN ('000','005','006', '007', '008', '009'))
		AND S.AccountID NOT IN (Select AID from IWGI.dbo.OP_InvolvmentAccts) 
		AND (S.AccountID+S.Sub) NOT IN (Select Distinct OldLedgerCode1 from [dbo].[Fintrak_AcctMapping])
GO

/* Query for fintrak accounts */
CREATE VIEW FintrakAccts
AS
	Select AccountID, AccountName 
	from [COREBANKING].[FinTrakFundManager].[dbo].ts_Finance_ChartofAccount
	--order by AccountName
GO

/* Query for fintrak companies */
CREATE VIEW FintrakComp
AS
	SELECT [coyID]
		  ,[coyName]
	  FROM [COREBANKING].[FinTrakFundManager].[dbo].[ts_CompanyInfo]
GO


  /* Query to insert into fintrak acct mapping   */
CREATE PROCEDURE dbo.mapAcct 
	@FintrakAcctID varchar(30),
	@InfowareAcctID varchar(30),
	@Company varchar(30),
	@CompanyCode int,
	@User as varchar(100)
AS
	INSERT INTO Fintrak_AcctMapping ([LedgerID]
		  ,[OldLedgerCode1]
		  ,[OldLedgerCode2]
		  ,[OldLedgerCode3]
		  ,[OldLedgerCode4]
		  ,[OldLedgerCode5]
		  ,[OldLedgerCode6]
		  ,[OldLedgerCode7]
		  ,[OldLedgerCode8]
		  ,[Company]
		  ,[CompanyID]
		  , UserID
		  , TxnDate) 
		  VALUES

		  (@FintrakAcctID
		  , @InfowareAcctID
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , @Company
		  , @CompanyCode
		  , @User
		  , GETDATE())
GO

