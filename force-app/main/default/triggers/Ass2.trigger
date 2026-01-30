trigger Ass2 on Account (after insert) {
    
        Account_Config__c config =
            Account_Config__c.getValues('Default');
    
        if (config == null || String.isBlank(config.Default_Segment__c)) {
            return;
        }
        List<Account> accountsToUpdate = new List<Account>();
    
        for (Account acc : Trigger.new) {
    
            if (String.isBlank(acc.Customer_Segment__c)) {
    
                acc.Customer_Segment__c = config.Default_Segment__c;
                accountsToUpdate.add(acc);
            }
        }
    
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        }