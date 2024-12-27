/**
 * @description       : Trigger to prevent account deletion and display error message when there are related opportunities
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 25-07-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   25-07-2024   Rahul V   Initial Version
 **/
trigger PreventAccountDeletion on Account(before delete) {
  if (Trigger.isdelete && Trigger.isbefore) {
    PreventAccDeletionTriggerHandler.onbefore(Trigger.old);
  }
}