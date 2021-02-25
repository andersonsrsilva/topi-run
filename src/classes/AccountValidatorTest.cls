/*
* @author anderson.silva
*/

@isTest
public class AccountValidatorTest {

    AccountValidator validator = new AccountValidator();

    //BDD given When Then
    @isTest
    static void givenWhenValidateDocumentNumber() {

        List<Account> accounts = new List<Account> {
            AccountFixtureFactory.createAccount('Teste01', '72107358010', Account.Type.PREMIUM, 10000000)
        };

        AccountValidator validator = new AccountValidator();

        List<Account> validatededAccounts = this.validator.validateDocumentNumberTest(accounts);

        System.assertEquals(accounts.get(0).Name, validatededAccounts.get(0).Name);
    }

    static void givenWhenValidatePremiumAccount() {
        accounts = new List<Account> {
            AccountFixtureFactory.createAccount('Teste01', '72107358010')
        };

        List<Account> validatededAccounts = this.validator.validatePremiumAccount(accounts);

        System.assertEquals(accounts.size(), validatededAccounts.size());
    }

    static void givenWhenSchedulingEvent() {
        Account account = AccountFixtureFactory.createAccount('Teste01', '72107358010');
        account.AccountNumber = '1';
        account.Phone = '999999999';

        String text = this.validator.schedulingEvent(account);

        System.assertEquals(String.isNotEmpty(text) && text.contains('999999999'));
    }

}