*** Settings ***
Library                 QForce
Library                 Collections
Library                 ../libraries/access_token_params.py
Library                 ../libraries/save_quote_payload.py
Library                 ../libraries/quote_type.py




*** Variables ***

${username}=         ${acc_username} 
${password}=         ${acc_password} 
${client_id}=        ${acc_client_id} 
${client_secret}=    ${acc_client_secret} 

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

*** Keywords ***
Create Quote
    [Arguments]    ${quote_type}  ${account_id}  ${contact_id}  ${address_id}  ${agreement_acronym}  ${society_ecr_id}  ${membershipReference}  ${approving_ecr_id}  ${discount_matrix_id}
    
    # Determine split payment status
    Run Keyword    Is Split Pay    ${agreement_acronym}
    Log To Console    Is Split Pay: ${is_split_pay}
    Log To Console      ${username}    ${password}    ${client_id}    ${client_secret}

    # Get access token
    Log To Console      ${username}    ${password}    ${client_id}    ${client_secret}
    ${access_token}=    access_token_params.get_access_token    ${username}    ${password}    ${client_id}    ${client_secret}
    Log To Console      ${username}    ${password}    ${client_id}    ${client_secret}
    Log To Console    Access Token: ${access_token}

    # Check if access token is retrieved
    Run Keyword If    '${access_token}' == 'None'    Fail    Access token retrieval failed!

    # Continue with the quote creation process using the access token
    Log To Console    Calling Create Quote API
    
    # Your logic to create the quote with the access token
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

    # Safely extract fields from the response body
    ${body}=           Set Variable    ${response['body']}
    ${pii}=            Set Variable    ${body['opportunity']['quote']['quoteLines'][0]['article']['pii']}
    ${quote_type}=     Set Variable    ${body['opportunity']['quote']['quoteType']}
    ${agreementAcronym}=               Set Variable   ${body['opportunity']['quote']['agreementAcronym']}
    
    # Log extracted values for debugging
    Log To Console    PII: ${pii}
    Log To Console    Quote Type: ${quote_type}
    Log To Console    Agreement Acronym: ${agreementAcronym}

    # Return all values
    RETURN    ${status_code}    ${pii}    ${quote_type}    ${agreementAcronym}    ${quote_id}
  
