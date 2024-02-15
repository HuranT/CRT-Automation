*** Settings ***
Documentation              SFOA E2E Journey
Resource                   ../resources/common.resource
Suite Setup                Setup Browser
Suite Teardown             End Suite
Library                    QForce
Library                    String
Library                    SeleniumLibrary

*** Variables ***


*** Test Cases ***
ORG_PAYS Regressıon  
    [Documentation]                        ORG_PAYS Journey
    [Tags]                                 ORG_PAYS
    Appstate                               Home
    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote  ORG_PAYS

    Set Test Variable                      ${status_code}
    Should Be Equal As Integers            ${status_code}                   200

    Set quote to primary                   ${quote_id}
    ClickText                              Search...                        anchor=Sales
    TypeText                               Search...                        ${pII}
    ClickText                              Opportunity
    VerifyField                            Opportunity Name                 ${pII}
    VerifyCheckboxValue                    Primary                          on
    ClickText                              Quotes
    VerifyNoText                           Opportunity Name 

    # Verify quote details
    UseTable                               Quotes
    ${quote_number}=                       GetCellText                      r?${quote_type}/c3  tag=a     between=Open ??? Preview
    ClickText                              ${quote_number}
    VerifyField                            Number                           ${quote_number}                      
    VerifyField                            Opportunity                      ${pii}                  partial_match=True delay=5s
    VerifyField                            Quote Type                       ${quote_type}                 
    VerifyField                            Agreement                        ${agreementAcronym}
    VerifyElement                          //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Approves quote and verifies if an order has been created
    Approve qoute                          ${quote_id}
    Sleep                                  5s
    RefreshPage
    VerifyField                            Status                           Accepted
    ClickText                              Orders
    UseTable                               Orders

    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       on
    VerifyField                            Overall Order Status          Submitted
    VerifyField                            Order Status                  Accepted
    VerifyField                            Invoice Status                Accepted
    ${invoice_reference}=                  GetFieldValue                 Invoice Reference 
    Run Keyword If                         '${invoice_reference}' == ''  Fail    Invoice Reference is blank!

    
   
ORG_PAYS_AGREEMENT Regression  
    [Documentation]                       ORG_PAYS_AGREEMENT Journey
    [Tags]                                ORG_PAYS_AGREEMENT
    Appstate                              Home

    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote    ORG_PAYS_AGREEMENT
    Set Test Variable                     ${status_code}
    Should Be Equal As Integers           ${status_code}                  200

    Set quote to primary                  ${quote_id}
    ClickText                             Search...                       anchor=Sales
    TypeText                              Search...                       ${pII}
    ClickText                             Opportunity
    VerifyField                           Opportunity Name                ${pII}
    UseTable                              Quotes
    VerifyCheckboxValue                   Primary                         on
    ClickText                             Quotes
    VerifyNoText                          Opportunity Name
    UseTable                              Quotes
    
 
    # Verify quote details
    ${quote_number}=                      GetCellText                     r?${quote_type}/c3  tag=a       between=Open ??? Preview
    ClickText                             ${quote_number}
    VerifyField                           Number                          ${quote_number}                      
    VerifyField                           Opportunity                     ${pii}                  partial_match=True delay=5s
    VerifyField                           Quote Type                      ${quote_type}                 
    VerifyField                           Agreement ID                    ${agreementAcronym}
    VerifyElement                         //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Logsin as an shared EOAP user and acceptes APC
    ClickText                             EOAP Sharing
    ClickText                             david Institute 
    sleep                                 2s
    SwitchWindow                          NEW
    SwitchWindow                          2
    ClickText                             Log in to Experience as User
    sleep                                 2s
    
    
    ClickText                             Accept all cookies
    ClickText                             Requests
    ClickText                             Article Title Regression Test: ${pII}     partial_match=False delay=5s
    ClickText                             Please select billing address    anchor=*
    ClickText                             Regent Street
    ClickText                             Approve request
    ClickText                             close
    sleep                                 3s
    CloseWindow                                              

    # Verifies if quote accepted and order has been created
    ClickText                             Details
    RefreshPage
    VerifyField                           Status                Accepted
    ClickText                             Orders
    UseTable                              Orders
    
    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       on
    VerifyField                            Overall Order Status          Submitted
    VerifyField                            Order Status                  Accepted
    VerifyField                            Invoice Status                Accepted
    ${invoice_reference}=                  GetFieldValue                 Invoice Reference 
    Run Keyword If                         '${invoice_reference}' == ''  Fail    Invoice Reference is blank!
    
AUTHOR_PAYS Regression  
    [Documentation]                        AUTHOR_PAYS Journey
    [Tags]                                 AUTHOR_PAYS
    Appstate                               Home
    
    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote    AUTHOR_PAYS
    Set Test Variable                      ${status_code}
    Should Be Equal As Integers            ${status_code}                   200
    
    Set quote to primary                   ${quote_id}
    ClickText                              Search...                        anchor=Sales
    TypeText                               Search...                        ${pII}
    ClickText                              Opportunity
    VerifyField                            Opportunity Name                 ${pII}
    VerifyCheckboxValue                    Primary                          on
    ClickText                              Quotes
    VerifyNoText                           Opportunity Name 

    # Verify quote details
    UseTable                               Quotes
    ${quote_number}=                       GetCellText                      r?${quote_type}/c3  tag=a     between=Open ??? Preview
    ClickText                              ${quote_number}
    VerifyField                            Number                           ${quote_number}                      
    VerifyField                            Opportunity                      ${pii}                  partial_match=True delay=5s
    VerifyField                            Quote Type                       ${quote_type}                 
    VerifyField                            Agreement                        ${agreementAcronym}
    VerifyElement                          //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Approves quote and verifies if an order has been created
    Approve qoute                          ${quote_id}
    Sleep                                  5s
    RefreshPage
    VerifyField                            Status                           Accepted
    ClickText                              Orders
    UseTable                               Orders

    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       off
    VerifyField                            Overall Order Status          Order Needs Review
    VerifyField                            Order Status                  ${EMPTY}
    VerifyField                            Invoice Status                ${EMPTY}
    VerifyField                            Invoice Reference             ${EMPTY}

AUTHOR_AGREEMENT_PAYS Regression  
    [Documentation]                        AUTHOR_AGREEMENT_PAYS Journey
    [Tags]                                 AUTHOR_AGREEMENT_PAYS
    Appstate                               Home

    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote    AUTHOR_AGREEMENT_PAYS
    Set Test Variable                      ${status_code}
    Should Be Equal As Integers            ${status_code}                   200
  
    Set quote to primary                  ${quote_id}
    ClickText                             Search...                       anchor=Sales
    TypeText                              Search...                       ${pII}
    ClickText                             Opportunity
    VerifyField                           Opportunity Name                ${pII}
    UseTable                              Quotes
    VerifyCheckboxValue                   Primary                         on
    ClickText                             Quotes
    VerifyNoText                          Opportunity Name
    UseTable                              Quotes
    
 
    # Verify quote details
    ${quote_number}=                      GetCellText                     r?${quote_type}/c3  tag=a       between=Open ??? Preview
    ClickText                             ${quote_number}
    VerifyField                           Number                          ${quote_number}                      
    VerifyField                           Opportunity                     ${pii}                  partial_match=True delay=5s
    VerifyField                           Quote Type                      ${quote_type}                 
    VerifyField                           Agreement ID                    ${agreementAcronym}
    VerifyElement                         //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Logsin as an shared EOAP user and acceptes APC
    ClickText                             EOAP Sharing
    ClickText                             Test Admin 
    sleep                                 2s
    SwitchWindow                          NEW
    SwitchWindow                          2
    ClickText                             Log in to Experience as User
    sleep                                 2s
    ClickText                             Requests
    ClickText                             Article Title Regression Test: ${pII}     partial_match=False delay=5s
    ClickText                             Approve request
    ClickText                             close
    sleep                                 2s
    CloseWindow

    # Verifies if quote accepted and order has been created
    ClickText                             Details
    RefreshPage
    VerifyField                           Status                Accepted
    ClickText                             Orders
    UseTable                              Orders
    
    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       off
    VerifyField                            Overall Order Status          Order Needs Review
    VerifyField                            Order Status                  ${EMPTY}
    VerifyField                            Invoice Status                ${EMPTY}
    VerifyField                            Invoice Reference             ${EMPTY}

AUTHOR_ORG_AGREEMENT_PAYS Regression  
    [Documentation]                        AUTHOR_ORG_AGREEMENT_PAYS Journey
    [Tags]                                 AUTHOR_ORG_AGREEMENT_PAYS
    Appstate                               Home

    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote    AUTHOR_ORG_AGREEMENT_PAYS
    Set Test Variable                      ${status_code}
    Should Be Equal As Integers            ${status_code}                   200
  
    Set quote to primary                  ${quote_id}
    ClickText                             Search...                       anchor=Sales
    TypeText                              Search...                       ${pII}
    ClickText                             Opportunity
    VerifyField                           Opportunity Name                ${pII}
    UseTable                              Quotes
    VerifyCheckboxValue                   Primary                         on
    ClickText                             Quotes
    VerifyNoText                          Opportunity Name
    UseTable                              Quotes
    
 
    # Verify quote details
    ${quote_number}=                      GetCellText                     r?${quote_type}/c3  tag=a       between=Open ??? Preview
    ClickText                             ${quote_number}
    VerifyField                           Number                          ${quote_number}                      
    VerifyField                           Opportunity                     ${pii}                  partial_match=True delay=5s
    VerifyField                           Quote Type                      ${quote_type}                 
    VerifyField                           Agreement ID                    ${agreementAcronym}
    VerifyElement                         //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Logsin as an shared EOAP user and acceptes APC
    ClickText                             EOAP Sharing
    ClickText                             Test Admin 
    sleep                                 2s
    SwitchWindow                          NEW
    SwitchWindow                          2
    ClickText                             Log in to Experience as User
    sleep                                 2s
    ClickText                             Requests
    ClickText                             Article Title Regression Test: ${pII}     partial_match=False delay=5s
    ClickText                             Approve request
    ClickText                             close
    sleep                                 2s
    CloseWindow

    # Verifies if quote accepted and order has been created
    ClickText                             Details
    RefreshPage
    VerifyField                           Status                Accepted
    ClickText                             Orders
    UseTable                              Orders
    
    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       on
    VerifyField                            Overall Order Status          Submitted
    VerifyField                            Order Status                  Accepted
    VerifyField                            Invoice Status                Accepted
    ${invoice_reference}=                  GetFieldValue                 Invoice Reference 
    Run Keyword If                         '${invoice_reference}' == ''  Fail    Invoice Reference is blank!

ORG_PAYS_SOCIETY
    [Documentation]                       ORG_PAYS_SOCIETY Journey
    [Tags]                                ORG_PAYS_SOCIETY
    Appstate                              Home

    # Create quotes depending on given quote type and verifies 200 response
    ${status_code}  ${pii}  ${quote_type}  ${agreementAcronym}  ${account}  ${quote_id}=    Create Quote    ORG_PAYS_SOCIETY
    Set Test Variable                     ${status_code}
    Should Be Equal As Integers           ${status_code}                  200

    Set quote to primary                  ${quote_id}
    ClickText                             Search...                       anchor=Sales
    TypeText                              Search...                       ${pII}
    ClickText                             Opportunity
    VerifyField                           Opportunity Name                ${pII}
    UseTable                              Quotes
    VerifyCheckboxValue                   Primary                         on
    ClickText                             Quotes
    VerifyNoText                          Opportunity Name
    UseTable                              Quotes
    
 
    # Verify quote details
    ${quote_number}=                      GetCellText                     r?${quote_type}/c3  tag=a       between=Open ??? Preview
    ClickText                             ${quote_number}
    VerifyField                           Number                          ${quote_number}                      
    VerifyField                           Opportunity                     ${pii}                  partial_match=True delay=5s
    VerifyField                           Quote Type                      ${quote_type}                 
    VerifyField                           Agreement ID                    ${agreementAcronym}
    VerifyElement                         //a[contains(@class, 'flex-wrap-ie11') and contains(@href, '/lightning/r/Account/${account}/view')] 
    
    # Logsin as an shared EOAP user and acceptes APC
    ClickText                             EOAP Sharing
    ClickText                             Jon Society  
    sleep                                 2s
    SwitchWindow                          NEW
    SwitchWindow                          2
    ClickText                             Log in to Experience as User
    sleep                                 2s
    
    
    ClickText                             Accept all cookies
    ClickText                             Requests
    ClickText                             Article Title Regression Test: ${pII}     partial_match=False delay=5s                  
    ClickText                             Validate request
    sleep                                 2s
    VerifyText                            Request approved
    ClickText                             close
    sleep                                 3s
    CloseWindow                                              

    # Verifies if quote accepted and order has been created
    ClickText                             Details
    RefreshPage
    VerifyField                           Status                Accepted
    ClickText                             Orders
    UseTable                              Orders
    
    # Verify order details
    ${order_number}=                       GetCellText         r2/c3     between=Open ??? Preview
    sleep                                  5s
    ClickText                              ${order_number}
    VerifyField                            Order Number                  ${order_number}
    VerifyCheckboxValue                    Ordered                       on
    VerifyField                            Overall Order Status          Submitted
    VerifyField                            Order Status                  Accepted
    VerifyField                            Invoice Status                Accepted
    ${invoice_reference}=                  GetFieldValue                 Invoice Reference 
    Run Keyword If                         '${invoice_reference}' == ''  Fail    Invoice Reference is blank!
    