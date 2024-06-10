public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c Order By Visit_Date__c Desc';
        return Database.query(soql);
    }
    
    public static List<Location_Tracing__c> getLocationByPersonIds(Set<Id> personIds){
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Person__c IN :personIds AND Visit_Date__c=LAST_N_DAYS:10';
        return Database.query(soql);
    }
    public static List<Location_Tracing__c> getLocationByLocationIds(Set<Id> locationIds){
        String status='Green';
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Location__r.Status__c=:status AND Location__c IN :locationIds AND Visit_Date__c=LAST_N_DAYS:10';
        return Database.query(soql);
    }
}