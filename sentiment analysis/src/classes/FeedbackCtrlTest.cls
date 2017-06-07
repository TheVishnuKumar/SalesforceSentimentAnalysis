@isTest
public class FeedbackCtrlTest{

    @isTest
    public static void unittest(){
        feedback__c fbObj = new feedback__c();
        fbObj.name = 'vishnu@kumar.com';
        fbObj.Sentiment__c = 'negative';
        fbObj.Sentiment_Score__c = 92.3;
        insert fbObj;

        ApexPages.StandardController controller = new ApexPages.StandardController(fbObj);
        FeedbackCtrl Fctrl = new FeedbackCtrl(controller);
        
        fbObj.Sentiment__c = 'slightly negative';
        update fbObj;
        
        controller = new ApexPages.StandardController(fbObj);
        Fctrl = new FeedbackCtrl(controller);
        
        fbObj.Sentiment__c = 'positive';
        update fbObj;
        
        controller = new ApexPages.StandardController(fbObj);
        Fctrl = new FeedbackCtrl(controller);
        
        fbObj.Sentiment__c = 'slightly positive';
        update fbObj;
        
        controller = new ApexPages.StandardController(fbObj);
        Fctrl = new FeedbackCtrl(controller);
        
        fbObj.Sentiment__c = 'mixed';
        update fbObj;
        
        controller = new ApexPages.StandardController(fbObj);
        Fctrl = new FeedbackCtrl(controller);
        
        fbObj.Sentiment__c = 'neutral';
        update fbObj;
        
        controller = new ApexPages.StandardController(fbObj);
        Fctrl = new FeedbackCtrl(controller);     
    }
}