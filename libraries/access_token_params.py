import requests
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

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

    response = requests.post(url, data=payload)

    if response.status_code == 200:
        access_token = response.json()['access_token']
        return access_token
    else:
        print(f"Error: {response.status_code} - {response.text}")
        return None