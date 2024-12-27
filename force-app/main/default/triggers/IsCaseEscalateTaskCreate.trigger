/**
 * @description       : Whenever Escalation required checkbox gets checked, for an case on an Account a follow up task must be created & this task must be created on Primary Contact of the account
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 18-07-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   18-07-2024   Rahul V   Initial Version
 **/
trigger IsCaseEscalateTaskCreate on Case(after insert) {
  if (Trigger.isafter && Trigger.isinsert) {
    IsCaseEscalateTaskCreateTriggerHandler.createtask(Trigger.new);
  }
}