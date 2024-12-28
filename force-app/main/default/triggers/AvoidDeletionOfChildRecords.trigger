/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 05-24-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   05-24-2024   Rahul V   Initial Version
 **/
trigger AvoidDeletionOfChildRecords on Contact(before delete) {
  if (Trigger.isBefore && Trigger.isDelete) {
    AvoidDeletionOfChildRecords.OnDelete(Trigger.old);
  }
}