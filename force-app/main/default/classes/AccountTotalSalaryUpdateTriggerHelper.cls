/**
 * @description       : Trigger Handler for AccountTotalSalaryUpdateTrigger
 * @author            : Rahul V
 * @group             : SF
 * @last modified on  : 05-01-2025
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   05-01-2025   Rahul V   Initial Version
 **/
public with sharing class AccountTotalSalaryUpdateTriggerHelper {
  /**
   * @description logic to update total salary on Account
   * @author Rahul V | 05-01-2025
   * @param List<Contact> listContactNew
   * @param Map<Id Contact> mapContactOld
   **/
  public static void totalSalaryUpdate(List<Contact> listContactNew, Map<Id, Contact> mapContactOld) {
    Set<Id> setContactId = new Set<Id>();
    if (listContactNew?.isEmpty() == false) {
      for (Contact con : listContactNew) {
        if (con.Id != mapContactOld.get(con.Id)) {
          setContactId?.add(con.AccountId);
        }
      }
    }

    List<Account> listAccountUpdate = new List<Account>();
    for (Account acc : [SELECT Id, Total_Salary__c, (SELECT Id, AccountId, Salary__c FROM Contacts) FROM Account WHERE Id IN :setContactId WITH USER_MODE]) {
      for (Contact con : acc.Contacts) {
        if (con.Salary__c != null) {
          acc.Total_Salary__c += con.Salary__c;
        } else {
          acc.Total_Salary__c = 0;
        }
      }
      listAccountUpdate.add(acc);
    }
    if (listAccountUpdate.size() > 0) {
      update as user listAccountUpdate;
    }
  }
}
