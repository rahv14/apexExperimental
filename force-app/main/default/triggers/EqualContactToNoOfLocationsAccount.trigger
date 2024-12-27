/**
 * @description       : Create Number of Contacts which are equal to the number which will enter in the Number of Location Field Account
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 24-07-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   24-07-2024   Rahul V   Initial Version
 **/
trigger EqualContactToNoOfLocationsAccount on Account(after insert) {
  if (Trigger.isafter && Trigger.isinsert) {
    EqualConToNoOfLocationsAccTriggerHandler.oninsert(Trigger.new);
  }

}