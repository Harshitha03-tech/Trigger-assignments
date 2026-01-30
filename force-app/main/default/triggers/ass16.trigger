trigger ass16 on Onboarding_Step__c (after update) {

    Set<Id> accIds = new Set<Id>();

    // collect Accounts where status changed to Completed
    for (Onboarding_Step__c stepRec : Trigger.new) {
        Onboarding_Step__c oldRec = Trigger.oldMap.get(stepRec.Id);

        if (stepRec.Account__c != null &&
            oldRec.Status__c!= 'Completed' &&
            stepRec.Status__c == 'Completed') {

            accIds.add(stepRec.Account__c);
        }
    }

    if (accIds.isEmpty()) return;

    // update Account date
    List<Account> accList = new List<Account>();
    for (Id accId : accIds) {
        accList.add(new Account(
            Id = accId,
            Last_Onboarding_Completed_Date__c= Date.today()
        ));
    }

    update accList;
}