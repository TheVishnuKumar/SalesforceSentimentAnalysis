/*
    This class is used for get inbound email and send API request to get sentiment score of email's Body.
*/
global class EMailHandler implements Messaging.InboundEmailHandler {

    //Getting Inbound Email
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        feedback__c fdbck = new feedback__c();
        fdbck.email__c = email.fromAddress;
        fdbck.name = email.subject;
        fdbck.feedback__c = email.plainTextBody;
        insert fdbck;
        
        if( email.plainTextBody != null ){
            scoreSentiments(fdbck.id+'');
        }
        
        result.success = true;
        return result;
    }
    
    //Making Callout to fetch sentiment score of email's Body and updating feedback record with sentiment API's result
    @future(callout=true)
    public static void scoreSentiments( string fid ){
        
        list<Feedback__c> lstFeedback = [select id,feedback__c from feedback__c where id =: fid ];
        if( lstFeedback.size() > 0 ){
            feedback__c updtFB = lstFeedback[0];
            
            string sentimentStr = '&text='+EncodingUtil.urlEncode(updtFB.feedback__c ,'UTF-8');
            string res = doSentimentAnalysysCallout(sentimentStr);
            
            SentimentAnalysisJsonApex.SentimentAnalysisApex SAJA = SentimentAnalysisJsonApex.parse(res);
            
            for( SentimentAnalysisJsonApex.Sentiment_analysis sc : SAJA.sentiment_analysis ){
                updtFB.sentiment__c = sc.aggregate.sentiment;
                updtFB.sentiment_Score__c = sc.aggregate.score*100;
            }
            
            update updtFB;
        }
    }
    
    //API request process
    public static string doSentimentAnalysysCallout(string param){
        string body = '';
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        string API_KEY = 'fd133240-d02d-4359-98a4-c228c9f38035';

        req.setEndpoint('https://api.havenondemand.com/1/api/sync/analyzesentiment/v2?apikey='+API_KEY+param);
        req.setMethod('GET');

        try {
            if( !test.isRunningTest() ){
                res = http.send(req);
                body = res.getbody();
            }
            else{
                body = '{"sentiment_analysis":[{"positive":[],"negative":[{"sentiment":"am really annoyed with","topic":"your poor performance","score":-0.9824632880367453,"original_text":"I am really annoyed with your poor performance recently","original_length":55,"normalized_text":"I am really annoyed with your poor performance recently","normalized_length":55,"offset":0}],"aggregate":{"sentiment":"negative","score":-0.9824632880367453}}]}';
            }
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }
        
        return body;
    }
}