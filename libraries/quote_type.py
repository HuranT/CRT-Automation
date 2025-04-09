import json
import quote_payload_temp
import requests

def update_body(quotetype_name, account_id, contact_id, address_id, agreement_acronym=None, approving_ecr_id=None, society_ecr_id=None, membership_reference=None, discount_matrix_id=None, tax_registration_number=None, tax_validation_result=None, is_split_pay=None):
    body = quote_payload_temp.get_body()

    # Handle different quote types
    if quotetype_name == "ORG_PAYS_AGREEMENT":
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS_AGREEMENT"
        body["opportunity"]["quote"]["agreementAcronym"] = agreement_acronym
        
        # Add split payments only for ORG_PAYS_AGREEMENT if is_split_pay is True
        if is_split_pay:
            body["opportunity"]["quote"]["payments"] = [
                {
                    "paymentId": None,
                    "paymentProfileId": "a0I3L00000CbNePUAV",
                    "quoteId": None,
                    "orderId": None,
                    "currencyIsoCode": "USD",
                    "paymentAmount": 1000.0,
                    "paymentNetAmount": 1000.0,
                    "paymentTaxAmount": None,
                    "indicativeTax": None,
                    "taxError": None,
                    "participantType": "Institute",
                    "splitType": None,
                    "billingAccountId": account_id,
                    "billingAccountAddressId": address_id,
                    "billToContactId": contact_id,
                    "account": None,
                    "contact": None,
                    "address": None,
                    "purchaseOrder": None,
                    "billingInstitute": None,
                    "hasFunding": False,
                    "fundingRejectionReasonText": None,
                    "fundingRejectionReasonId": None
                },
                {
                    "paymentId": None,
                    "paymentProfileId": "a0I3L00000CbNeUUAV",
                    "quoteId": None,
                    "orderId": None,
                    "currencyIsoCode": "USD",
                    "paymentAmount": 750,
                    "paymentNetAmount": 750,
                    "paymentTaxAmount": None,
                    "indicativeTax": None,
                    "taxError": None,
                    "participantType": "Author",
                    "splitType": None,
                    "billingAccountId": "001Vd000000opiVIAQ",
                    "billingAccountAddressId": "a0G3L000000aOp6UAE",
                    "billToContactId": "003Vd000000eYPaIAM",
                    "account": None,
                    "contact": None,
                    "address": None,
                    "purchaseOrder": None,
                    "billingInstitute": None,
                    "hasFunding": False,
                    "fundingRejectionReasonText": None,
                    "fundingRejectionReasonId": None
                }
            ]

    elif quotetype_name == "ORG_PAYS":
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS"

    elif quotetype_name == "AUTHOR_PAYS":
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_PAYS"

    elif quotetype_name == "AUTHOR_AGREEMENT_PAYS":
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_AGREEMENT_PAYS"
        body["opportunity"]["quote"]["agreementAcronym"] = agreement_acronym
        body["opportunity"]["quote"]["approvingEcrId"] = approving_ecr_id
        body["opportunity"]["quote"]["discountMatrixId"] = discount_matrix_id
        body["opportunity"]["quote"]["quoteLines"][0]["discountMatrixId"] = discount_matrix_id

    elif quotetype_name == "AUTHOR_ORG_AGREEMENT_PAYS":
        body["opportunity"]["quote"]["quoteType"] = "AUTHOR_ORG_AGREEMENT_PAYS"
        body["opportunity"]["quote"]["agreementAcronym"] = agreement_acronym
        body["opportunity"]["quote"]["approvingEcrId"] = approving_ecr_id
        body["opportunity"]["quote"]["taxRegistrationNumber"] = tax_registration_number
        body["opportunity"]["quote"]["taxValidationResult"] = tax_validation_result

    elif quotetype_name == "ORG_PAYS_SOCIETY":
        body["opportunity"]["quote"]["quoteType"] = "ORG_PAYS_SOCIETY"
        body["opportunity"]["quote"]["societyEcrId"] = society_ecr_id
        body["opportunity"]["quote"]["membershipReference"] = membership_reference
        body["opportunity"]["quote"]["discountMatrixId"] = discount_matrix_id
        body["opportunity"]["quote"]["societyMember"] = True

    # Common fields for all quote types
    body["opportunity"]["accountId"] = account_id
    body["opportunity"]["quote"]["accountId"] = account_id
    body["opportunity"]["quote"]["billingAccountId"] = account_id
    body["opportunity"]["quote"]["shippingAccountId"] = account_id

    body["opportunity"]["quote"]["billToContactId"] = contact_id
    body["opportunity"]["quote"]["accountAddressId"] = address_id
    body["opportunity"]["quote"]["billingAccountAddressId"] = address_id
    body["opportunity"]["quote"]["shippingAccountAddressId"] = address_id

    print(body)
    return body
