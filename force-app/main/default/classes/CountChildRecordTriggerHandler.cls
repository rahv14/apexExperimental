/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 02-07-2024
 * @last modified by  : rahul
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   03-20-2024   Rahul V   Initial Version
 **/
public with sharing class CountChildRecordTriggerHandler {
  /*  public static void CountContact(List<Contact> listContact, Boolean isDelete) {
    Map<Id, List<Contact>> mapContactCount = new Map<Id, List<Contact>>();
    for (Contact con : listContact) {
      if (con.AccountId != null) {
        if (!mapContactCount.containsKey(con.AccountId)) {
          mapContactCount.put(con.AccountId, new List<Contact>());
        }
        mapContactCount.get(con.AccountId).add(con);
      }
    }
    if (mapContactCount.size() > 0) {
      List<Account> listAccount = [SELECT Id, NumberOfContacts__c FROM Account WHERE Id IN :mapContactCount.keySet()];
      for (Account acc : listAccount) {
        if (acc.NumberOfContacts__c == null) {
          acc.NumberOfContacts__c = mapContactCount.get(acc.Id).size();
        } else if (isDelete) {
          acc.NumberOfContacts__c -= mapContactCount.get(acc.Id).size();
        } else {
          acc.NumberOfContacts__c += mapContactCount.get(acc.Id).size();
        }
      }
      update listAccount;
    } */
  public static void handleAfterInsert(List<Contact> listContact) {
    set<Id> setAccountid = new Set<Id>();
    list<Account> lstAc = new List<Account>();
    try {
      for (Contact ct : listContact) {
        setAccountid.add(ct.AccountId);
      }
      //query only when set is not empty
      if (!setAccountid.isEmpty()) {
        AggregateResult[] queryContact = [SELECT Count(Id) cti, AccountId aci FROM Contact WHERE AccountID = :setAccountid WITH USER_MODE GROUP BY AccountId];

        if (queryContact.size() > 0) {
          //now use foreach loop
          for (AggregateResult ar : queryContact) {
            Id AccId = (Id) ar.get('aci');
            Integer count = (INTEGER) ar.get('cti');
            Account act = new Account(Id = AccId);
            act.NumberOfContacts__c = count;
            lstAc.add(act);
          }
          update lstAc;
        }
      }
    } catch (exception ex) {
      system.debug('@@@@ getLineNumber: ' + ex.getLineNumber());
      system.debug('@@@@ getMessage: ' + ex.getMessage());
    }
  }

  /* public static void handleAfterUpdate(List<Contact> updatedContacts, Map<Id, Contact> mapOldContacts) {
    set<Id> setAccountid = new Set<Id>();
    list<Account> lstAc = new List<Account>();
    try {
      for (Contact ct : updatedContacts) {
        if (ct.AccountId != mapOldContacts.get(ct.Id).AccountId) {
          setAccountid.add(ct.AccountId);
          setAccountid.add(mapOldContacts.get(ct.Id).AccountId);
        }
      }

      //query only when set is not empty
      if (!setAccountid.isEmpty()) {
        //set<Id> setAccountid = new set<Id>();
        AggregateResult[] queryContact = [SELECT Count(Id) cti, AccountId aci FROM Contact WHERE AccountID IN :setAccountid GROUP BY AccountID];

        if (queryContact.size() > 0) {
          //now use foreach loop
          for (AggregateResult ar : queryContact) {
            Id AccId = (Id) ar.get('aci');
            Integer count = (INTEGER) ar.get('cti');
            Account act = new Account(Id = AccId);
            act.NumberOfContacts__c = count;
            lstAc.add(act);
          }
          update lstAc;
        }
      }
    } catch (exception ex) {
      system.debug('@@@@ getLineNumber: ' + ex.getLineNumber());
      system.debug('@@@@ getMessage: ' + ex.getMessage());
    }
  }
} */
  // or //
  public static void handleAfterUpdate(List<Contact> listContact, Map<Id, List<Contact>> mapContactCount) {
    try {
      List<Account> accountsToUpdate = new List<Account>();
      for (Contact con : listContact) {
        if (con.AccountId != null) {
          if (!mapContactCount.containsKey(con.AccountId)) {
            mapContactCount.put(con.AccountId, new List<Contact>());
          }
          mapContactCount.get(con.AccountId).add(con);
        }
      }

      List<AggregateResult> queryContactCounts = [
        SELECT AccountId, COUNT(Id) contactCount
        FROM Contact
        WHERE AccountId IN :mapContactCount.keySet()
        GROUP BY AccountId
      ];

      for (AggregateResult result : queryContactCounts) {
        Id accountId = (Id) result.get('AccountId');
        Integer contactCount = (Integer) result.get('contactCount');
        Account account = new Account(Id = accountId, NumberOfContacts__c = contactCount);
        accountsToUpdate.add(account);
      }
      if (accountsToUpdate.size() > 0) {
        update accountsToUpdate;
      }
    } catch (Exception ex) {
      system.debug('@@@@ getLineNumber: ' + ex.getLineNumber());
      system.debug('@@@@ getMessage: ' + ex.getMessage());
    }
  }

  /* public static void handleAfterUpdate(List<Contact> updatedContacts, Map<Id, Contact> oldContactMap) {
    updateAccountContactCount(updatedContacts);
  } */

  public static void handleAfterDelete(List<Contact> deletedContacts) {
    Set<Id> setAccountId = new Set<Id>();
    List<Account> listAccount = new List<Account>();
    try {
      for (Contact contact : deletedContacts) {
        if (contact.AccountId != null) {
          setAccountId.add(contact.AccountId);
        }

        if (!setAccountid.isEmpty()) {
          AggregateResult[] queryContact = [SELECT Count(Id) cti, AccountId aci FROM Contact WHERE AccountID = :setAccountid GROUP BY AccountId];

          if (queryContact.size() > 0) {
            //now use foreach loop
            for (AggregateResult ar : queryContact) {
              Id AccId = (Id) ar.get('aci');
              Integer count = (INTEGER) ar.get('cti');
              Account act = new Account(Id = AccId);
              act.NumberOfContacts__c = count;
              listAccount.add(act);
            }
            update listAccount;
          }
        }
      }
    } catch (exception ex) {
      system.debug('@@@@ getLineNumber: ' + ex.getLineNumber());
      system.debug('@@@@ getMessage: ' + ex.getMessage());
    }
  }
}

/* public static void handleAfterUndelete(List<Contact> undeletedContacts) {
    updateAccountContactCount(undeletedContacts);
  } */