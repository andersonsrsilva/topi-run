/**
 * @author: ercarval - topi
 */
@isTest
public class AbstractRepositoryTest {


    @isTest
    public static void givenValidAccountWhenSaveThenCreateRecordId () {

        Account account = AccountFixtureFactory.newAccount ('One');

        AccountRepository repository = new AccountRepository();

        repository.save (account);

        System.assert ( account.Id != null);

        account.Name = 'One Plus';
        repository.save (account);

        System.assert ( account.Id != null);
        System.assert ( account.Name == 'One Plus');



    }

    @isTest
    public static void givenValidAccountWhenSaveAllThenAllCreateRecordId () {

        Account account = AccountFixtureFactory.newAccount ('One');

        AccountRepository repository = new AccountRepository();

        repository.save (new List<SObject> {account});

        System.assert ( account.Id != null);

        account.Name = 'One Plus';
        repository.save (account);

        System.assert ( account.Id != null);
        System.assert ( account.Name == 'One Plus');



    }

    @isTest
    public static void givenValidStoredAccountWhenUpdateAllThenStoreAllChangesIntoAccounts () {

        Account account = AccountFixtureFactory.newAccount ('One');

        AccountRepository repository = new AccountRepository();

        repository.insertAll (new List<SObject> {account});

        System.assert ( account.Id != null);

        account.Name = 'One Plus';

        repository.updateAll (new List<SObject> {account});

        System.assert ( account.Id != null);
        System.assert ( account.Name == 'One Plus');



    }


}