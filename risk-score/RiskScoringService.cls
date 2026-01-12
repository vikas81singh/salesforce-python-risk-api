public with sharing class RiskScoringService {

  public class  RiskRequest {
        public integer age;
        public Decimal income;
        public Integer   conditions;
    }
    public class RiskResponse {
       @InvocableVariable   public Integer riskScore;
       @InvocableVariable    public String riskLevel;
    }
   @InvocableMethod(label='Get Patient Risk score')
    public static List<RiskResponse> getRiskScore(List<String> jsonInput) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Risk_API/risk-score');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

     
        List<RiskRequest> body = (List<RiskRequest >)JSON.deserialize(
                jsonInput[0],     List<RiskRequest>.class
            );
        req.setBody(JSON.serialize(body[0]));
        req.setTimeout(2000);

        Http http = new Http();
        HttpResponse res = http.send(req);
        List<RiskScoringService.RiskResponse> lstes=new List<RiskScoringService.RiskResponse>();
        if (res.getStatusCode() == 200) {
        RiskResponse redata=(RiskResponse) JSON.deserialize(res.getBody(), RiskResponse.class);
        
        
          lstes.add(redata);
        } 
        else
         {
            throw new CalloutException(
                'Risk API failed: ' + res.getBody()
            );
        }
        return lstes;
    }
}