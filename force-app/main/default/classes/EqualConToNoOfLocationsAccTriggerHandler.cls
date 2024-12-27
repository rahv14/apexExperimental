/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 24-07-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   24-07-2024   Rahul V   Initial Version
 **/
public with sharing class EqualConToNoOfLocationsAccTriggerHandler {
  public static void oninsert(List<Account> listAccountNew) {
    Map<Id, Decimal> mapDecimalVal = new Map<Id, Decimal>();
    List<Contact> listContactStore = new List<Contact>();

    if (listAccountNew?.isEmpty() == false)
      for (Account acc : listAccountNew) {
        mapDecimalVal.put(acc.Id, acc.NumberOfLocations__c);
      }

    for (Id accId : mapDecimalVal.keyset()) {
      Decimal accountDecimal = mapDecimalVal.get(accId);

      for (Integer i = 0; i < accountDecimal; i++) {
        listContactStore.add(new Contact(AccountId = accId, FirstName = System.Label.Default_First_Name + i));
      }
    }

    insert as user listContactStore;
  }
}