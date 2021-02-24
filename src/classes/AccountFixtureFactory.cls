/*
* @author anderson.silva
*/

public class AccountFixtureFactory {

    public static Account newAccount(String name, Decimal annualRevenue, String category) {
        return new Account(
            Name = name,
            AnnualRevenue = annualRevenue,
            Category__c = category
        );
    }

    public static Account createAccount(String name, String documentNumber, Decimal billing) {
        return createAccount (newAccount(name, documentNumber, billing));
    }

    public static Account createAccount(Account account) {
        insert account;
        return account;
    }

}