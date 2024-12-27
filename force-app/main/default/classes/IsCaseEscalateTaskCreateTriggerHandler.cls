/**
 * @description       : Whenever Escalation required checkbox gets checked, for an case on an Account a follow up task must be created & this task must be created on Primary Contact of the account
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 27-12-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   18-07-2024   Rahul V   Initial Version
 **/
public with sharing class IsCaseEscalateTaskCreateTriggerHandler {
  public static void createtask(List<Case> listNewCaseRecord) {
    Set<Id> setAccountId = new Set<Id>();
    if (listNewCaseRecord?.isEmpty() == false) {
      for (Case cs : listNewCaseRecord) {
        if (cs.IsEscalated == true) {
          setAccountId?.add(cs.AccountId);
        }
      }
    }

    /**
     * @description
     * @author Rahul V | 22-07-2024
     * @param
     * @return List<Task>
     **/
    List<Task> listTaskStore = new List<Task>();
    for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :setAccountId]) {
      Task t = new Task(WhoId = con.Id, Subject = 'Follow up again', Priority = 'High');
      listTaskStore.add(t);
    }
    insert listTaskStore;
    System.debug('listTaskStore' + listTaskStore);
  }
}
