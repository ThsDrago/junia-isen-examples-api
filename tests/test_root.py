from fastapi.testclient import TestClient
from examples.examples import app
import os

client = TestClient(app)


def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}

def test_read_quotes():
    # Tester la route "/quotes"
    print("STORAGE_ACCOUNT_URL:", os.getenv("STORAGE_ACCOUNT_URL"))

    response = client.get("/quotes")
    
    # Afficher la réponse pour inspection
    print(response.json())
    
    # Assurez-vous que la réponse a le code de statut 200
    assert response.status_code == 200
    
    # Assurez-vous que la réponse contient une clé "quotes" et qu'elle n'est pas vide
    assert "quotes" in response.json()
    assert len(response.json()["quotes"]) > 0