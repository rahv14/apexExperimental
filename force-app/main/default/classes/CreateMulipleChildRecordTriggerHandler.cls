/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 07-16-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   07-15-2024   Rahul V   Initial Version
 **/
public with sharing class CreateMulipleChildRecordTriggerHandler {
  public static void onafterinsert(List<Account> listAccountNewRecord) {
    Map<Id, Account> mapAccount = new Map<Id, Account>();
    List<Contact> listContactStore = new List<Contact>();
    List<Opportunity> listOpportunityStore = new List<Opportunity>();

    if (!listAccountNewRecord.isEmpty()) {
      for (Account acc : listAccountNewRecord) {
        mapAccount.put(acc.Id, acc);
      }
    }

    for (Id accId : mapAccount.keySet()) {
      Account acc = mapAccount.get(accId);

      for (Integer i = 0; i <= 2; i++) {
        Contact con = new Contact(FirstName = System.Label.Default_First_Name + i, LastName = acc.name, AccountId = acc.Id, MailingCity = acc.BillingCity);
        listContactStore.add(con);
      }
      for (Integer i = 0; i <= 1; i++) {
        Opportunity opp = new Opportunity(Name = 'Opportunity' + i + ' for ' + acc.Name, StageName = 'Prospecting', CloseDate = Date.today(), AccountId = acc.Id);
        listOpportunityStore.add(opp);
      }
    }
    if (listContactStore.size() > 0) {
      insert listContactStore;
    }
    if (listOpportunityStore.size() > 0) {
      insert listOpportunityStore;
    }
  }
}