import requests

def get_access_token(username, password, client_id, client_secret):
    url = "https://test.salesforce.com/services/oauth2/token"
  
  username = str(username)
    password = str(password)
    client_id = str(client_id)
    client_secret = str(client_secret)

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