/**
 * @description       : Trigger to prevent account deletion and display error message when there are related opportunities
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 29-07-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   25-07-2024   Rahul V   Initial Version
 **/
public with sharing class PreventAccDeletionTriggerHandler {
  public static void onbefore(List<Account> listAccountOld) {
    Set<Id> setAccountId = new Set<Id>();

    if (listAccountOld?.isEmpty() == false)
      for (Account acc : listAccountOld) {
        setAccountId?.add(acc.Id);
      }

    //Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>([SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :setAccountId WITH USER_MODE LIMIT 1]);
    Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>();
    for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :setAccountId WITH USER_MODE LIMIT 1]) {
      mapOpp.put(opp.AccountId, opp);
    }

    //Map<Id, AggregateResult> mapOpp = new Map<Id, AggregateResult>([SELECT AccountId FROM Opportunity WHERE AccountId IN :setAccountId AND AccountId != NULL GROUP BY AccountId]);

    for (Account acct : listAccountOld) {
      Opportunity relatedOpportunity = mapOpp.get(acct.Id);
      //if (mapOpp.containsKey(acct.Id)) {
      if (relatedOpportunity != null) {
        acct.addError('Cannot delete Account Records');
      }
    }
  }
}