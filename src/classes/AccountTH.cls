/*
* @author anderson.silva
*/

public virtual class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    Map<Id, Account> oldAccounts;

    AccountFilter filter;
    AccountValidator validator;

    public AccountTH() {
        this((List<Account>) Trigger.new, (Map<Id, Account>) Trigger.oldMap);
    }

    public AccountTH(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;
        
        this.filter = new AccountFilter();
        this.validator = new AccountValidator();
    }

    virtual
    override
    public void beforeInsert() {
        System.debug('Trigger de Conta verificada insert ' + Trigger.operationType);
        validateDocumentNumber();
    }

    virtual
    override
    public void beforeUpdate() {
        System.debug('Trigger de Conta verificada update ' + Trigger.operationType);
        validateDocumentNumber();
    }

    virtual
    override
    public void afterInsert() {
        System.debug('Trigger de Conta acionada ' + Trigger.operationType);
        System.debug(JSON.serialize(newAccounts));
        validatePremiumAccount();
    }

    virtual
    override
    public void afterUpdate() {
        System.debug('Trigger de Conta atualizada ' + Trigger.operationType);
        System.debug(JSON.serialize(newAccounts));
        System.debug(JSON.serialize(oldAccounts));
    }

    virtual
    public void validateDocumentNumber() {
        List<Account> filteredAccounts = this.filter.filterByChangedDocumentNumber(newAccounts, oldAccounts);
        this.validator.validateDocumentNumber(filteredAccounts);
    }

    virtual
    public void validatePremiumAccount() {
        List<Account> filteredAccounts = this.filter.filterByChangedDocumentNumber(newAccounts, oldAccounts);
        this.validator.validatePremiumAccount(filteredAccounts);
    }

}