import requests

def get_access_token():
    urlStringold = "https://test.salesforce.com/services/oauth2/token"

    payload = {
        "grant_type": "password",
        "client_id": "3MVG9buXpECUESHhY8a2aZIZ46try6_OsE7Z14UxG54sEAis4OnGUsdIEJqFpjR7wT8dyAVWzBJFd2n.Z9Nzx",
        "client_secret": "41A87B5E19212FA3FD8DBD3147868A3B6553F174A63CA0E7DA19E8D88A758B45",
        "username": "crt@elsevier.com.sit",
        "password": "CopadoSit1VldVuYAAdJiPiUD6NqwfiUGz"
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
