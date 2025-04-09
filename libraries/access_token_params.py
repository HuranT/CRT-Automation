import requests

def get_access_token(username1, password1, client_id1, client_secret1):
    url = "https://test.salesforce.com/services/oauth2/token"

    payload = {
        "grant_type": "password",
        "client_id": client_id1,
        "client_secret": client_secret1,
        "username": username1,
        "password": password1
    }

    response = requests.post(url, data=payload)

    if response.status_code == 200:
        access_token = response.json()['access_token']
        return access_token
    else:
        print(f"Error: {response.status_code} - {response.text}")
        return None