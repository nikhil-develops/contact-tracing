public with sharing class ContactTriggerHelper {
    
    /**
     * this variable is to set flag that trigger has been executed once to avoid trigger deadlock
     */
    public static boolean alreadyUpdated=false;

    /**
     * updates active contacts count in the account object
     */
    public static void updateContactActiveCount(List<Contact> triggeredCon,boolean isDelete ){
        
        List<Id> contactIds= new List<Id>();
        for (Contact con:triggeredCon){
            contactIds.add(con.Id);
        }
        Map <Id,Decimal> updateAccount=new Map <Id,Decimal>();
        List<Contact> updateContact =[SELECT FirstName,Active__c,AccountId, Account.Active_Contacts__c From Contact where Id IN :contactIds];
        Decimal count;
        for(Contact updateCon:updateContact ){
            if(isDelete){ 
                if(updateAccount.get(updateCon.AccountId)==null){
                    count=updateCon.Account.Active_Contacts__c==null?0:updateCon.Account.Active_Contacts__c;
                    updateAccount.put(updateCon.AccountId,Count);
                }else{
                    count=updateAccount.get(updateCon.AccountId);
                }
                if(count>0){
                    updateAccount.put(updateCon.AccountId,Count-1);
                }
            }else{
                if((boolean)updateCon.Active__c){
                    if(updateAccount.get(updateCon.AccountId)==null){
                        count=updateCon.Account.Active_Contacts__c==null?0:updateCon.Account.Active_Contacts__c;
                        updateAccount.put(updateCon.AccountId,Count);
                    }else{
                        count=updateAccount.get(updateCon.AccountId);
                    }
                    updateAccount.put(updateCon.AccountId,Count+1);
                }else{
                    if(updateAccount.get(updateCon.AccountId)==null){
                        count=updateCon.Account.Active_Contacts__c==null?0:updateCon.Account.Active_Contacts__c;
                        updateAccount.put(updateCon.AccountId,Count);
                    }else{
                        count=updateAccount.get(updateCon.AccountId);
                    }
                    if(count>0){
                        updateAccount.put(updateCon.AccountId,Count-1);
                    }
                }
            }
        }
        List <Account> existingAcc=[SELECT Id,Name,Active_Contacts__c FROM Account where Id In :updateAccount.keySet()];
        for (Account accUpdate:existingAcc){
            accUpdate.Active_Contacts__c=(Integer) updateAccount.get(accUpdate.Id);
        }
        Update existingAcc;    
    }
}