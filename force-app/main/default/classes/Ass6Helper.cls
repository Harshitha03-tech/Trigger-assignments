public class Ass6Helper{
    public static void updateCount(Set<Id> accountIds) {

        Map<Id, Integer> accCountMap = new Map<Id, Integer>();

        // Count active contacts using aggregate SOQL
        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) total
            FROM Contact
            WHERE account.Active__c= 'yes'
            AND AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('total')
            );
        }

        // Update Accounts
        List<Account> accList = new List<Account>();
        for (Id accId : accountIds) {
            accList.add(new Account(
                Id = accId,
               No_Of_Contacts__c = accCountMap.containsKey(accId)
                    ? accCountMap.get(accId)
                    : 0
            ));
        }

        update accList;
    }
}