/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 05-08-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   03-20-2024   Rahul V   Initial Version
 **/
trigger CountChildRecords on Contact(after insert, after update, after delete, after undelete) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      CountChildRecordTriggerHandler.handleAfterInsert(Trigger.new);
    }
  }
  /*    if (Trigger.isUpdate) {
      List<Contact> listContact = new List<Contact>();
      for (Contact con : Trigger.New) {
        if (con.AccountId != null) {
          listContact.add(con);
        }
      }
         Map<Id, Contact> mapOldContact = new Map<Id, Contact>();
    Set<Id> setAccountId = new Set<Id>();
    for (Contact con : Trigger.oldMap.values()) {
      if (con.AccountId != null && con.AccountId != mapOldContact.get(con.Id).AccountId) {
        setAccountid.add(con.AccountId);
        setAccountid.add(mapOldContact.get(con.Id).AccountId);
      }
    }

      CountChildRecordTriggerHandler.handleAfterUpdate(listContact, Trigger.oldMap);
    } */
  if (Trigger.isUpdate) {
    List<Contact> listContact = new List<Contact>();
    for (Contact con : Trigger.New) {
      if (con.AccountId != null) {
        listContact.add(con);
      }
    }

    Map<Id, List<Contact>> mapOldContact = new Map<Id, List<Contact>>();
    for (Contact con : Trigger.oldMap.values()) {
      if (con.AccountId != null && !mapOldContact.containsKey(con.AccountId)) {
        mapOldContact.put(con.AccountId, new List<Contact>());
      }
      mapOldContact.get(con.AccountId).add(con);
    }

    CountChildRecordTriggerHandler.handleAfterUpdate(listContact, mapOldContact);
  }

  if (Trigger.isDelete) {
    CountChildRecordTriggerHandler.handleAfterDelete(Trigger.old);
  }
}