trigger ContactTrigger on Contact (before insert, after insert) { // can indicate multiple "listening states" (before insert, after insert, etc.)
	
    if (Trigger.isAfter && Trigger.isInsert) {
    	PostToChatterContact.postChatterContact(Trigger.new);
    } else if (Trigger.isBefore && Trigger.isInsert) {
        DuplicateChecker.checkForContactDuplicates(Trigger.new);
    }
    
    /* Alternate structure
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            //do stuff
        }
    } else {
        if (Trigger.isInsert) {
            PostToChatterContact.postChatterContact(Trigger.new);
        }
    }*/
    
}