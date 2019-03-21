public class DMLExamples {
    public static void insertAndUpdateExample() {
        List<Account> accountsToInsert = new List<Account>();
        
        // Create 3 Account sObjects and add to List
        // We DO NOT want to perform DML on individual sObjects/records
        // so we add to a list
        for (Integer i = 0; i < 3; i++) {
            Account a = new Account(Name='Wal-Mart' + i, BillingCity='San Francisco');
            accountsToInsert.add(a);
        }
        
        Account accountToUpdate;
        try {
            insert accountsToInsert;
            
            // Update account Wal-Mart2
            // must first retrieve account
            accountToUpdate = [SELECT BillingCity FROM Account WHERE Name='Wal-Mart2' LIMIT 1];
            
            System.debug('Wal-Mart2: ' + accountToUpdate);
            // Update the BillingCity
            accountToUpdate.BillingCity = 'New York';
            
            update accountToUpdate;
            
        } catch(DMLException e) {
            System.debug('An Unexpected error has occurred: ' + e.getMessage());
        }
        
        System.debug('Wal-Mart2: ' + accountToUpdate);
    }
    
    /*
     * You can insert records related to existing records if a relationship has already been defined between the 2 objects
     * A record is associated with a related record through a foreign key ID
     * 
     * This example adds a Contact to an Account (the related record) by setting the AccountID field on the contact
     * */
    
    public static void insertingRelatedRecords() {
        try{
            // has no ID before insertion
            Account a = new Account(Name='SFDC Account');
            // ID is autopopulated upon insertion
            insert a;
            // fetch the new ID
            ID aID = a.Id;
            // add a contact to this account
            // create new contact with associated AccountID
            Contact c = new Contact(FirstName='Matt', LastName='Elias', Phone='5611234567', AccountID=aID);
            // insert new contact
            insert c;
        } catch(DMLException e) {
            System.debug('An Unexpected error has occurred: ' + e.getMessage());
        }
    }
    
    public static void insertSchoolRecords(String recordTypeName){
        try {
            
            Class__c c = new Class__c(Name='Advanced Variables', ClassSubject__c='Math', ClassTopic__c='Algebra');
            insert c;
            //ID cID = c.ID;
            
            System.debug('Class successfully created.');
            
            //RecordType rt = [SELECT ID, Name FROM RecordType WHERE sObjectType='Assessment__c' AND Name LIKE 'Project'];
            
            List<RecordType> recordTypeList = new List<RecordType>();
            recordTypeList = [SELECT ID, Name FROM RecordType WHERE sObjectType='Assessment__c'];
            
            
            Map<String, ID> recordTypeIDs = new Map<String, ID>();
            for (RecordType rt : recordTypeList) {
                recordTypeIDs.put(rt.Name, rt.ID);
            }
			
            
            Assessment__c a = new Assessment__c(RecordTypeID=recordTypeIDs.get(recordTypeName), Name='P7', Class__c=c.ID);
            insert a;
            //ID aID = a.ID;
            
            System.debug('Assessment successfully created.');
            
            Grade__c g = new Grade__c(Assessment__c=a.ID, Grade__c=90);
            insert g;
            
            System.debug('Grade successfully created.');
            
            Student__c s = new Student__c(Name='Marcus Fuller');
            insert s;
            //ID sID = s.ID;
            
            System.debug('Student successfully created.');
            
            ClassEnrollment__c e = new ClassEnrollment__c(Student__c=s.ID, Class__c=c.ID);
            insert e;
            
            System.debug('Class Enrollment successfully created.');
            
        } catch(DMLException e) {
            System.debug('An Unexpected error has occurred: ' + e.getMessage());
        }
    }
    
    public static void updatingRelatedRecords() {
        try {
            // Query for contact which has been associated with an account
            Contact queriedContact = [SELECT Phone, Account.Industry FROM Contact WHERE FirstName='Matt' AND LastName='Ruiz' LIMIT 1];
            
            // Update the contact's phone number
            queriedContact.Phone = '9871238576';
            
            // Update the related account industry
            queriedContact.Account.Industry = 'Technology';
            
            // Make 2 separate calls 
            // 1. to update Contact phone number
            update queriedContact;
            // 2. to update the related account's industry field
            update queriedContact.Account;
            
        } catch (DMLException e) {
            System.debug('An unexpected error occured: ' + e.getMessage());
        }
    }
    
    /*
     * using the upsert operation you can either insert or update an existing record in one call
     * to determine whether a record already exists, the upsert statement or database method uses the record's ID as the key to match records
     * 	a custom external ID, or a standard field with the idLookup attribute set to true
     * 
     * 	if the key is not matched, then a new record is created
     * 	if the key is matched once, then the existing record is updated
     *  if the key is matched multiple times, then an error is generated and the object in neither inserted or updated
     */
    public static void upsertExample() {
        List<Account> accountList = [SELECT BillingCity FROM Account WHERE BillingCity='San Francisco'];
        
        for (Account a : accountList) {
            a.BillingCity = 'Mumbai';
        }
        
        Account a = new Account(Name='ACME', BillingCity='San Francisco');
        accountList.add(a);
        
        try {
			upsert accountList;
        } catch (DMLException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    } //end upsertExample()
    
    /* ONLY AVAILABLE FOR LEAD, CONTACT, OR ACCOUNT RECORDS
     * you can merge up to 3 records of the same sObject type
     * the merge operation merges up to 3 records into one of the records, deletes the others, and reparents any related records
     */
    
    public static void mergeExample() {
        // insert new accounts
        List<Account> ls = new List<Account> {new Account(Name='Dunkin Inc.'),
            new Account(Name='Dunkin')};
        insert ls;
        
        // Queries to get the inserted accounts
        Account masterAccount = [SELECT ID, Name FROM Account WHERE Name='Dunkin Inc.'];
        Account mergeAccount = [SELECT ID, Name FROM Account WHERE Name='Dunkin'];
        
        // Add a contact to the account to be merged
        Contact c = new Contact(FirstName='Matt', LastName='Merger');
        c.AccountID = mergeAccount.ID;
        insert c;
        
        Account[] result = [SELECT ID, Name FROM Account WHERE Name LIKE '%Dunkin%'];
        System.debug('Before merge: ' + result);
        
        try {
            merge masterAccount mergeAccount;
        } catch (DMLException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        Account[] res = [SELECT ID, Name FROM Account WHERE Name LIKE '%Dunkin%'];
        System.debug('Before merge: ' + res);

    } // end mergeExample()
    
    /* you can delete records using the delete operation
     * Deleted records aren't deleted permanently from Salesforce, 
     * 		but they are placed in the recycling bin for 14.5 days from which they can be restored
     */
    
    public static void deleteExample() {
        insert new Account(Name='DotCom');
        Account[] doomedAccounts = [SELECT Name FROM Account WHERE Name='DotCom'];
        System.debug('Doomed Accounts: ' + doomedAccounts);
        
        try {
            delete doomedAccounts;
        } catch (DMLException e) {
            System.debug('Something unexpected happend: ' + e.getMessage());
        }
        
        System.debug('Invincible Accounts: ' + [SELECT Name FROM Account WHERE Name='DotCom']);
    } // end deleteExample()
    
    public static void undeleteExample() {
        // the ALL ROWS keyword queries all records in an organization, even those in the recycling bin and archive
        // 		cannot be used with the FOR UPDATE keyword
    	Account[] savedAccounts = [SELECT Name FROM Account WHERE Name='DotCom' ALL ROWS];
        System.debug('Saved Accounts: ' + savedAccounts);
        
        try {
            undelete savedAccounts;
        } catch (DMLException e) {
            System.debug('Something unexpected happend: ' + e.getMessage());
        }
        
        System.debug('Saved Accounts: ' + [SELECT Name FROM Account WHERE Name='DotCom']);
       

    } //end undeleteExample()
    
    public static void queryForLoop() {
        List<Account> accountList = [SELECT Id, Name FROM Account LIMIT 5];
        
        for (Account a: accountList){
            System.debug('a: ' + a);
        }
        
        // If we don't need to save the list and reference it later, don't save it at all!
        for (Account a: [SELECT Id, Name FROM Account LIMIT 5]) {
            System.debug('a: ' + a);
        }
            
    } // end queryForLoop()
    
    public static void badPractices() {
        // this counts as 100 DML statements. you're allowed 150 in one transaction
        for (Integer i = 0; i < 100; i++) {
            Account a = new Account(Name='Account' + i);
            insert a;
        }
        
        // INSTEAD do:
        Account[] accList = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            Account a = new Account(Name='Account' + i);
            accList.add(a);
        }
        insert accList;
        
        // instantiating the list in the loop is bad
        for (Integer i = 0; i < 100; i++) {
            Account[] ls = [SELECT ID, Name FROM Account];
        }
        
        // instead:
        for (Account a : [SELECT ID, Name FROM Account]) {
            //do stuff
        }
    } // end badPractices
    
    public static void databaseClass() {
        List<Account> accList = new List<Account>();
        accList.add(new Account(Name='Acme1'));
        accList.add(new Account(Name='Acme2'));
        accList.add(new Account(Name='Acme1'));
        
        // DML statement using database class
        Database.SaveResult[] srList = Database.insert(accList, false);
        
        // iterate through each returned result
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted account. Account ID: ' + sr.getID());
            } else {
                // Operation failed
                for (Database.Error err: sr.getErrors()) {
                    System.debug('The following error has occurred:');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Accounts fields that affected this error: ' + err.getFields());
                }
            }
        }
    } // end databaseClass
}