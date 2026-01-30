trigger Ass12 on Account (after insert, after update) {

    List<Account> vipAccounts = new List<Account>();

    for (Account acc : Trigger.new) {
        if (acc.VIP__c == true) {

            if (Trigger.isInsert ||
                (Trigger.isUpdate && Trigger.oldMap.get(acc.Id).VIP__c == false)) {
                vipAccounts.add(acc);
            }
        }
    }

    if (vipAccounts.isEmpty()) return;

    Id accountDirectorRoleId = [
        SELECT Id FROM UserRole
        WHERE Name = 'Account Director'
        LIMIT 1
    ].Id;


    List<AccountShare> shares = new List<AccountShare>();

    for (Account acc : vipAccounts) {
        AccountShare accShare = new AccountShare();
        accShare.AccountId = acc.Id;
        accShare.UserOrGroupId = accountDirectorRoleId;
        accShare.AccountAccessLevel = 'Read'; // or 'Edit'
        accShare.RowCause = Schema.AccountShare.RowCause.Manual;

        shares.add(accShare);
    }

    insert shares;
}