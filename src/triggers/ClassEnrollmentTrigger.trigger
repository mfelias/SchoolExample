trigger ClassEnrollmentTrigger on ClassEnrollment__c (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        NewCEGradeChecker.createNewGradesForNewCE(Trigger.new);
    }
}