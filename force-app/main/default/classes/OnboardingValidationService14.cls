public with sharing class OnboardingValidationService14 {
    public static void validate(List<Onboarding_Step__c> steps) {

        // Read hierarchy custom setting (Org/User/Profile based)
        Onboarding_Policies__c policy =Onboarding_Policies__c.getInstance();

        for (Onboarding_Step__c s : steps) {

            // policy: email is mandatory
            if (policy.Require_Email__c == true && String.isBlank(s.Email__c)) {
                s.Email__c.addError('Email is required as per onboarding policy.');
            }

            // policy: phone is mandatory
            if (policy.Require_Phone__c == true && String.isBlank(s.Phone__c)) {
                s.Phone__c.addError('Phone is required as per onboarding policy.');
            }
        }
    }
}