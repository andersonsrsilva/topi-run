/**
 * @author ercarval - topi
 */
@isTest
public class FilterTest {


    public static List<Account> setupAccounts() {

        List<Account> accounts = new List<Account> ();
        
        Account accountOne = AccountFixtureFactory.newAccount ('One Account');
        accountOne.Type = 'Consulting';
        accountOne.BillingStreet = 'BillingStreet';
        
        Account accountTwo = AccountFixtureFactory.newAccount ('Two Account');
        accountTwo.Type = 'Health Care';
        accountTwo.BillingStreet = 'BillingStreet';

        accounts.add(accountOne);
        accounts.add(accountTwo);

        insert accounts;

        return accounts;
        
    }


    @isTest
    public static void givenChangedRecordsWhenFilterByRelevantFieldsThenReturnOnlyRecordsWithChanges () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();
        
        Map<Id, Account> oldAccounts = new Map<Id, Account> {
            newAccounts.get(0).Id => newAccounts.get(0).clone(true, true, true)
            , newAccounts.get(1).Id => newAccounts.get(1).clone(true, true, true)
        };

        oldAccounts.get( newAccounts.get(1).Id ).BillingStreet = 'BillingStreet0'; 

        List<Account> accounts = filter.relevantChangeRecordsFilter(newAccounts, oldAccounts, new String[] { 'BillingStreet'});

        System.assertEquals(1, accounts.size());

    }


    @isTest
    public static void givenChangedRecordsWhenFilterByRelevantFieldsWithSpecificValueThenReturnOnlyRecordsWithChanges () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();
        
        Map<Id, Account> oldAccounts = new Map<Id, Account> {
            newAccounts.get(0).Id => newAccounts.get(0).clone(true, true, true)
            , newAccounts.get(1).Id => newAccounts.get(1).clone(true, true, true)
        };

        oldAccounts.get( newAccounts.get(1).Id ).BillingStreet = 'BillingStreet0'; 

        List<Account> accounts = filter.relevantChangeRecordsFilter(newAccounts
                    , oldAccounts
                    , 'BillingStreet'
                    , 'BillingStreet');

        System.assertEquals(1, accounts.size());

    }

}