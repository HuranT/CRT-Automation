import json
import quote_payload_temp
import requests

def update_body(quotetype_name):
    body = quote_payload_temp.get_body()
    
    HankenSchoolofEconomics_ID = "0013L000009Il1GQAS"
    UniversityofOxford_ID = "0013L000009Il12QAC"
        
    if quotetype_name == "ORG_PAYS_AGREEMENT":
        body["opportunity"]["accountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["accountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["billingAccountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["shippingAccountId"] = HankenSchoolofEconomics_ID

        body["opportunity"]["quote"]["billToContactId"] = "0033L00000DH4ApQAL"
        body["opportunity"]["quote"]["accountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS_AGREEMENT"
        body["opportunity"]["quote"]["agreementAcronym"] = "FINELIB"
        

    elif quotetype_name == "ORG_PAYS":
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS"
        body["opportunity"]["accountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["accountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["billingAccountId"] = HankenSchoolofEconomics_ID
        body["opportunity"]["quote"]["shippingAccountId"] = HankenSchoolofEconomics_ID

        body["opportunity"]["quote"]["billToContactId"] = "0033L00000DH4ApQAL"
        body["opportunity"]["quote"]["accountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0G3L000000aOp6UAE"
        body["opportunity"]["quote"]["agreementAcronym"] = ""

    elif quotetype_name == "AUTHOR_PAYS":
        body["opportunity"]["accountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["accountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_PAYS"
        body["opportunity"]["quote"]["billingAccountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["billToContactId"] = "003Vd000000eYPaIAM"
        body["opportunity"]["quote"]["accountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["shippingAccountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["agreementAcronym"] = ""

    elif quotetype_name == "AUTHOR_AGREEMENT_PAYS":
        body["opportunity"]["accountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["accountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_AGREEMENT_PAYS"
        body["opportunity"]["quote"]["billingAccountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["billToContactId"] = "003Vd000000eYPaIAM"
        body["opportunity"]["quote"]["accountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0GVd0000002DijMAE"
        body["opportunity"]["quote"]["shippingAccountId"] = "001Vd000000opiVIAQ"
        body["opportunity"]["quote"]["agreementAcronym"] = "SUNY"
        body["opportunity"]["quote"]["approvingEcrId"] = "ECR-44849"

    elif quotetype_name == "AUTHOR_ORG_AGREEMENT_PAYS":
        body["opportunity"]["accountId"] = "0013L00000CVphoQAD"
        body["opportunity"]["quote"]["accountId"] = "0013L00000CVphoQAD"
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_ORG_AGREEMENT_PAYS"
        body["opportunity"]["quote"]["billingAccountId"] = "0013L00000CVphoQAD"
        body["opportunity"]["quote"]["billToContactId"] = "0033L00000D8abUQAR"
        body["opportunity"]["quote"]["accountAddressId"] = "a0G3L0000014ykCUAQ"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0G3L0000014ykCUAQ"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0G3L0000014ykCUAQ"
        body["opportunity"]["quote"]["shippingAccountId"] = "0013L00000CVphoQAD"
        body["opportunity"]["quote"]["agreementAcronym"] = "SUNY"
        body["opportunity"]["quote"]["approvingEcrId"] = "ECR-78741"
        body["opportunity"]["quote"]["taxRegistrationNumber"] = "GB734674000"
        body["opportunity"]["quote"]["taxValidationResult"] = "Validated"

    elif quotetype_name == "ORG_PAYS_SOCIETY":
        body["opportunity"]["accountId"] = UniversityofOxford_ID
        body["opportunity"]["quote"]["accountId"] = UniversityofOxford_ID
        body["opportunity"]["quote"]["billingAccountId"] = UniversityofOxford_ID
        body["opportunity"]["quote"]["shippingAccountId"] = UniversityofOxford_ID
        body["opportunity"]["quote"]["billToContactId"] = "003Vd0000033eC6IAI"
        body["opportunity"]["quote"]["accountAddressId"] = "a0G3L000000BkKlUAK"
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS_SOCIETY"
        body["opportunity"]["quote"]["billingAccountAddressId"] = "a0G3L000004CtVyUAK"
        body["opportunity"]["quote"]["shippingAccountAddressId"] = "a0G3L000000BkKlUAK"
        body["opportunity"]["quote"]["agreementAcronym"] = ""
        body["opportunity"]["quote"]["societyEcrId"] = "ECR-531907"
        body["opportunity"]["quote"]["membershipReference"] = "1484"
        body["opportunity"]["quote"]["discountMatrixId"] = "a0V3L000000EUPtUAO"
        body["opportunity"]["quote"]["societyMember"] = True
        
        
        

    print(body)
    return body
