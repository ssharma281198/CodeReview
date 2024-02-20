@isTest
private class AccountTest {
    
    @isTest 
    static void testAccountTrigger(){
          testAsPerProfile('System Administrator');
        //  testAsPerProfile('Standard User');
    }
    
    static void testAsPerProfile(String profile){
        
         Test.startTest();
        // Set user context to admin
        Profile prof = [Select Id FROM Profile WHERE Name =: profile ];
        User u = new User(Alias = 'admin', Email='testAdmin@testadmin.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', 
                          LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
                          ProfileId = prof.Id, 
                          TimeZoneSidKey='America/Los_Angeles', 
                          UserName='testadminuser@testadminuser.com');
        
         
        
        System.runAs(u) {
            
            // Create test data
        Account acc = new Account(Name='Test Account' , active__c = false);
        insert acc;
        
         List<SQX_Team_Members__c> teamMemberList = new List<SQX_Team_Members__c>();
         
           //Creating instance for team member
               SQX_Team_Members__c teamMember1 = new SQX_Team_Members__c();
               teamMember1.name = 'Team Member 1';
               teamMember1.Account__c = acc.Id;
               teamMember1.member_type__c = 'Admin';
               teamMemberList.add(teamMember1);
             
               SQX_Team_Members__c teamMember2 = new SQX_Team_Members__c();
               teamMember2.name = 'Team Member 2';
               teamMember2.Account__c = acc.Id;
               teamMember2.member_type__c = 'Admin';
               teamMemberList.add(teamMember2);
        
        insert teamMemberList;
        
        acc.active__c = true;
        update acc;
        
        Test.stopTest();
        }
      
        
    }
  }