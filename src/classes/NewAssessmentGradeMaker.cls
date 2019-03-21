public class NewAssessmentGradeMaker {
    public static void makeNewGrades(List<Assessment__c> newAssessments) {
        // list of class IDs associated with the new assessments
        Set<ID> classIDs = new Set<ID>();
        for (Assessment__c a : newAssessments) {
            classIDs.add(a.Class__c);
        }
        // want the list of CE that connect to the class that the assessment is attached to
        // make a new grade for each CE that is associated with the class that the new assessment is attached to
        List<ClassEnrollment__c> classEnrollmentSet = [SELECT ID, Class__c FROM ClassEnrollment__c WHERE Class__c in :classIDs];
        for (ClassEnrollment__c CE : classEnrollmentSet) {
            
        }
    }
}