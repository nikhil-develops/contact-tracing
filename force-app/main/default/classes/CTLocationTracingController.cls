/**
 * return List<Location_Tracing__c>
 * This function returns list of Location_Tracing__c object on the basis of location id
 */
public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Location__c=:locationId Order By Visit_Date__c Desc';
        return Database.query(soql);
    }
    /**
     * returns list of Location_Tracing__c Object on the basis of personIds
     * Gives records of last 10 days
     */
    public static List<Location_Tracing__c> getLocationByPersonIds(Set<Id> personIds){
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Person__c IN :personIds AND Visit_Date__c=LAST_N_DAYS:10';
        return Database.query(soql);
    }
    public static List<Location_Tracing__c> getLocationByLocationIds(Set<Id> locationIds){
        String status='Green';
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Location__r.Status__c=:status AND Location__c IN :locationIds AND Visit_Date__c=LAST_N_DAYS:10';
        return Database.query(soql);
    }
    /**
     * returns duplicate items in the list that are already existing in the Location_Tracing__c object
     * 
     */
    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> locationTraces){
        Set<Id> locationIds = new Set<Id>();
        Set<Id> personIds= new Set<Id>();

        for(Location_Tracing__c trace:locationTraces){
            locationIds.add(trace.Location__c);
            personIds.add(trace.Person__c);
        }
        String soql='SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c where Person__c IN :personIds AND Location__c IN :locationIds';
        List<Location_Tracing__c> existingTraces =Database.query(soql);
        Map<Id,Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();
        if(existingTraces!=null && existingTraces.size()>0)
        for(Location_Tracing__c trace:existingTraces){
            if(!mapOfExistingRecords.containsKey(trace.Location__c)){
                mapOfExistingRecords.put(trace.Location__c,new Set<Id>());
            }
            mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
        }
        List <Location_Tracing__c> duplicateTraces=new List<Location_Tracing__c>();

        for(Location_Tracing__c trace:locationTraces ){
            if((mapOfExistingRecords.containsKey(trace.Location__c)) && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c) ){
                duplicateTraces.add(trace);
            }
        }
        return duplicateTraces;
    }
}