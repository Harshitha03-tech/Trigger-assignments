trigger Ass6 on Contact (after insert, after update, after delete) 
{
set<Id>accountIds=new set<Id>();
    if(trigger.isinsert || trigger.isupdate){
        for(contact con:trigger.new){
            if(con.AccountId!=null){
                accountIds.add(con.Accountid);
            }
        }
    }
    if(trigger.isdelete){
        for(contact con:trigger.old){
            if(con.AccountId!=null) {
                accountIds.add(con.Accountid);
            }
        }
    }
     if (!accountIds.isEmpty()) {
        Ass6Helper.updateCount(accountIds);
}
}