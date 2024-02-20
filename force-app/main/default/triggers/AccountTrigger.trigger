trigger AccountTrigger on Account (before insert , after insert , before update) {
    
    //Before Insert
    if(trigger.IsBefore && trigger.IsInsert){
         AccountTriggerHandler.handleBeforeInsert(trigger.new);
    }
    //After Insert
    if(trigger.IsAfter && trigger.IsInsert){
        AccountTriggerHandler.handleAfterInsert(trigger.new,trigger.newMap);
    }
    //Before Update
     if(trigger.IsBefore && trigger.IsUpdate){
        AccountTriggerHandler.handleBeforeUpdate(trigger.new,trigger.old,trigger.newMap,trigger.oldMap);
    }

   

}