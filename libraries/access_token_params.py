import requests
import logging

def get_access_token(username, password, client_id, client_secret):

       # Log the arguments passed into the function
    logging.debug(f"Username: {username}")
    logging.debug(f"Password: {password}")
    logging.debug(f"Client ID: {client_id}")
    logging.debug(f"Client Secret: {client_secret}")
    url = "https://test.salesforce.com/services/oauth2/token"

    payload = {
        "grant_type": "password",
        "client_id": client_id,
        "client_secret": client_secret,
        "username": username,
        "password": password
    }

    response = requests.post(urlStringold, data=payload)

    if response.status_code == 200:
        json_response = response.json()
        print(json_response)
        access_token = json_response['access_token']
        return access_token
    else:
        print("Error: ", response.status_code, response.reason)
        return None
