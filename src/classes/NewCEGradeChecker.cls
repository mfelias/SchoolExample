public class NewCEGradeChecker {
    public static void createNewGradesForNewCE(List<ClassEnrollment__c> newCEs) {
        List<ID> classIDs = new List<ID>();
        for(ClassEnrollment__c ce : newCEs) {
            classIDs.add(ce.Class__c);
        }
        
        List<Grade__c> gradesToInsert = new List<Grade__c>();
        for (Assessment__c assmt : [SELECT ID, Class__c FROM Assessment__c WHERE Class__c IN :classIDs]) {
            for (ClassEnrollment__c ce : newCEs) {
                if (ce.Class__c == assmt.Class__c) {
                    Grade__c g = new Grade__c();
                    g.Assessment__c = assmt.ID;
                    g.ClassEnrollment__c = ce.ID;
                    gradesToInsert.add(g);
                }
            }
        }
        insert gradesToInsert;
    }
}