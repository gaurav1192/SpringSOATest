public with sharing class SpringSOAController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getRecentAccounts() {
        List<Account> recentAccountList = new List<Account>();
        for(Account acc : [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10]) {
            recentAccountList.add(acc);
        }
        return recentAccountList;
    }
}