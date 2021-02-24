/*
*@author anderson.silva
*/

public with sharing class AccountValidator {

    public List<Account> validateDocumentNumber(List<Account> accounts) {

        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        for (Account account : accounts) {

            if(!validator.isCPF(account.DocumentNumber__c) && !validator.isCNPJ(account.DocumentNumber__c)) {
                account.addError('CPF ou CNPJ inválido');
            }

        }

        return accounts;
    }

    public List<Account> validatePremiumAccount(List<Account> accounts) {

        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        for (Account account : accounts) {

            if(account.Category__c == Account.Type.PREMIUM && account.AnnualRevenue >= '1000000') {
                System.debug(schedulingEvent(account));
            }
        }

        return accounts;
    }

    String schedulingEvent(Account account) {
        List<String> row = new List<String>();
        row.add('Descrição (Description): Apresentar o portifolio de Produtos para o novo cliente com enfoque em nossa carteira Premium');
        row.add('Assunto (Subject): Apresentação instucional dos produtos Premium');
        row.add('Data e Hora de Início (StartDateTime): ' + Datetime.now().addDays(1));
        row.add('Data e Hora de Fim (EndDateTime): ' + Datetime.now().addDays(1).addHours(1));
        row.add('Relativo a (WhatId): ' + account.AccountNumber);
        row.add('Tipo de Contato (ContactType__c): ' + account.Phone);
        return String.join(row, '');
    }

}