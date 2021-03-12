public class EventTransformer {

    public Event toEvent(Account account) {

        return new Event(
            Description = 'Apresentar o portifolio de Produtos para o novo cliente com enfoque em nossa carteira Premium',
            Subject = 'Apresentação instucional dos produtos Premium',
            StartDateTime = buildStartDate(account.CreatedDate),
            EndDateTime = event.StartDateTime.addHours(1),
            WhatId = account.Id,
            ContactType__c = 'Telefônico'
        );

    }

    private Datetime buildStartDate(Datetime createDate) {
        Time scheduleTime = Time.newInstance(14, 0, 0, 0);
        return Datetime.newInstance(createDate.date().addDays(1), scheduleTime);
    }

}