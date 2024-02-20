@isTest
private class AccountTriggerHandlerUtilityTest {

    @isTest 
    static void testAccountTriggerAsAdmin(){
        // Set user context to admin
        Profile prof = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User adminUser = new User(
            Alias = 'admin', 
            Email = 'testAdmin@testadmin.com', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Testing', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = prof.Id, 
            TimeZoneSidKey = 'America/Los_Angeles', 
            UserName = 'testadminuser@testadminuser22.com'
        );
        
        // Insert admin user
        insert adminUser;
        
        // Run as admin user
        System.runAs(adminUser) {
            // Start test execution
            Test.startTest();
            
            // Create test data
            Account acc = new Account(Name = 'Test Account', Active__c = false);
            insert acc;
            
            List<SQX_Team_Members__c> teamMemberList = new List<SQX_Team_Members__c>();
            // Create team members
            SQX_Team_Members__c teamMember1 = new SQX_Team_Members__c();
            teamMember1.Name = 'Team Member 1';
            teamMember1.Account__c = acc.Id;
            teamMember1.Member_Type__c = 'Admin';
            teamMemberList.add(teamMember1);
            
            SQX_Team_Members__c teamMember2 = new SQX_Team_Members__c();
            teamMember2.Name = 'Team Member 2';
            teamMember2.Account__c = acc.Id;
            teamMember2.Member_Type__c = 'Admin';
            teamMemberList.add(teamMember2);
            
            // Insert team members
            insert teamMemberList;
            
            // Activate the account
            acc.Active__c = true;
            update acc;
            
            // Stop test execution
            Test.stopTest();
        }
    }

    @isTest 
    static void testAccountTriggerAsStandardUser(){
        // Set user context to standard user
        Profile prof = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User stdUser = new User(
            Alias = 'stduser', 
            Email = 'testStdUser@teststduser22.com', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Testing', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = prof.Id, 
            TimeZoneSidKey = 'America/Los_Angeles', 
            UserName = 'teststduser@teststduser22.com'
        );
        
        // Insert standard user
        insert stdUser;
        
        // Run as standard user
        System.runAs(stdUser) {
            // Start test execution
            Test.startTest();
            
            Account acc = new Account(Name = 'Test Account', Active__c = false);
            insert acc;
            
            List<SQX_Team_Members__c> teamMemberList = new List<SQX_Team_Members__c>();
            // Create team members
            SQX_Team_Members__c teamMember1 = new SQX_Team_Members__c();
            teamMember1.Name = 'Team Member 1';
            teamMember1.Account__c = acc.Id;
            teamMember1.Member_Type__c = 'Admin';
            teamMemberList.add(teamMember1);
            
            SQX_Team_Members__c teamMember2 = new SQX_Team_Members__c();
            teamMember2.Name = 'Team Member 2';
            teamMember2.Account__c = acc.Id;
            teamMember2.Member_Type__c = 'Admin';
            teamMemberList.add(teamMember2);
            
            // Insert team members
            insert teamMemberList;
            
            // Activate the account
            acc.Active__c = true;
            update acc;
                        
            // Stop test execution
            Test.stopTest();
        }
    }
}