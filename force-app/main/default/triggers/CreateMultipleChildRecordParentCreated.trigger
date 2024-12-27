/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 07-15-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   07-15-2024   Rahul V   Initial Version
 **/
trigger CreateMultipleChildRecordParentCreated on Account(after insert) {
  if (Trigger.isAfter && Trigger.isinsert) {
    CreateMulipleChildRecordTriggerHandler.onafterinsert(Trigger.new);
  }
}