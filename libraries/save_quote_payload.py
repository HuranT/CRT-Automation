import requests
import access_token_params
import quote_type
import json

def save_quote (quotetype_name):
    
    print(f"quotetype_name in save_quote function: {quotetype_name}")
    access_token = access_token_params.get_access_token()
    # Set the URL and headers
    url = "https://relx-elsevier-oa--sit.sandbox.my.salesforce.com/services/apexrest/save-quote"
    headers = {
        'Cookie': "BrowserId=oWxKWcLTEe2xEp1gGMu7DA; CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1",
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'X-JWT-Assertion': access_token,
        'Authorization': f"Bearer {access_token}",
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive'
    }

    # Get the request body from the save_quote_payload module
    body = quote_type.update_body(quotetype_name)

    # Calculate the Content-Length header
    content_length = str(len(json.dumps(body)))

    # Set the Host header using the URL
    host = requests.utils.urlparse(url).netloc

    # Add the Content-Length and Host headers to the headers dictionary
    headers['Content-Length'] = content_length
    headers['Host'] = host

    # Make the POST request
    response = requests.post(url, headers=headers, json=body)

    # Extract the quote ID from the response body
    quote_id = response.json()['quoteId']

    # Create a dictionary to store the response and body
    result = {'response': response, 'body': body, 'quote_id': quote_id}
        
    # Return the dictionary
    return result
    