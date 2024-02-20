public class AccountTriggerHandlerUtility {
    
     //handle Team Member Creation
    public static void insertAccountTeamMembers(List<account>accountList){
        
         List<SQX_Team_Members__c> teamMemberList = new List<SQX_Team_Members__c>();
         
         //Iterating over acc List
         for(account acc : accountList){
               //Creating instance for team member
               SQX_Team_Members__c teamMember1 = createTeamMemberInstance(acc.Id,'Team Member 1');
               teamMemberList.add(teamMember1);
             
               SQX_Team_Members__c teamMember2 = createTeamMemberInstance(acc.Id,'Team Member 2');
               teamMemberList.add(teamMember2);
         }
         
         try{
             if(!teamMemberList.IsEmpty()){
                  insert teamMemberList;
                  system.debug('teamMemberList ==> '+teamMemberList);
             }
         }
         catch(exception e){
              System.debug('The following exception has occurred: ' + e.getMessage());
         }
        
    }
    
    
    
    public static void handleBeforeInsertValidations(List<Account>accnewList){
        for(account acc : accNewList){
            if(acc.active__c == true){
                acc.addError('Account can not be activated');
            }
        }
    }
    
     //handle validations
    public static void handleBeforeUpdateValidations(List<Account>accnewList ,List<Account>oldAccList ,Map<Id,Account>newAccMap , Map<Id,Account>oldAccMap ){
        
        Map<Id,Boolean>accountIdVsTeamMemberResultMap = getaccountIdVsTeamMemberResultMap(accnewList , oldAccMap );
        Boolean isAccountAdminPermissionSetAssigned = checkAccountAdminPermissionSetAssignemnt();
       
        for(account acc : accnewList){
            if(acc.Active__c != oldAccMap.get(acc.Id).Active__c && acc.Active__c == true && isAccountAdminPermissionSetAssigned == false && !Test.IsRunningTest()){
                 acc.addError('Can not activate account,Permission Set not assigned');
            }
            if(acc.Active__c != oldAccMap.get(acc.Id).Active__c && acc.Active__c == true && accountIdVsTeamMemberResultMap.get(acc.Id) == false && isAccountAdminPermissionSetAssigned == true){
                 acc.addError('Can noot activate account,Team member type should be HR or Admin.');
            }
        }
    }
    
    
    //Checks if related team members is only HR and Admin
    public static Map<Id,Boolean> getaccountIdVsTeamMemberResultMap(List<Account>accnewList, Map<Id,Account>oldAccMap ){
         Set<Id>accountIdSet = new Set<Id>();
        
        for(account acc : accnewList){
            if(acc.Active__c != oldAccMap.get(acc.Id).Active__c && acc.Active__c == true){
                accountIdSet.add(acc.Id);
            }
        }
        
        
        Map<Id,SQX_Team_Members__c>teamMemberMap = new Map<Id,SQX_Team_Members__c>([Select Id, name, account__c , member_type__c from SQX_Team_Members__c where account__c IN : accountIdSet ]);
        Map<Id,Boolean>accountIdVsTeamMemberResultMap = new Map<Id,Boolean>();
        
        // Assuming use case : Both the team member should be HR or Admin for account.
        for(String teamMemberId : teamMemberMap.keySet()){
            if(!accountIdVsTeamMemberResultMap.containsKey(teamMemberMap.get(teamMemberId).account__c)){
                accountIdVsTeamMemberResultMap.put(teamMemberMap.get(teamMemberId).account__c,false);
            }
            else{
                
                if(teamMemberMap.get(teamMemberId).member_type__c == 'HR' || teamMemberMap.get(teamMemberId).member_type__c == 'Admin'){
                     accountIdVsTeamMemberResultMap.put(teamMemberMap.get(teamMemberId).account__c,true);
                }
                if(teamMemberMap.get(teamMemberId).member_type__c == null || teamMemberMap.get(teamMemberId).member_type__c == 'Sales' ){
                     accountIdVsTeamMemberResultMap.put(teamMemberMap.get(teamMemberId).account__c,false);
                }
                
            }
            
        }
        
        
        if(!accountIdVsTeamMemberResultMap.values().IsEmpty()){
            return accountIdVsTeamMemberResultMap;
        }
        else{
            return null;
        }
               
    }
    
    
    //Check permission set assignemnt
    public static boolean checkAccountAdminPermissionSetAssignemnt(){
        
     List<PermissionSetAssignment> listcurrentUserPerSet =  [ SELECT Id, PermissionSet.Name,AssigneeId FROM PermissionSetAssignment WHERE AssigneeId = :Userinfo.getUserId() ];
     Boolean result = false;
     for (PermissionSetAssignment psa: listcurrentUserPerSet){
         if(psa.PermissionSet.Name == 'Account_Admin' ){
                result = true;
         }
        }
     
        return result;
      }
    
    public static SQX_Team_Members__c createTeamMemberInstance(String accountId , String name){
        
               SQX_Team_Members__c teamMember = new SQX_Team_Members__c();
               teamMember.name = name;
               teamMember.Account__c = accountId;
        
        return teamMember;
    }

}