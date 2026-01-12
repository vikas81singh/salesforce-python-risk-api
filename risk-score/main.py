
from fastapi import FastAPI
from pydantic import BaseModel

# Create API app
app = FastAPI(title="Risk Scoring Service")

# Define input schema
class RiskInput(BaseModel):
    age: int
    income: float
    conditions: int

# API endpoint
@app.post("/risk-score")
def calculate_risk(data: RiskInput):

    score = 0

    # Simple business rules
    if data.age > 50:
        score += 30

    if data.income < 500000:
        score += 20

    if data.conditions >= 2:
        score += 30

    # Cap score at 100
    score = min(score, 100)

    # Risk level
    if score >= 70:
        level = "HIGH"
    elif score >= 40:
        level = "MEDIUM"
    else:
        level = "LOW"

    return {
        "riskScore": score,
        "riskLevel": level
    }
