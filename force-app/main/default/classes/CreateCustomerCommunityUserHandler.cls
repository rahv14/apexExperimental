/**
 * @description       : Create Customer Community User On Creation of Contact
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 21-10-2024
 * @last modified by  : Rahul V
 **/
public with sharing class CreateCustomerCommunityUserHandler {
  public static void onafterinsert(List<Contact> listContactNew) {
    Set<Id> setContactId = new Set<Id>();
    if (listContactNew?.isEmpty() == false) {
      for (Contact con : listContactNew) {
        setContactId?.add(con.AccountId);
      }
    }

    Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community User' WITH USER_MODE LIMIT 1].Id;

    Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, OwnerId, Owner.UserRoleId, Owner.UserRole.DeveloperName FROM Account WHERE Id IN :setContactId]);

    List<User> listCreateUser = new List<User>();
    for (Contact c : listContactNew) {
      if (c.AccountId != null && c.Email != null) {
        Account relatedAccount = accountMap.get(c.AccountId);
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
    if (listCreateUser.size() > 0) {
      insert as user listCreateUser;
    }
  }
}
