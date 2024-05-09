/**
 * @description       : 
 * @author            : Rahul V
 * @group             : 
 * @last modified on  : 02-09-2024
 * @last modified by  : Rahul V 
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   02-09-2024   Rahul V   Initial Version
**/
Map<Id, Account> accIdToAccMap = new Map<Id, Account>();
List<Contact> contactList = new List<Contact>();

for (Account acc : this.new) {
  if (acc.Id != null) {
    accIdToAccMap.put(acc.Id, acc);
  }
}

contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN :accIdToAccMap.keySet()];

if (contactList != null && !contactList.isEmpty()) {
  for (Contact con : contactList) {
    if (con.LastName != accIdToAccMap.get(con.AccountId).LastName) {
      con.LastName = accIdToAccMap.get(con.AccountId).LastName;
    }
  }
}

update contactList;
