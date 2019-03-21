@isTest
public class TestStartAndStop {
    @isTest static void methodOne() {
        for (Integer i = 0; i < 100; i++) {
            List<Lead> l = [SELECT ID FROM Lead LIMIT 1];
        }
        
        System.debug('Number of queries used: ' + Limits.getQueries());
        System.debug('Number of queries allowed: ' + Limits.getLimitQueries());
        
        Test.startTest();
        System.debug('Number of queries used: ' + Limits.getQueries());
        Test.stopTest();
        System.debug('Number of queries used: ' + Limits.getQueries());
    }
}