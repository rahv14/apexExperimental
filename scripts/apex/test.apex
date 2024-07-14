/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 02-22-2024
 * @last modified by  : Rahul V
 * Modifications Log
 * Ver   Date         Author    Modification
 * 1.0   02-09-2024   Rahul V   Initial Version
 **/

/*Looping through Map*/
Map<String, String> mapString = new Map<String, String>{ 'Aston Martin' => 'Alonso' };
/*Print each value string value in the map*/
for (String key : mapString.keySet()) {
  System.debug('Key: ' + key + ' Value: ' + mapString.get(key));
}

List<Contact> listContact = new List<Contact>([SELECT Id, Name FROM Contact]);
Map<Id, Contact> mapIdToContact = new Map<Id, Contact>();
for (Contact con : listContact) {
  mapIdToContact.put(con.Id, con);
  System.debug('Map key Id and Value Object !!!!' + mapIdToContact.put(con.Id, con));
}
Contact c = mapIdToContact.get(listContact[0].Id);
System.debug('Contact key Id ' + c.Name);

for (Contact c : listContact) {
  if (mapIdToContact.containsKey(c.Id)) {
    System.debug('Contact key Id >>' + c.Name);
    break;
  }
}

for (Integer i = 0; i < listContact.size(); i++) {
  if (mapIdToContact.containsKey(listContact[i].Id)) {
    if (i == 1) {
      System.debug('Contact name @@@ ' + listContact[i].Name);
      break;
    }
  }
}
