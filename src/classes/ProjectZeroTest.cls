@isTest
public class ProjectZeroTest {
    @isTest static void testFibonacci() {
        // single action - positive
        System.assertEquals(1, ProjectZero.fibonacci(1));
        System.assertEquals(-1, ProjectZero.Fibonacci(-2));
        System.assertEquals(2, ProjectZero.Fibonacci(3));
        System.assertEquals(89, ProjectZero.Fibonacci(11));
        System.assertEquals(6765, ProjectZero.Fibonacci(20));
        System.assertEquals(196418, ProjectZero.Fibonacci(27));
        
        // single action - negative
    }
    
    @isTest static void testSortArray() {
        // single action - positive
        List<Integer> unsortedArray = new List<Integer>{2,4,5,1,3,1};
        List<Integer> sortedArray = new List<Integer>{1,1,2,3,4,5};
        List<Integer> returnedArray = ProjectZero.sortArray(unsortedArray);
        
        for (Integer i = 0; i < sortedArray.size(); i++) {
            System.assertEquals(sortedArray[i], returnedArray[i]);
        }
        
        // single action - negative
    }
    
    @isTest static void testFactorial() {
        // single action - positive
        System.assertEquals(1, ProjectZero.factorial(0));
        System.assertEquals(1, ProjectZero.factorial(1));
        System.assertEquals(2, ProjectZero.factorial(2));
        System.assertEquals(6, ProjectZero.factorial(3));
        System.assertEquals(24, ProjectZero.factorial(4));
        
        // single action - negative
        System.assertEquals(0, ProjectZero.factorial(-1));

    }
    
    @isTest static void testRotateLeft() {
        // single action - positive
        List<Integer> unrotatedArray = new List<Integer>{1,2,3,4,5};
        List<Integer> rotatedArray = new List<Integer>{3,4,5,1,2};
        List<Integer> returnedArray = ProjectZero.rotateLeft(unrotatedArray, 2);
        
        for (Integer i = 0; i < rotatedArray.size(); i++) {
            System.assertEquals(rotatedArray[i], returnedArray[i]);
        }
        
    }
    
    @isTest static void testBalancedBrackets() {
        System.assertEquals(true, ProjectZero.balancedBrackets('()()'));
        System.assertEquals(false, ProjectZero.balancedBrackets('(((('));
    }
    
    @isTest static void testUpdateAccountSize() {
        List<Account> accountToInsert = new List<Account>();
        accountToInsert.add(new Account(Name='Test12345', NumberOfEmployees=1));
        accountToInsert.add(new Account(Name='Test1234567', NumberOfEmployees=1001));
        accountToInsert.add(new Account(Name='Test123456789', NumberOfEmployees=10001));
        insert accountToInsert;
        ProjectZero.updateAccountSize();
        
        Account a1 = [Select Size__c FROM Account WHERE Name='Test12345' LIMIT 1];
        System.assertEquals('small', a1.Size__c);
        Account a2 = [Select Size__c FROM Account WHERE Name='Test1234567' LIMIT 1];
        System.assertEquals('medium', a2.Size__c);
        Account a3 = [Select Size__c FROM Account WHERE Name='Test123456789' LIMIT 1];
        System.assertEquals('large', a3.Size__c);
        
        // bulk
        List<Account> accs = [SELECT NumberOfEmployees, Size__c FROM Account WHERE Name LIKE 'Test%'];
        for (Account a : accs) {
            if (a.NumberOfEMployees <= 1000) {
                System.assertEquals('small', a.Size__c);
            } else if (a.NumberOfEmployees <= 10000) {
                System.assertEquals('medium', a.Size__c);
            } else {
                System.assertEquals('large', a.Size__c);
            }
        }
    }
    
    @isTest static void testUpdateCALeads() {
        List<Lead> leadsToInsert = new List<Lead>();
        leadsToInsert.add(new Lead(LastName='Test123', State='CA', Company='123'));
        leadsToInsert.add(new Lead(LastName='Test12345', State='CA', Company='123'));
        leadsToInsert.add(new Lead(LastName='Test1234567', State='CA', Company='123'));
        insert leadsToInsert;
        
        ProjectZero.updateCALeads();
        List<Lead> ls = [SELECT Status, Description FROM Lead];
        for (Lead l : ls) {
            System.assertEquals('Closed - Not Converted', l.Status);
            System.assertEquals('We are no longer doing business in California.', l.Description);
        }
    }

}