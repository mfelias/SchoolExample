public class DuplicateChecker {
    public static void checkForContactDuplicates(List<Contact> newContacts) {
        // Step 1: Extract email from new contacts
        Set<String> newEmailSet = new Set<String>();
        for (Contact newContact : newContacts) {
            if (newContact.email != null) {
                newEmailSet.add(newContact.email);
            }
        }
        
        // Step 2: Find duplicate contacts from database
        Map<String, Contact> existingContactMap = new Map<String, Contact>();
        for (Contact existingContact: [SELECT ID, Name, Email FROM Contact WHERE Email in :newEmailSet]) {
			existingContactMap.put(existingContact.email, existingContact);
        }
        
        // Step 3: compare and throw error
        for(Contact newContact : newContacts) {
            Contact duplicateContact = existingContactMap.get(newContact.email);
            if (duplicateContact != null) {
                newContact.addError('ERROR: There is already an Identical Record: ');
            }
        }
    } // end Contact Duplicate Check
    
    public static void checkForCEDuplicates(List<ClassEnrollment__c> newCEs) {
        
    }
}