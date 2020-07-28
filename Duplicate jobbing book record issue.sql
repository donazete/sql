Select * from Stkb_JobbingBookTxn
Where CustNo = '2135' and CSCSAcctNumber = '48792996' and StockCode = 'UCAP' and Units = 100000 and TxnType = 1

Select * from Stkb_JobbingBookTxnUnapp
Where CustNo = '2135' and CSCSAcctNumber = '48792996' and StockCode = 'UCAP' and Units = 100000 and TxnType = 1



Select * from USysChangeLog
Where TableID = 'Stkb_JobbingBookTxnUnapp' and IDValue = 16226


Select * from USysChangeLog
Where TableID = 'Stkb_JobbingBookTxnUnapp' and IDValue = 16227


Select * from USysChangeLog
Where TableID = 'Stkb_JobbingBookTxnUnapp' and IDValue = 16225



Select * from USysChangeLog
Where TableID = 'Stkb_JobbingBookTxnUnapp' and Changes like '%SOLID-KAY ENTERPRISES%' and TxnDate >= '09/05/2016'

<Rowchanges>
 <NewROW id="16227" cancelled="1" portfoliovalue="672682.68" txndate="Sep  5 2016 12:44PM" pendingtrades="221419"/>
 <DeletedROW id="16227" effectivedate="Sep  5 2016 12:00AM" clienttype="Perm" custno="2135" custname="SOLID-KAY ENTERPRISES" stockcode="UCAP" units="100000" price="2.26" cscsregnumber="C4792959SI" cscsacctnumber="48792996" accountofficer="187" txntype="1" pricelimit="0" cancelled="0" alloted="0" parentid="0" originofrecord="0" orderlimit="0" estimatedvalue="221419.30" portfoliovalue="672649.28" acctbal="-0.00" marginratio="1" sysref="" userid="OkaforBss040" txndate="Sep  5 2016 12:28PM" createdby="OkaforBss040" marginstatus="0" marginenddate="Jan  1 1900 12:00AM" marginlmtamt="0" pendingtrades="0" datelimit="Sep 19 2016 12:00AM" unclearedeffects="0.00"/> 
</Rowchanges>

<Rowchanges> 
<DeletedROW id="16225" effectivedate="Sep  5 2016 12:00AM" clienttype="Perm" custno="2135" custname="SOLID-KAY ENTERPRISES" stockcode="UCAP" units="100000" price="2.26" cscsregnumber="C4792959SI" cscsacctnumber="48792996" accountofficer="187" txntype="1" pricelimit="0" cancelled="0" alloted="0" parentid="0" originofrecord="0" orderlimit="0" estimatedvalue="221419.30" portfoliovalue="672639.48" acctbal="-0.00" marginratio="1" sysref="NULL" userid="OkaforBss040" txndate="Sep  5 2016 12:11PM" createdby="OkaforBss040" marginstatus="0" marginenddate="Jan  1 1900 12:00AM" marginlmtamt="0" pendingtrades="0" datelimit="Sep 19 2016 12:00AM" unclearedeffects="0.00"/>
</Rowchanges>