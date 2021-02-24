/*
* @author anderson.silva
*/

public class AccountFixtureFactory {

    public static Account newAccount(String name, String documentNumber) {
        return new Account(
            Name = name,
            DocumentNumber__c = documentNumber
        );
    }

    public static Account createAccount(String name, String documentNumber) {
        return createAccount (newAccount(name, documentNumber));
    }

    public static Account newAccount(String name, String documentNumber, String category, Decimal annualRevenue) {
        return new Account(
            Name = name,
            DocumentNumber__c = documentNumber,
            Category__c = category,
            AnnualRevenue = annualRevenue
        );
    }

    public static Account createAccount(String name, String documentNumber, String category, Decimal annualRevenue) {
        return createAccount (newAccount(name, documentNumber, category, annualRevenue));
    }

    public static Account createAccount(Account account) {
        insert account;
        return account;
    }

}