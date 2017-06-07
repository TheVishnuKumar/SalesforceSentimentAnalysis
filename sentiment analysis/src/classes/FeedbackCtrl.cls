public class FeedbackCtrl{
    public feedback__c fbck {get;set;}
    public string color{get;set;}
    public decimal score{get;set;}
     
    public FeedbackCtrl( ApexPages.StandardController controller ){
        fbck = [ select id, Sentiment__c, Sentiment_Score__c from feedback__c where id =: controller.getRecord().id ];
        
        if( fbck.Sentiment__c == null || fbck.Sentiment_Score__c == null ){
            color='black';
            fbck.Sentiment_Score__c = 0;
            fbck.Sentiment__c = 'Somethign went wrong.';
            return;
        }
        
        color = '';
        score = math.abs(fbck.Sentiment_Score__c.setScale(2));
        fbck.Sentiment__c = fbck.Sentiment__c.capitalize();

        if( fbck.Sentiment__c.equalsIgnoreCase('negative') ){
            color='#bf0000';
        }
        else if( fbck.Sentiment__c.equalsIgnoreCase('slightly negative') ){
            color='#e48989';
        }
        else if( fbck.Sentiment__c.equalsIgnoreCase('positive') ){
            color='green';
        }
        else if( fbck.Sentiment__c.equalsIgnoreCase('slightly positive') ){
            color='#61bf61';
        }
        else if( fbck.Sentiment__c.equalsIgnoreCase('mixed') ){
            color='#afa100';
        }
        else if( fbck.Sentiment__c.equalsIgnoreCase('neutral') ){
            color='#e2e2e2';
        }
    }
 
}