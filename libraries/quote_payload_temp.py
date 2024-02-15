import random_generator

def get_body():
    
    oppRef = random_generator.get_opp_reference()
    
    body = {
        "opportunity": {
            "accountId": None,
            "closeDate": 1650893976877,
            "currencyIsoCode":"USD",
            "productType":"APC",
            "quote": {
                "accountAddressId": None,
                "accountId": None,
                "agreementAcronym": None,
                "approvingEcrId": None,
                "billToContactId": None,
                "billingAccountAddressId": None,
                "billingAccountId": None,
                "correlationId": "dd3510eb-f398-4228-8e7a-b15ea71a3d67",
                "currencyIsoCode": "USD",
                "discountMatrixId": None,
                "discountType": None,
                "membershipReference": None,
                "note": None,
                "paymentModel": "POST_PAY",
                "paymentTerm":"30",
                "payments": [],
                "poNumber": "PO1234",
                "pricebookId": "01s3L0000001ZAlQAM",
                "quoteLines": [{
                        "article": {
                            "articleAcceptedDate": 1672531200000,
                            "articleTitle": "Article Title Regression Test: " + oppRef,
                            "correspondingAuthorEmail": "crtregression@elsevier.invalid",
                            "correspondingAuthorName": "CRT Regression Test",
                            "doiLink": "10.1016/j.fuel.2018.03.063",
                            "doiUrl": "http://dx.doi.org/10.1016/j.fuel.2018.03.063",
                            "funders": None,
                            "name": "Article name Regression Test: " + oppRef,
                            "pii": oppRef,
                            "submissionDate": 1672531200000,
                            "type": "FLA",
                            "availableOnline": 1672531200000, 
                            "userLicense": "http://creativecommons.org/licenses/by/4.0/"
                        },
                        "currencyIsoCode": "USD",
                        "discount": 0.0,
                        "discountMatrixId": None,
                        "discountType": None,
                        "listPrice": 1750.0,
                        "netPrice": 1750.0,
                        "productId":"01t3L000000XDz2QAG",
                        "quantity": 1,
                        "stackedDiscountMatrixId": None,
                        "stackedDiscountType": None,
                        "taxAudited": None,
                        "taxError": "Placeholder billing address will not be taxed",
                        "taxJurisdictionDetails": None,
                        "taxJurisdictionResults": None,
                        "taxRate": None,
                        "taxTransactionDate": None,
                        "taxTransactionLineNumber": None,
                        "taxTransactionReference": None,
                        "taxValue": None,
                    "transactionIdentifier": None
                    }
                ],
                "quoteType": None,
                "sellingEntityId": "a0W3L000000AAzAUAW",
                "shippingAccountAddressId": None,
                "shippingAccountId": None,
                "societyEcrId": None,
                "societyMember": None,
                "stackedDiscountMatrixId": None,
                "stackedDiscountType": None,
                "startDate": 1643117976572,
                "subAgreementAcronym": None,
                "taxExemptCertificationNumber": None,
                "taxExemptClaimed": None,
                "taxExemptEndDate": None,
                "taxExemptStartDate": None,
                "taxExemptValidated": False,
                "taxRegistrationNumber": None,
                "taxValidationResult": None,
                "validatedByVIES": True
            },
            "reference": oppRef
        }
    }
    return body