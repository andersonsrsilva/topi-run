/*
* @author anderson.silva
*/

@isTest
public class AccountValidatorTest {

        //BDD given When Then
        @isTest
        static void validateDocumentNumberTest() {

            List<Account> accounts = new List<Account> {
                AccountFixtureFactory.createAccount('Teste01', '72107358010', Account.Type.PREMIUM, 10000000)
            };

            AccountValidator validator = new AccountValidator();

            List<Account> validatededAccounts = filter.validateDocumentNumberTest(accounts);

            System.assertEquals(accounts.size(), validatededAccounts.size());

            accounts = new List<Account> {
                AccountFixtureFactory.createAccount('Teste01', '72107358010')
            };

            System.assertEquals(accounts.size(), validatededAccounts.size());

            
        }
        //validatePremiumAccountTest
        //schedulingEventTest

}