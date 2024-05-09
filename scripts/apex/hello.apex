/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 02-12-2024
 * @last modified by  : Rahul V
 **/
//Map<ID, Contact> m = new Map<ID, Contact>([SELECT Id, LastName FROM Contact WITH USER_MODE LIMIT 1]);

Map<Id, Account> accounts = new Map<Id, Account>((List<Account>) Database.query('SELECT Id, Name FROM Account LIMIT 1'));
System.debug('accounts >>>' + accounts);
map<id, contact> contacts = new Map<id, contact>([SELECT id, lastname FROM contact]);
system.debug('contacts >>>' + contacts);

for (Id key : contacts.keySet()) {
  System.debug('Contacts Id' + key);
}

for (Contact con : contacts.values()) {
  System.debug('Contacts values' + con);
}
