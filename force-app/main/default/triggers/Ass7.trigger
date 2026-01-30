trigger Ass7 on Account (after update) {
    list<Account_segment_History__c> historyRecords=new list<Account_segment_History__c> ();
    for(Account acc:Trigger.new){
        Account oldAcc=Trigger.oldMap.get(acc.Id);
        if(acc.Customer_segment__c!= oldAcc.Customer_segment__c){
            Account_segment_History__c AccsegHist=new Account_segment_History__c();
            AccsegHist.Account__c = acc.Id;
             AccsegHist.Old_Segment__c = oldAcc.Customer_segment__c;
             AccsegHist.New_Segment__c = acc.Customer_segment__c;
             historyRecords.add(AccsegHist);
            
        }
    }
     if (!historyRecords.isEmpty()) {
        insert historyRecords;
    }
}