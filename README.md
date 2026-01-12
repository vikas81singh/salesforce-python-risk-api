Deploy Python API over Render
🚀 Deploy Python API on Render (Step by Step)
🎯 Goal

Get a public HTTPS URL that Salesforce can call:

https://your-app-name.onrender.com/risk-score

🧠 STEP 1: Prepare Your Python Project (Local)
1.1 Project Structure (VERY IMPORTANT)

Render expects this structure:

risk-scoring-api/
│── main.py
│── requirements.txt


👉 Question:
Why do you think Render needs requirements.txt?

(Think: how does Render know what to install?)

1.2 main.py (Final Version)

Make sure your file looks like this:

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Risk Scoring Service")

class RiskInput(BaseModel):
    age: int
    income: float
    conditions: int

@app.post("/risk-score")
def calculate_risk(data: RiskInput):

    score = 0

    if data.age > 50:
        score += 30
    if data.income < 500000:
        score += 20
    if data.conditions >= 2:
        score += 30

    score = min(score, 100)

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

1.3 Create requirements.txt

This file tells Render what libraries to install.

fastapi
uvicorn
pydantic


⚠️ No extra spaces, no versions needed for now

✅ Checkpoint 1

Can you explain the purpose of requirements.txt in one line?

🌐 STEP 2: Push Code to GitHub

Render deploys from GitHub.

2.1 Create GitHub Repo

Example name:

salesforce-python-risk-api

2.2 Push Code
git init
git add .
git commit -m "Initial risk scoring API"
git branch -M main
git remote add origin https://github.com/<your-username>/salesforce-python-risk-api.git
git push -u origin main


📌 Make sure main.py is at root, not inside a folder.

✅ Checkpoint 2

Why do you think Render prefers Git-based deployments?

☁️ STEP 3: Create Render Web Service
3.1 Go to Render

👉 https://render.com

👉 Sign in using GitHub

3.2 Create New Web Service

Click:

New +  →  Web Service


Select your repo:

salesforce-python-risk-api

3.3 Configure Service (IMPORTANT)
Setting	Value
Name	risk-scoring-api
Runtime	Python
Branch	main
Build Command	pip install -r requirements.txt
Start Command	uvicorn main:app --host 0.0.0.0 --port 10000
Instance Type	Free

📌 Port 10000 is mandatory on Render

🔍 Why this Start Command?

main:app → file name + FastAPI app object

0.0.0.0 → public access

10000 → Render requirement

✅ Checkpoint 3

What would happen if you used localhost instead of 0.0.0.0?

🚀 STEP 4: Deploy & Verify

Click Create Web Service
Render will:

Install dependencies

Start server

Give you a public URL

Example:

https://risk-scoring-api.onrender.com

🧪 STEP 5: Test Deployment
5.1 Open Swagger UI
https://risk-scoring-api.onrender.com/docs

5.2 Test /risk-score

Request:

{
  "age": 55,
  "income": 400000,
  "conditions": 2
}


Expected response:

{
  "riskScore": 80,
  "riskLevel": "HIGH"
}


🎉 If this works → Salesforce CAN CALL THIS API

✅ Checkpoint 4

Why is Swagger (/docs) extremely helpful for Salesforce developers?

<img width="1536" height="1024" alt="ChatGPT Image Jan 12, 2026, 07_37_03 AM" src="https://github.com/user-attachments/assets/df13ddb1-e2b9-4388-ae52-83f69ee7f8c6" />
