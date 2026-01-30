trigger Ass18 on Contact (before update) {

    for (Contact con : Trigger.new) {

        Contact oldCon = Trigger.oldMap.get(con.Id);

        if (con.AccountId != oldCon.AccountId && con.AccountId != null) {
            Account acc = [
                SELECT Onboarding_Status__c
                FROM Account
                WHERE Id = :con.AccountId
            ];

            if (acc.Onboarding_Status__c == 'Completed') {
                con.Is_Onboarding_Point_of_Contact__c = false;
            }
        }
    }
}