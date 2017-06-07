@isTest
public class EMailHandlerTest{
    
    @isTest
    public static void unitTest(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Coool';
        email.fromName = 'test test';
        email.plainTextBody = 'Hello, this a test email body. for testing purposes only.Phone:123456 Bye';
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[1];  
        Messaging.InboundEmail.BinaryAttachment binaryAttachment = new Messaging.InboundEmail.BinaryAttachment();
        binaryAttachment.Filename = 'test.txt';
        String algorithmName = 'HMacSHA1';
        Blob b = Crypto.generateMac(algorithmName, Blob.valueOf('test'),
        Blob.valueOf('test_key'));
        binaryAttachment.Body = b;
        binaryAttachments[0] =  binaryAttachment ;
        email.binaryAttachments = binaryAttachments ;
        envelope.fromAddress = 'user@acme.com';
        
        
        EMailHandler Eh = new EMailHandler();
        Eh.handleInboundEmail(email, envelope);
    }
}