/**
 * @author: ercarval - TOPi
 */
@isTest
private class AccountRepositoryTest {

    @isTest
    static void givenIdfromAccountWhenFindForThisReturnAccountInstance() {

        Account account = AccountFixtureFactory.createAccount('One');

        System.assert ( account.Id != null);

        AccountRepository repository = new AccountRepository();

        Account storedAccount = repository.findOne (account.Id);

        System.assert ( account.Id == storedAccount.Id);

    }

}