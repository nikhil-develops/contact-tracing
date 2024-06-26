public with sharing class CTLocationController {
    public static List<Location__c> getRecentStatusChanges(){
    String location='SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c Order By Status_Update_Date__c Desc NULLS LAST Limit 100';
    return Database.query(location);
 }  
  public static List<Location__c> searchLocation(String searchTerm){
    searchTerm=searchTerm+'%';
    String location='SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c where Pincode__c like :searchTerm OR Address__c like :searchTerm OR Name like :searchTerm Order By Status_Update_Date__c Desc NULLS LAST';
    List<Location__c> allLocations = Database.query(location);
    return allLocations;
   }
   public static Location__c getLocationById(Id locationId){
    String location='SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c where Id=:locationId';
    List<Location__c> locations = Database.query(location);
    if(locations!=null && locations.size()>0){
    return locations[0];
    }
    return null;
   }
    /**
    * returs Map<String,Integer>
    */
   public static Map<String,Integer> getStatusCount(){
     Map<String,Integer> locationMap=new Map<String,Integer>();
    String soql='SELECT Status__c, count(Id)locationCount  FROM Location__c GROUP BY Status__c';
     List<AggregateResult> locationCount= Database.query(soql);
     for(AggregateResult location:locationCount){
          locationMap.put((String) location.get('Status__c'),(Integer) location.get('locationCount'));
     }
     return locationMap;
   }
}