public with sharing class CTPersonController {
   public static String getToken(String mobile){
    Blob mobileBlob = Blob.valueOf(mobile);
    Blob hashMobile= Crypto.generateDigest('MD5',mobileBlob);
    return EncodingUtil.base64Encode(hashMobile);
   }
   
   public static List<Person__c> getRecentHealthChanges(){
        String soql = 'SELECT Id,Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c Order by Status_Update_Date__c  NULLS LAST Limit 100';
        List<Person__c> allPerson = Database.query(soql);
        return allPerson;
   }
   public static List<Person__c> searchPeople(String searchTerm){
      searchTerm=searchTerm+'%';
        String soql = 'SELECT Id,Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c where Name Like :searchTerm OR Mobile__c Like :searchTerm OR Token__c Like :searchTerm Order by Status_Update_Date__c  NULLS LAST';
        List<Person__c> allPerson = Database.query(soql);
        return allPerson;
   }
   public static Person__c getPersonById(Id Id){
        String soql = 'SELECT Id,Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c where Id=:Id';
        List<Person__c> person = Database.query(soql);
        if(person !=null && person.size()>0){
         return person[0];
        }
        return null;
   }
}