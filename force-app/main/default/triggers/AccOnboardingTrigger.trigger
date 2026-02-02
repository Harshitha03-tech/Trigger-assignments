trigger AccOnboardingTrigger on Account (after insert) 
{
    list<Onboarding_Case__c> lstOncase = new list<Onboarding_Case__c>();
    if (Trigger.isafter && Trigger.isinsert)
    {

            for(Account Acc : Trigger.new)
            {
                if(Acc.Type=='Customer - Direct' || Acc.Type=='Customer - Channel')
                {
                    	Onboarding_Case__c Oncase=new Onboarding_Case__c();
                      	Oncase.Status__c='New' ;
                        Oncase.Name=Acc.name;
                        oncase.Account__c= Acc.Id;
                        lstOncase.add(Oncase);
                }
            }


        insert lstOncase;
}
}
/*trigger Accountonboard on Account (after insert) {
    if(Trigger.isafter && Trigger.isinsert){
      List<on_boarding_case__c> acclst = new List<on_boarding_case__c>();
        for(account acc : Trigger.new){
            if(acc.Type == 'customer - Direct' && acc.){
               on_boarding_case__c bc = new on_boarding_case__c();
               bc.Account__c = acc.Id;
               acclst.add(bc);
}
}
insert acclst;
 gi
}
 
}*/