import requests
import access_token_params
import json

def set_primary(quote_id):
   
    access_token = access_token_params.get_access_token()
    # Set the URL and headers
    url = f"https://relx-elsevier-oa--sit.sandbox.my.salesforce.com/services/apexrest/Quote__c/{quote_id}"
    headers = {
        'Cookie': "BrowserId=oWxKWcLTEe2xEp1gGMu7DA; CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1",
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'X-JWT-Assertion': access_token,
        'Authorization': f"Bearer {access_token}",
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive'
    }

    # Set the request body
    body = {"primary": True}

    # Make the POST request
    response = requests.post(url, headers=headers, json=body)
        
    # Return the response
    return response