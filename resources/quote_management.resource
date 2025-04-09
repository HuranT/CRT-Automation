*** Settings ***
Library                 QForce
Library                 Collections
Library                 ../libraries/access_token_params.py
Library                 ../libraries/save_quote_payload.py
Library                 ../libraries/quote_type.py




*** Variables ***

${username}         ${username}
${password}         ${password}
${client_id}        ${client_id}
${client_secret}    ${client_secret}

${BillingAddressDetails}    ${EMPTY}  # Placeholder for billing address details.
${account_id}               ${EMPTY}  # Placeholder for account_id
${contact_id}               ${EMPTY}  # Placeholder for contact_id   
${address_id}               ${EMPTY}  # Placeholder for address_id
${agreement_acronym}        ${EMPTY}  # Placeholder for agreement_acronym   
${approving_ecr_id}         ${EMPTY}  # Placeholder for approving_ecr_id  
${society_ecr_id}           ${EMPTY}  # Placeholder for society_ecr_id
${membershipReference}      ${EMPTY}  # Placeholder for membershipReference
${discount_matrix_id}       ${EMPTY}  # Placeholder for discount_matrix_id
${account_ecr_id}           ${EMPTY}


*** Keywords ***

Set Test Variables
    [Arguments]    ${quote_type}   ${account_id}    ${contact_id}    ${address_id}    ${agreement_acronym}    ${society_ecr_id}    ${membership_reference}    ${approving_ecr_id}    ${discount_matrix_id}
    Set Suite Variable    ${quote_type}    ${quote_type}
    Set Suite Variable    ${account_id}    ${account_id}
    Set Suite Variable    ${contact_id}    ${contact_id}
    Set Suite Variable    ${address_id}    ${address_id}
    Set Suite Variable    ${agreement_acronym}    ${agreement_acronym}
    Set Suite Variable    ${society_ecr_id}    ${society_ecr_id}
    Set Suite Variable    ${approving_ecr_id}    ${approving_ecr_id}
    Set Suite Variable    ${discount_matrix_id}  ${discount_matrix_id} 
    
     
Is Split Pay
    [Arguments]    ${agreement_acronym}
    ${is_split_pay}    Run Keyword And Return Status    Should Be Equal As Strings    ${agreement_acronym}    CDLTEST
    Set Suite Variable    ${is_split_pay}    ${is_split_pay}

Create Quote
    [Documentation]    Generates a quote with dynamic inputs
    [Tags]             REST API   Create
    [Arguments]        ${quote_type}  ${account_id}  ${contact_id}  ${address_id}  ${agreement_acronym}  ${society_ecr_id}  ${membershipReference}  ${approving_ecr_id}  ${discount_matrix_id}   
    
     # Determine split payment status
    Run Keyword    Is Split Pay    ${agreement_acronym}
    Log To Console    Is Split Pay: ${is_split_pay}

    # Log to indicate we're calling the API
    Log To Console    Calling Create Quote
    

    # Get access token
    ${access_token}=   Get Access Token1    ${username}    ${password}    ${client_id}    ${client_secret}

    Log To Console    Passing Is Split Pay to save_quote: ${is_split_pay}
    ${response}=    save_quote   ${quote_type}  ${account_id}  ${contact_id}  ${address_id}  ${agreement_acronym}  ${approving_ecr_id}  ${society_ecr_id}  ${membershipReference}  ${discount_matrix_id}  ${is_split_pay}

    # Log the entire response for debugging
    Log To Console    Entire Response: ${response}
    Log To Console   ${agreement_acronym}
    Log To Console    ${society_ecr_id}  
    Log To Console    ${membershipReference}
    
    # Extract status code and quote_id
    ${status_code}=    Set Variable    ${response['response'].status_code}
    ${quote_id}=       Set Variable    ${response['quote_id']}

    # Log for debugging
    Log To Console    Status Code: ${status_code}
    Log To Console    Quote ID: ${quote_id}

    # Check if the 'body' field is in the response
    ${body}=           Set Variable    ${response['body']}

    # Safely extract fields from the body
    ${pii}=                            Set Variable   ${body['opportunity']['quote']['quoteLines'][0]['article']['pii']}
    ${quote_type}=                     Set Variable   ${body['opportunity']['quote']['quoteType']}
    ${agreementAcronym}=               Set Variable   ${body['opportunity']['quote']['agreementAcronym']}
    ${society_ecr_id}=                 Set Variable   ${body["opportunity"]["quote"]["societyEcrId"]}
    ${membership_reference}=           Set Variable   ${body["opportunity"]["quote"]["membershipReference"]}
    ${approving_ecr_id}=               Set Variable   ${body["opportunity"]["quote"]["approvingEcrId"]}
    ${discount_matrix_id}=             Set Variable   ${body["opportunity"]["quote"]["discountMatrixId"]}
   

    # Log extracted values for debugging
    Log To Console    PII: ${pii}
    Log To Console    Quote Type: ${quote_type}
    Log To Console    Agreement Acronym: ${agreementAcronym}
    Log To Console    Society EcrId: ${society_ecr_id}
    Log To Console    Approving EcrId: ${approving_ecr_id}
    Log To Console    Discount Matirix: ${discount_matrix_id}
    

    # Return all values
    RETURN    ${status_code}    ${pii}    ${quote_type}    ${agreementAcronym}    ${quote_id}  
  
