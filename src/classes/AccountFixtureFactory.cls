/**
 * @author: ercarval - topi
 */
@isTest
public class AccountFixtureFactory {

    public static Account newAccount(String name) {
        return new Account(
                   Name = name);
    }

    public static Account createAccount(String name) {
        return createAccount ( newAccount (name));
    }

    public static Account createAccount (Account account) {

        insert account;
        return account;

    }
    

    // public static Account newAccount(String name, Decimal annualRevenue, String category) {
    //     return new Account(
    //         Name = name,
    //         AnnualRevenue = annualRevenue,
    //         Category__c = category
    //     );
    // }

    // public static Account newAccount(String name, Decimal annualRevenue, String category, String documentNumber) {
    //     return new Account(
    //         Name = name,
    //         AnnualRevenue = annualRevenue,
    //         Category__c = category,
    //         DocumentNumber__c = documentNumber
    //     );
    // }

    // public static Account createAccount(String name, Decimal annualRevenue, String category) {
    //     return createAccount (newAccount(name, annualRevenue, category));
    // }

    // public static Account createAccount(String name, Decimal annualRevenue, String category, String documentNumber) {
    //     return createAccount (newAccount(name, annualRevenue, category, documentNumber));
    // }

    // public static Account createAccount(Account account) {
    //     insert account;
    //     return account;
    // }


}