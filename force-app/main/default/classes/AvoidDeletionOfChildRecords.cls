/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 05-24-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   05-24-2024   Rahul V   Initial Version
 **/
public with sharing class AvoidDeletionOfChildRecords {
  public static void OnDelete(List<Contact> oldContact) {
    Set<Id> setContactId = new Set<Id>();
    for (Contact con : oldContact) {
      setContactId.add(con?.AccountId);
    }

    Map<Id, Account> mapAccount = new Map<Id, Account>([SELECT Id FROM Account WHERE Id IN :setContactId]);
    for (Contact cont : oldContact) {
      Account relatedAccount = mapAccount.get(cont.AccountId);
      if (relatedAccount != null) {
        cont.addError('You cannot delete this contact');
      }
    }
  }
}