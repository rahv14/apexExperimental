/**
 * @description       : Create Customer Community User On Creation of Contact
 * @author            : Rahul V
 * @group             : SF
 * @last modified on  : 01-01-2025
 * @last modified by  : Rahul V
 **/
public with sharing class CreateCustomerCommunityUserHandler {
  /**
   * @description method to create Customer Community User on create of Contact
   * @author Rahul V | 01-01-2025
   * @param listContactNew
   **/
  public static void onafterinsert(List<Contact> listContactNew) {
    try {
      Set<Id> setContactId = new Set<Id>();
      if (listContactNew?.isEmpty() == false) {
        for (Contact con : listContactNew) {
          if (con.AccountId != null) {
            setContactId.add(con.AccountId);
          }
        }
      }

      System.debug('Account IDs collected: ' + setContactId);

      Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community User' WITH USER_MODE LIMIT 1].Id;
      System.debug('Profile ID: ' + profileId);
      Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, OwnerId, Owner.UserRoleId, Owner.UserRole.DeveloperName FROM Account WHERE Id IN :setContactId]);
      System.debug('Account Map: ' + accountMap);
      List<User> listCreateUser = new List<User>();
      for (Contact c : listContactNew) {
        if (c.AccountId != null && c.Email != null) {
          Account relatedAccount = accountMap.get(c.AccountId);
          System.debug('Processing Contact: ' + c.Id + ', Related Account: ' + relatedAccount);

          if (relatedAccount != null && relatedAccount.OwnerId != null && relatedAccount.Owner.UserRoleId != null) {
            listCreateUser.add(
              new User(
                FirstName = c.FirstName,
                LastName = c.LastName,
                Email = c.Email,
                ProfileId = profileId,
                Alias = c.LastName.Length() > 8 ? c.Lastname.substring(0, 8) : c.LastName,
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                TimeZoneSidKey = 'America/Los_Angeles',
                ContactId = c.Id,
                Username = c.Email + '.com'
              )
            );
          }
        }
      }
      System.debug('Users to Insert: ' + listCreateUser);

      if (!listCreateUser.isEmpty() && listCreateUser.size() > 0) {
        insert as user listCreateUser;
      } else {
        System.debug('No users to insert.');
      }
    } catch (Exception ex) {
      System.debug('Message: ' + ex.getMessage() + ' - Line: ' + ex.getLineNumber());
    }
  }
}
