public class AccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account>accnewList){
        //handle before insert validations
        AccountTriggerHandlerUtility.handleBeforeInsertValidations(accnewList);
    }
    
     //handle After Insert Event
     public static void handleAfterInsert(List<Account>accNewList , Map<Id,Account>newAccMap){
         //handle Team Member Creation
         AccountTriggerHandlerUtility.insertAccountTeamMembers(accNewList);
    }
    
     //handle before update event
     public static void handleBeforeUpdate(List<Account>accnewList ,List<Account>oldAccList ,Map<Id,Account>newAccMap , Map<Id,Account>oldAccMap ){
         //handle before update validations
         AccountTriggerHandlerUtility.handleBeforeUpdateValidations(accnewList,oldAccList,newAccMap,oldAccMap);
    }
    
}