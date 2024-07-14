/**Map<String,List<SObject>> grouping records based on country USA */
Map<String, List<Contact>> mapNameToContact = new Map<String, List<Contact>>();
List<Contact> listContact = [SELECT Id, MailingCountry, Name, FirstName, LastName FROM Contact LIMIT 10];
for (Contact acc : listContact) {
  if (!mapNameToContact.containsKey(acc.MailingCountry)) {
    mapNameToContact.put(acc.MailingCountry, new List<Contact>{ acc });
  }
  mapNameToContact.get(acc.MailingCountry).add(acc);
}

List<Contact> listCountry = mapNameToContact.get('USA');
System.debug('Contacts Name: ' + listCountry);

Map<Id, Contact> mapcontact = new Map<Id, Contact>([SELECT Id, AccountId, Name, MailingCountry FROM Contact LIMIT 50]);
for (Contact con : mapcontact.values()) {
  System.debug('mapcontact ' + con.Name);
}
for (Id conId : mapcontact.keyset()) {
  System.debug('Contact Id ' + conId);
  System.debug('Contact Name ' + mapcontact.get(conId).Name);
}
