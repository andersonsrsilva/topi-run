@isTest
public class AccountFilterTest {

    //BDD given When Then
    @isTest
    static void filterAccountsByDocumentNumberTest() {

        List<Account> accounts = new List<Account> {
            AccountFixtureFactory.createAccount('Teste01', 100000000 , Account.Type.PREMIUM),
            AccountFixtureFactory.createAccount('Teste02', 15000 , Account.Type.STANDARD)
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedDocumentNumber(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());

        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, new Map<Id,Account>());

        System.assertEquals(accounts.size(), filteredAccounts.size());

        Map<Id,Account> oldAccounts = new Map<Id, Account>(accounts);

        Account changedAccount = accounts.get(0).clone(true, true, true, true);
        changedAccount.DocumentNumber__c = 'X';
        oldAccounts.put(changedAccount.Id, changedAccount);

        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, oldAccounts);

        System.assertNotEquals(accounts.size(), filteredAccounts.size());
        System.assert(filteredAccounts.size() == 1);

        accounts = new List<Account>();
        accounts.add(new Account(Name = 'Teste01'));
        accounts.add(new Account(Name = 'Teste02'));

        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, null);

        System.assert(filteredAccounts.isEmpty());

    }
}