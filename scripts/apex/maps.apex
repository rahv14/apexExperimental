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
