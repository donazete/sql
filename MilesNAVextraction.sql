select * from OP_MFValuation
where MFCode in ('tgf', 'ips2', 'ipsplus', 'medwealth', 'chdtrst')




select MFCode, ValuationDate, UnitPrice, BidPrice, OfferPrice
from OP_MFValuation
where MFCode in ('tgf', 'ips2', 'ipsplus', 'medwealth', 'chdtrst') and UnitPrice > 0
order by MFCode, ValuationDate



select MFCode, ValuationDate, UnitPrice, BidPrice, OfferPrice
from IWVW_MFValuation2
where MFCode in ('vbf', 'kedari') and UnitPrice > 0
order by MFCode, ValuationDate