trigger Ass4 on Contact (after insert) {
    list<task> tasklist=new  list<task> ();
    for(Contact con:Trigger.new){
        if(con.AccountId!=null){
            Account acc=[select Id,Type from account where Id=:con.AccountId limit 1];
            if (acc.Type=='Customer - Direct' || acc.Type=='Customer - Channel'){
                task t =new task();
                t.subject='welcome call';
                t.OwnerId=con.OwnerId;
                t.WhoId=con.Id;
                t.ActivityDate = Date.today().addDays(3);
                tasklist.add(t);
            }
            if(!tasklist.isempty()){
                insert tasklist;
            }
        }
    }

}