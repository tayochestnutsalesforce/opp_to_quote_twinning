@isTest
public class rc_InvocableFieldTwinningTest {
    @testSetup
    static void makeData(){
        Account a = new Account(Name = 'Test Account');
        insert a;

        Opportunity opp = new Opportunity(Name = 'Test Opp 1', StageName = 'Qualifying', Amount = 100, CloseDate = System.today(),rc_Test_Checkbox__c = true);
        insert opp;
    }

    @isTest
    public static void startTwinTest(){
        Account acc = [Select id from Account LIMIT 1];
        Opportunity opp = [Select id from Opportunity LIMIT 1];
        Test.startTest();
            SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Opportunity2__c = opp.Id, SBQQ__Account__c = acc.Id,rc_Test_Checkbox__c = false);
            insert quote;
        Test.stopTest();

        SBQQ__Quote__c checkQuote = [Select rc_test_Checkbox__c from SBQQ__Quote__c where id=:quote.Id];
        system.assertEquals(true, checkQuote.rc_Test_Checkbox__c);
    }

}