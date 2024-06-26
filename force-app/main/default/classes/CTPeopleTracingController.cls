public with sharing class CTPeopleTracingController {

    public static List<People_Tracing__c> getTraces(String recordId){
      String soql ='SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c FROM People_Tracing__c where Id=:recordId';
      return Database.query(soql);
    }
 public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces){
        Set<Id> person1Ids = new Set<Id>();
        Set<Id> person2Ids= new Set<Id>();

        for(People_Tracing__c trace:peopleTraces){
            person1Ids.add(trace.Person_1__c);
            person2Ids.add(trace.Person_2__c);
        }
        String soql ='SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c FROM People_Tracing__c where Person_1__c IN :person1Ids AND Person_2__c IN :person2Ids';
        List<People_Tracing__c> existingTraces =Database.query(soql);
        Map<Id,Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();
        if(existingTraces!=null && existingTraces.size()>0)
        for(People_Tracing__c trace:existingTraces){
            if(!mapOfExistingRecords.containsKey(trace.Person_1__c)){
                mapOfExistingRecords.put(trace.Person_1__c,new Set<Id>());
            }
            mapOfExistingRecords.get(trace.Person_1__c).add(trace.Person_2__c);
        }
        List <People_Tracing__c> duplicateTraces=new List<People_Tracing__c>();

        for(People_Tracing__c trace:peopleTraces){
            if((mapOfExistingRecords.containsKey(trace.Person_1__c)) && mapOfExistingRecords.get(trace.Person_1__c).contains(trace.Person_2__c) ){
                duplicateTraces.add(trace);
            }
        }
        return duplicateTraces;
    }
}