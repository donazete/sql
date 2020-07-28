select ID#
	, '10'+ CustAID as CCCode
	, Case Clienttype
		When 'IND' Then 2
		Else 4
	End as CusTypeS
	, Case Clienttype
		When 'IND' Then 'INDIVIDUAL'
		Else 'CORPORATE'
	End as CusType
	, ContactDate as CCDate
	, Name as CSName
	, '' as CName
	, '' as CFName
	, Title as CTitle
	, '' as CGuardian
	, BirthDay as CDOB
	, '' as CPOB
	, '' as CStatus
	, '' as CGender
	, '' CNBusiness
	, '' as CCOI
	, '' as CRAZip
	, Phone1 as CHPhone
	, Phone2 as CMPhone
	, Country as CRACountry
	, State as CRAState
	, City as CPACity
	, '' as ModeofID
	, '' as CPOBox
	, Email1 as CPEmail
	, Nationality as CPNationality
	, Address1 as CCOResidence
	, '' as CContactMeans
	, Relationship as CRelationship
	, '' as CMaidenName
	, NextOfKin as CNOKSName
	, '' as CNOKFName
	,'' as CNOKPhone
	, '' as COccupation
	, '' as CNOEmployer
	, '' as CEmployAddress
	, '' as CEmployState
	, '' as CEmployCountry
	, '' as CofPhone
	, '' as CTID
	, '' as MISCODE
	, '' as branch
	, 1 as company
	, NULL as CustomerPic
	, NULL as CustomerSign
	, NULL as CustomerThumb
	, '' as WedDay
	,'' as WedMonth
	, '' as WedYear
	, '' as CCOContact
	, '' as CNOB
	, '' as CSector
	, '' as Field1
	, '' as Field2
	, '' as Field3
	, '' as Field4
	, '' as Field5
	, '' as Field6
	, '' as Field7
	, '' as Field8
	, '' as Field9
	, '' as Field10
	, '' as MISStaff
	, 'O' as CpType
	, '10'+ CustAID as ShortCode
	, Case Clienttype
		When 'IND' Then 'INDIVIDUAL'
		Else 'CORPORATE'
	End as AccountType
	, Case Clienttype
		When 'IND' Then 2
		Else 4
	End as CCategory
	, 'sys' as AccountTypeDesc
	, 2 as Bank
	, '' as CTarget
	, 1 as Approved
	, 0 as Disapproved
	, CreateDate as DateApproved
	, 'sys' as ApprovedBy
	, '' as NOKaddress
	, '' as NOKemail
	, '' as SCUMOL
	, '' as GuardianPhone
	, '' as GuardianAddr
	, 1 as MailSent
	, 0 as PFAcustomer
	, '' as Field11
	, '' as Field12
	, '' as Field13
	, '' as Field14
	, '' as Field15
	, '' as Field16
	, '' as Field17
	, '' as Field18
	, '' as Field19
	, '' as Field20
	, '' as CoyWebsite
	, Email2
	, '' as CreditRating
	, '' as CModeofIDDate
	, CreateDate
	, '' as LGA
	, '' as PermitNo
	, '' as EducationLevel
	, '' as CertificationDate
	, '' as EmployDate
	, '' as PreviousEmployer
	, '' as MotherName
	, '' as FirstChild
	, '' as ChildDOB
	, '' as RegisteredOffice
	, '' as CorrespondenceAddr
	, '' as BankName
	, '' as BankAddress
	, '' as BankAccount
	, '' as PrevCreditRating
	, 0 as AnnualTurnOver
	, '' as RCRelatedCoy
	, '' as RCParentBody
	, '' as GeoRegion
	, '' as FingerPrintID
	, '' as CorporateBizCategory
	, '' as HomeTown
	, '' as Spouse
	, '' as IssuePlace
	, '' as IssueAuthority
	, '' as IndAcctsWithBanks
	, '' as IndFund
	, 0 as IndFundAmt
	, 0 as Political
	, 1 as AccountComplete
	, 11 as BatchRef
from IWVW_Cust_Customers
Where ID# > 63461