*** Settings ***
Library                 QForce
Library                 Collections
Library                 OperatingSystem
Library                 DateTime


*** Variables ***
${BROWSER}                chrome
${mfa}                    ${FALSE}                # True -> Run with App authentication.
${file_folder}            files

${login_url1}=             ${SF_URL_SIT} 
${SF_UserName1}=           ${SF_UserName_SIT} 
${SF_Password1}            ${SF_Password_SIT}

${username}         ${username}
${password}         ${password}
${client_id}        ${client_id}
${client_secret}    ${client_secret}

*** Keywords ***
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
    GoTo                 ${login_url1}
    TypeText             Username                    ${SF_UserName1}
    TypeSecret           Password                    ${SF_Password1}
    ClickText            Log In

Home
    GoTo                 ${login_url1}lightning/page/home  
    ${login_status} =    IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If       ${login_status}             Login            
    ClickText            Home
    VerifyTitle          Home | Salesforce