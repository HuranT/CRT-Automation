import requests
import access_token_params
import quote_type
import json
from robot.api import logger


def save_quote(quotetype_name, account_id, contact_id, address_id, agreement_acronym=None, approving_ecr_id=None, society_ecr_id=None, membership_reference=None, discount_matrix_id=None, is_split_pay=None, tax_registration_number=None, tax_validation_result=None):
    print(f"quotetype_name in save_quote function: {quotetype_name}")
    logger.info(f"Received is_split_pay: {is_split_pay}", also_console=True)

    # Get the access token
    access_token = access_token_params.get_access_token()
    if not access_token:
        print("Access token retrieval failed.")
        return None

    # Define the URL and headers
    url = "https://relx-elsevier-oa--sit.sandbox.my.salesforce.com/services/apexrest/save-quote"
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': f"Bearer {access_token}"
    }

    # Get the request body
    body = quote_type.update_body(
        quotetype_name, account_id, contact_id, address_id, 
        agreement_acronym, approving_ecr_id, society_ecr_id, 
        membership_reference, discount_matrix_id, 
        tax_registration_number, tax_validation_result, is_split_pay
    )
    
    # Log the request body for debugging
    print(f"Request Body: {json.dumps(body, indent=4)}")

    # Make the POST request
    response = requests.post(url, headers=headers, json=body)
    
    # Handle response
    if response.status_code != 200:
        print(f"Failed to create quote. Status code: {response.status_code}, Response: {response.content}")
        return None

    # Parse JSON response
    if 'application/json' in response.headers.get('Content-Type', ''):
        response_json = response.json()
        quote_id = response_json.get('quoteId')
    else:
        print(f"Non-JSON response received: {response.content}")
        return None

    # Prepare the result dictionary
    result = {'response': response, 'body': body, 'quote_id': quote_id}
    return result
