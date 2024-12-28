/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 05-29-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   02-11-2024   Rahul V   Initial Version
 **/
public class ContactTriggerHandler {
  public static void onAfterUpdate(List<Account> listNewAccounts, Map<Id, Account> mapOldAccount) {
    try {
      Map<Id, String> mapAccountIdDescription = new Map<Id, String>();

      for (Account acc : listNewAccounts) {
        if (acc.Description != mapOldAccount.get(acc.Id).Description) {
          mapAccountIdDescription.put(acc.Id, acc.Description);
        }
      }

      if (!mapAccountIdDescription.isEmpty()) {
        List<Contact> listContactToUpdate = new List<Contact>();

        for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :mapAccountIdDescription.keySet()]) {
          String strAccountDescription = mapAccountIdDescription.get(con.AccountId);

          if (strAccountDescription != null) {
            con.Description = strAccountDescription;
            listContactToUpdate.add(con);
          }
        }
        if (!listContactToUpdate.isEmpty()) {
          update listContactToUpdate;
        }
      }
    } catch (Exception ex) {
      System.debug('Exception : ' + ex.getMessage());
      System.debug('Get line number' + ex.getLineNumber());
      System.debug('Get cause: ' + ex.getCause());
      System.debug('Get Type' + ex.getTypeName());
    }
  }
  public static void onDelete(List<Account> listDeleteOldAccount) {
    Set<Id> setAccIds = new Set<Id>();
    for (Account acc : listDeleteOldAccount) {
      SetAccIds.add(acc.Id);
    }
    if (setAccIds.size() > 0) {
      List<Contact> listContactToUpdate = new List<Contact>();
      for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :setAccIds]) {
        con.AccountId = null;
        listContactToUpdate.add(con);
      }
      if (listContactToUpdate.size() > 0) {
        delete listContactToUpdate;
      }
    }
  }
}