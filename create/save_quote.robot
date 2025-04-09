*** Settings ***
# Test suite settings
Documentation              SFOA Quote Type E2E Journey
Resource                   ../resources/common.resource
Resource                   ../resources/quote_management.resource
Library                    ../libraries/save_quote_payload.py
Library                    QForce
Library                    String
Suite Setup                Setup Browser
Suite Teardown             End Suite

*** Variables ***
${EMPTY}

*** Test Cases ***
#####################################################################################################
AUTHOR_AGREEMENT_PAYS
    [Documentation]    AUTHOR_AGREEMENT_PAYS Journey
    [Tags]             AUTHOR_AGREEMENT_PAYS
    Appstate           Home
    Set Test Variables   AUTHOR_AGREEMENT_PAYS    001Vd000000opiVIAQ    003Vd000000eYPaIAM    a0GVd0000002DijMAE    CRTDISCOUNTAGREEMENT    ${EMPTY}    ${EMPTY}    ECR-0111    a0VVd000002TyyvMAC
    Create

#####################################################################################################
AUTHOR_PAYS
    [Documentation]    AUTHOR_PAYS Journey
    [Tags]             AUTHOR_PAYS
    Appstate           Home
    Set Test Variables  AUTHOR_PAYS   001Vd000000opiVIAQ    003Vd000000eYPaIAM    a0GVd0000002DijMAE    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Create

#####################################################################################################
AUTHOR_ORG_AGREEMENT_PAYS
    [Documentation]    AUTHOR_ORG_AGREEMENT_PAYS Journey
    [Tags]             AUTHOR_ORG_AGREEMENT_PAYS
    Appstate           Home
    Set Test Variables  AUTHOR_ORG_AGREEMENT_PAYS    001Vd00000CUMViIAP    003Vd00000HGQXqIAP    a0GVd000002XQ7RMAW    CRTDISCOUNTAGREEMENT    ${EMPTY}    ${EMPTY}    ECR-0111    a0VVd000002TyyvMAC
    Create

#####################################################################################################
ORG_PAYS
    [Documentation]    ORG_PAYS Journey
    [Tags]             ORG_PAYS
    Appstate           Home
    Set Test Variables  ORG_PAYS  001Vd00000CUMViIAP    003Vd000000eYPaIAM    a0GVd000002XQ7RMAW    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Create

#####################################################################################################
ORG_PAYS_AGREEMENT
    [Documentation]    ORG_PAYS_AGREEMENT Journey
    [Tags]             ORG_PAYS_AGREEMENT
    Appstate           Home
    Set Test Variables  ORG_PAYS_AGREEMENT  001Vd00000CUMViIAP    003Vd00000HGQXqIAP    a0GVd000002XQ7RMAW    CRTAGREEMENT    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Create 

#####################################################################################################
ORG_PAYS_SOCIETY
    [Documentation]    ORG_PAYS_SOCIETY Journey
    [Tags]             ORG_PAYS_SOCIETY
    Appstate           Home
    Set Test Variables    ORG_PAYS_SOCIETY    001Vd00000CdidSIAR    003Vd000003KXwwIAG    a0GVd000002a921MAA    ${EMPTY}    ECR-CRT111    9332    ${EMPTY}    a0VVd000002U1TlMAK
    Create

#####################################################################################################

*** Keywords ***
Create
    ${status_code}    ${pii}    ${quote_type_result}    ${agreement_acronym_result}    ${quote_id}=    Create Quote  ${quote_type}  ${account_id}  ${contact_id}  ${address_id}  ${agreement_acronym}  ${society_ecr_id}  ${membership_reference}  ${approving_ecr_id}  ${discount_matrix_id}

    Log To Console    Status Code: ${status_code}
    Log To Console    PII from test: ${pii}
    Log To Console    Quote ID: ${quote_id}
    