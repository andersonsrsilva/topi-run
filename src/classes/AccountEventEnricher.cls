public class AccountEventEnricher {

    EventRepository repository;

    public AccountEventEnricher() {
        repository = new EventRepository();
    }

    public List<Event> createSheduleEventForPremiunAccount(List<Account> premiumAccounts) {
        List<Event> events = new List<Event>();
        
        EventTransformer transformer = new EventTransformer();

        for(Account account : premiumAccounts) {
            events.add(transformer.toEvent(account));
        }

        return repository.create(events);
    }



}