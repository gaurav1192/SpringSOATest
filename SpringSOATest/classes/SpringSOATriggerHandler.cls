/*
 	*************Legacy Data Fix - Anonymous Code***********
	List<Account> accountListToUpdate = new List<Account>();
	for(Account acc : [SELECT Id, (SELECT Id From Contacts) FROM Account]) {
		Account accToUpdate = new Account();
		accToUpdate.Id = acc.Id;
		accToUpdate.Number_of_Contacts__c = acc.Contacts.size();
		accountListToUpdate.add(accToUpdate);
	}

	if(!accountListToUpdate.isEmpty()) {
		update accountListToUpdate;
	}

	****** If records are in large number then we can create batch class or bulk upload based on size of data*******
*/


public class SpringSOATriggerHandler {
    public static void afterInsert(List<Contact> newList) {
        updateNumberOfContacts(newList, null);
    }
    
    public static void afterUpdate(List<Contact> newList, Map<Id, Contact> oldMap) {
        updateNumberOfContacts(newList, oldMap);
    }
    
    public static void afterDelete(List<Contact> oldList) {
        updateNumberOfContacts(oldList, null);
    }
    
    public static void afterUndelete(List<Contact> newList) {
        updateNumberOfContacts(newList, null);
    }
    
    public static void updateNumberOfContacts(List<Contact> newList, Map<Id, Contact> oldMap){
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        for(Contact con : newList) {
            
            if(oldMap == null || (oldMap != null && con.AccountId != oldMap.get(con.Id).AccountId)) {
                
                if(con.AccountId != null) {
                    Account acc = new Account();
            		acc.Number_of_Contacts__c = 0;
                    acc.Id = con.AccountId;
                	accountMap.put(acc.Id, acc);
                }
                if(oldMap != null && oldMap.get(con.Id).AccountId != null) {
                    Account acc2 = new Account();
            		acc2.Number_of_Contacts__c = 0;
                    acc2.Id = oldMap.get(con.Id).AccountId;
                	accountMap.put(acc2.Id, acc2);
                }    
            }
        }
        
        if(!accountMap.isEmpty()) {
            for(AggregateResult aggr : [SELECT count(Id) totalContacts, AccountId accId FROM Contact WHERE AccountId IN: accountMap.keySet() GROUP BY AccountId]) {
                accountMap.get((Id)aggr.get('accId')).Number_of_Contacts__c = Integer.valueOf(aggr.get('totalContacts'));
            }
            update accountMap.values();
        }
    }
}