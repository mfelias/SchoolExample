@isTest(SeeAllData=true)
public class RunAsTest {
    @isTest static void viewClasses() {
        User u = [SELECT ID FROM User WHERE ID = '0051U00000468clQAA'];
        
        List<Class__c> classes = [SELECT ID, Name FROM Class__c];
        System.debug('classes ' + classes);
        
        System.runAs(u) {
            classes = [SELECT ID, Name FROM Class__c];
            System.debug('classes ' + classes);
        }
        System.debug('classes ' + classes);
    }
}