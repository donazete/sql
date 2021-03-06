/****** Script for SelectTopNRows command from SSMS  ******/
Declare @id as integer

Set @id = 1076

SELECT BR.[BrGLID]
	  , BG.GLID
	  , BG.BRID as ReconID
      ,BR.[BrBSID]
      ,Case BR.[ReconType]
			When 0 Then 'Autoreconciliation'
			Else 'Manual Reconciliation'
		End as ReconType
	  , G.TxnDate as GLTxnDate
	  , G.EffectiveDate as GLValueDt
	  , G.Description as GLDescription
	  , G.SysRef as GLRef
	  , Case 
			When G.Amount < 0 Then 'Debit'
			Else 'Credit'
		End as GLEntryType
	  , G.Amount as GLAmount
	  ,BS.[BnkTxnDate] as BSTxnDate
	  ,BS.[ValueDate] as BSValueDt
      ,BS.[Description] as BSDescription
      ,BS.[Reference] as BSRef
	  , Case 
			When BS.Amount < 0 Then 'Credit'
			Else 'Debit'
		End as GLEntryType
      ,BS.[Amount] * -1 as BSAmount
  FROM [dbo].[Acct_BrRecon] BR
	inner join [dbo].[Acct_BrGL] BG
		on BR.BrGLID = BG.GLID
	inner join Acct_GL G
		on G.ID# = BG.GLID
	Inner join [dbo].[Acct_BrBS] BS
		on BR.[BrBSID] = BS.ID#
Where BG.BRID = @id