trigger Ass10 on Onboarding_Step__c (after update) {

    Set<Id> accountIds = new Set<Id>();

    for (Onboarding_Step__c step : Trigger.new) {
        Onboarding_Step__c oldStep = Trigger.oldMap.get(step.Id);

        if (step.Status__c == 'Completed' &&
            oldStep.Status__c != 'Completed' &&
            step.Account__c != null) {

            accountIds.add(step.Account__c);
        }
    }

    if (accountIds.isEmpty()) return;

    List<Account> accountsToUpdate = new List<Account>();

    for (Id accId : accountIds) {

        Integer totalSteps = [
            SELECT COUNT()
            FROM Onboarding_Step__c
            WHERE Account__c = :accId
        ];

        Integer completedSteps = [
            SELECT COUNT()
            FROM Onboarding_Step__c
            WHERE Account__c = :accId
            AND Status__c = 'Completed'
        ];

        if (totalSteps > 0 && totalSteps == completedSteps) {
            accountsToUpdate.add(new Account( Id = accId, Onboarding_Status__c = 'Completed'
            ));
        }
    }

    update accountsToUpdate;
}