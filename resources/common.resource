*** Settings ***
Library                 QForce
Library                 Collections
Library                 OperatingSystem
Library                 DateTime
Library                 ../libraries/access_token_params.py
Library                 ../libraries/save_quote_payload.py
Library                 ../libraries/primary_quote_setter.py
Library                 ../libraries/approve_quote.py
Library                 ../libraries/quote_type.py


*** Variables ***
${BROWSER}                chrome
${mfa}                    ${FALSE}                # True -> Run with App authentication.
${file_folder}            files
${environment}            SIT
${login_url1}             https://production.salesforce.com
${SF_UserName1}            production_username
${SF_Password1}            production_password
*** Keywords ***

Create Quote 
    [Documentation]            Generates a quote 
    [tags]                     REST API                     Create
    [Arguments]                ${quote_type}
    ${accessToken}=            access_token_params.get_access_token
    ${response}=               save_quote_payload.save_quote    ${quote_type}
    Log To Console    Calling Create Quote
    ${quote_id}=               Set Variable                 ${response['quote_id']}
    ${status_code}=            Set Variable                 ${response['response'].status_code}
    ${pii}=                    Set Variable                 ${response['body']['opportunity']['quote']['quoteLines'][0]['article']['pii']}
    ${quote_type}=             Set Variable                 ${response['body']['opportunity']['quote']['quoteType']}
    ${agreementAcronym}=       Set Variable                 ${response['body']['opportunity']['quote']['agreementAcronym']}
    ${account}=                Set Variable                 ${response['body']['opportunity']['quote']['accountId']}
    ${societyEcrId}=           Set Variable                 ${response['body']['opportunity']['quote']['societyEcrId']}
    ${membershipReference}=    Set Variable                 ${response['body']['opportunity']['quote']['membershipReference']}
    
    
    [Return]                   ${status_code}                ${pii}                ${quote_type}         ${agreementAcronym}       ${account}     ${societyEcrId}     ${membershipReference}     ${quote_id}  


Set quote to primary
    [Documentation]            sets given quote as primary 
    [Arguments]                ${quote_id}
    ${primaryQuote}=           primary_quote_setter.set_primary       ${quote_id}



Approve qoute
    [Documentation]            accept given quote
    [Arguments]                ${quote_id}
    ${approvedQuote}=          approve_quote.set_approved   ${quote_id}

Cookie check
    ${is_modal}=    IsText    Before you continue
    IF  ${is_modal}
        ClickText             Accept all
    END

Setup Browser
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              30s                    #sometimes salesforce is slow
    SetConfig             CSSSelectors                False    

End suite
    Close All Browsers
 
Login
    [Documentation]      Login to Salesforce instance
    GoTo                 ${login_url}
    TypeText             Username                    ${SF_UserName1}
    TypeSecret           Password                    ${SF_Password1}
    ClickText            Log In

Home
    GoTo                 ${login_url1}lightning/page/home  
    ${login_status} =    IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If       ${login_status}             Login            
    ClickText            Home
    VerifyTitle          Home | Salesforce

Environment Setup
    [Documentation]    Set environment-specific variables
    [Tags]             Setup
    Run Keyword If     '${environment}' == 'SIT'     Set SIT Environment
    Run Keyword If     '${environment}' == 'QA'      Set QA Environment

Set SIT Environment
    Set Global Variable    ${login_url1}              https://relx-elsevier-oa--sit.my.salesforce.com/
    Set Global Variable    ${SF_UserName1}            ${SF_UserName} 
    Set Global Variable    ${SF_Password1}            ${SF_Password}

Set QA Environment
    Set Global Variable    ${login_url1}              https://relx-elsevier-oa--qa.my.salesforce.com/
    Set Global Variable    ${SF_UserName1}             qa_username
    Set Global Variable    ${SF_Password1}             qa_password