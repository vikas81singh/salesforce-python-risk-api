
# tests/test_api.py
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_risk_score_high():
    resp = client.post("/risk-score", json={"age": 60, "income": 400000, "conditions": 2})
    assert resp.status_code == 200
    data = resp.json()
    assert data["riskScore"] == 80
    assert data["riskLevel"] == "HIGH"
