/**
 * @description       : 
 * @author            : Rahul V
 * @group             : 
 * @last modified on  : 28-12-2024
 * @last modified by  : Rahul V
**/
t/**
 * @description       : Create Customer Community User On Creation of Contact
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 26-12-2024
 * @last modified by  : Rahul V
 **/

trigger CreateCustomerCommunityUser on Contact(after insert) {
  if (Trigger.isInsert && Trigger.isAfter) {
    /* List<Contact> listContact = new List<Contact>();
    for (Contact con : Trigger.new) {
      if (con.AccountId != null && con.Email != null && con.FirstName != null && con.LastName != null) {
        listContact?.add(con);
      }
    } */
    CreateCustomerCommunityUserHandler.onafterinsert(Trigger.new);
  }
}
