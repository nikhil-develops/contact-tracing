/**
 * Problem to show active conatct count in the account object in active contact field using trigger.
 */
trigger ContactObjTrigger on Contact (after Insert, after Update,before update,after Delete,after undelete) {
    List<Contact> triggeredCon=new List<Contact>();
    if(Trigger.isDelete){
        triggeredCon= Trigger.old;
    }else{
        triggeredCon= Trigger.new;
    }
    if(!ContactTriggerHelper.alreadyUpdated){
        ContactTriggerHelper.alreadyUpdated=true;
        ContactTriggerHelper.updateContactActiveCount(triggeredCon,Trigger.isDelete);
    }
   
}