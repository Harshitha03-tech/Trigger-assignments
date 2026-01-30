trigger Ass17 on Account (before delete) {

    for (Account acc : Trigger.old) {

        Integer stepCount = [
            SELECT COUNT()
            FROM Onboarding_Step__c
            WHERE Account__c = :acc.Id
            AND Status__c = 'In Progress'
        ];

        if (stepCount > 0) {
            acc.addError(
                'Cannot delete Account while onboarding steps are in progress.'
            );
        }
    }
}