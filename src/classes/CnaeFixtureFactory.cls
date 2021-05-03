/*
* @author anderson.silva
*/

@isTest
public class CnaeFixtureFactory {

    public static CNAE__c newCnae() {
        return new CNAE__c(Cnae__C = '23123', Description = 'xxxxx');
    }

    public static CNAE__c createCnae() {
        return createCnae(newCnae());
    }

    public static CNAE__c createCnae(CNAE__c Cnae) {
        insert Cnae;
        return Cnae;
    }

}