trigger Ass11 on Account (before update) {

    Onboarding_Policy__c policy = Onboarding_Policy__c.getInstance();

    if (policy == null || policy.Max_Open_Onboarding__c == null) {
        return;
    }

    Integer maxAllowed = Integer.valueOf(policy.Max_Open_Onboarding__c);

    for (Account acc : Trigger.new) {

        Account oldAcc = Trigger.oldMap.get(acc.Id);

        if (acc.OwnerId != oldAcc.OwnerId &&
            acc.Onboarding_Status__c == 'Open') {

            Integer openCount = [
                SELECT COUNT()
                FROM Account
                WHERE OwnerId = :acc.OwnerId
                AND Onboarding_Status__c = 'Open'
            ];

            if (openCount >= maxAllowed) {
                acc.addError(
                    'This owner already has the maximum allowed open onboarding accounts.'
                );
            }
        }
    }
}