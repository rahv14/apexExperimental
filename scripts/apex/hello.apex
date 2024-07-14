/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 03-25-2024
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

Map<String, SObjectField> fieldMap = Contact.SObjectType.getDescribe().fields.getMap();
System.debug('fieldMap >>>: ' + fieldMap);

Set<Id> accountIds = new Set<Id>();
Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
List<Contact> newList = new List<Contact>();
if (newList != null) {
  for (Contact c : newList) {
    if (c.AccountId != null) {
      accountIds.add(c.AccountId);
    }
    //accountIds.add(c.AccountId ?? '');
  }
}
for (AggregateResult result : [SELECT AccountId accountId, Count(Id) cnt FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
  Id accountId = (Id) result.get('accountId');
  Integer contactCount = (Integer) result.get('cnt');
  //accountContactCountMap.put((Id) result.get('AccountId'), (Integer) result.get('cnt'));
  accountContactCountMap.put(accountId, contactCount);
  System.debug('accountContactCountMap >>>: ' + accountContactCountMap);
}

List<Account> acctList = new List<Account>();
// Update the Number of Contacts field on Account records
for (Id accountId : accountIds) {
  if (accountContactCountMap.containsKey(accountId)) {
    acctList.add(new Account(Id = accountId, NumberOfContacts__c = accountContactCountMap.get(accountId)));
  }
}

update acctList;
