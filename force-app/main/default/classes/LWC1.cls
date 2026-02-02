public class LWC1 {
@AuraEnabled(cacheable=true)
    public static List<Onboarding_Step__c> getSteps(Id accountId) {

        return [
            SELECT Id, Name, Completed__c
            FROM Onboarding_Step__c
            WHERE Account__c = :accountId
            ORDER BY CreatedDate ASC
        ];
    }
}