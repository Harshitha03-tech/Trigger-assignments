trigger ass14 on Onboarding_Step__c (before insert, before update) {
    OnboardingValidationService14.validate(Trigger.new);
}