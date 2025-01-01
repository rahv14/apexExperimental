/**
 * @description       : Create Customer Community User On Creation of Contact
 * @author            : Rahul V
 * @group             : SF
 * @last modified on  : 01-01-2025
 * @last modified by  : Rahul V
 **/

trigger CreateCustomerCommunityUser on Contact(after insert) {
  CreateCustomerCommunityUserHandler.onafterinsert(Trigger.new);
}
