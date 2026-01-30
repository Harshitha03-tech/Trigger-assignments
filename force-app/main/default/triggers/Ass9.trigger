trigger Ass9 on Onboarding_Step__c (after insert,after update,after delete)
{

    Set<Id> accountIds = new Set<Id>();

    for (Onboarding_Step__c step : Trigger.isDelete ? Trigger.old : Trigger.new) {
        if (step.Account__c != null) {
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

        accountsToUpdate.add(new Account(
            Id = accId,
            Onboarding_Step_Count__c = totalSteps,
            Completed_Steps__c = completedSteps
        ));
    }

    update accountsToUpdate;
}