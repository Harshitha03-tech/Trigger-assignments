trigger Ass5 on Contact (before insert) {
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : Trigger.new) {
            if (con.Billing_Contact__c == true && con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        Map<Id, Contact> existingBillingContacts = new Map<Id, Contact>();
        if (!accountIds.isEmpty()) {
            for (Contact c : [
                SELECT Id, AccountId
                FROM Contact
                WHERE Billing_Contact__c = true
                AND AccountId IN :accountIds
            ]) {
                existingBillingContacts.put(c.AccountId, c);
            }
        }
    
        for (Contact con : Trigger.new) {
            if (con.Billing_Contact__c == true 
                && con.AccountId != null
                && existingBillingContacts.containsKey(con.AccountId)) {
    
                con.addError('Only one Billing Contact is allowed per Account.');
            }
        }
    }