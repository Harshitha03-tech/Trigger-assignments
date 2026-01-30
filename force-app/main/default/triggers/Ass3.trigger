trigger Ass3 on Account (before update) {

    for (Account acc : Trigger.new) {

        Account oldAcc = Trigger.oldMap.get(acc.Id);

        if (acc.Onboarding_Status__c == 'Completed' &&
            oldAcc.Onboarding_Status__c != 'Completed') {

            if (String.isBlank(acc.kyc__c)) {

                acc.Onboarding_Status__c.addError('You cannot complete onboarding without KYC details.'  );
            }
        }
    }
}