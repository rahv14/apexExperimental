/**
 * @description       : Write a Salesforce trigger to calculate the total salary of all related Contacts for an Account. 
                        Whenever a Contact is inserted, updated, or deleted, the trigger should update the custom field 
                        Total_Salary__c on the Account with the sum of the Salary__c field from its related Contacts.
 * @author            : Rahul V
 * @group             : SF
 * @last modified on  : 06-01-2025
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   05-01-2025   Rahul V   Initial Version
 **/
trigger AccountTotalSalaryUpdate on Contact(after update) {
  if (Trigger.isafter && Trigger.isUpdate) {
    AccountTotalSalaryUpdateTriggerHelper.totalSalaryUpdate(Trigger.new, Trigger.oldMap);
  }
}
