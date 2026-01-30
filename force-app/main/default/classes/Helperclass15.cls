public without sharing class Helperclass15 {

    public static void updateRisk(Set<Id> accIds) {

        // Get credit scores for those accounts
        List<Credit__c> profiles = [
            SELECT Account__c, Credit_Score__c
            FROM Credit__c
            WHERE Account__c IN :accIds
        ];

        List<Account> accToUpdate = new List<Account>();

        for (Credit__c p : profiles) {
            String risk = 'High';

            if (p.Credit_Score__c >= 750) risk = 'Low';
            else if (p.Credit_Score__c >= 650) risk = 'Medium';

            accToUpdate.add(new Account(
                Id = p.Account__c,
                Risk_Level_c__c = risk
            ));
        }

        if (!accToUpdate.isEmpty()) update accToUpdate;
    }
}