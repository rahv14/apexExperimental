/**
 * @description       : Trigger To Avoid the deletion of child records
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 05-29-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   05-24-2024   Rahul V   Initial Version
 **/
public with sharing class AvoidDeletionOfChildRecords {
  public static void OnDelete(List<Contact> oldContact) {
    try {
      Set<Id> setContactId = new Set<Id>();
      for (Contact con : oldContact) {
        setContactId.add(con?.AccountId);
      }
      try {
        Map<Id, Account> mapAccount = new Map<Id, Account>([SELECT Id FROM Account WHERE Id IN :setContactId]);
      } catch (QueryException eq) {
        Map<String, Set<String>> inaccessible = eq.getInaccessibleFields();
        Set<String> accountFields = inaccessible.get('Account');
        System.debug('Get inaccessible fields' + accountFields);
      }
      for (Contact cont : oldContact) {
        Account relatedAccount = mapAccount.get(cont.AccountId);
        if (relatedAccount != null) {
          cont.addError('You cannot delete this contact');
        }
      }
    } catch (Exception ex) {
      System.debug('Get line number: ' + ex.getLineNumber());
      System.debug('Get Cause: ' + ex.getCause());
      System.debug('Get Message: ' + ex.getMessage());
      System.debug('Get type' + ex.getTypeName());
    }
  }
}
