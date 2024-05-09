/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 02-12-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   02-11-2024   Rahul V   Initial Version
 **/
trigger AccountToContactFieldUpdate on Account(after update) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    ContactTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
  }
}