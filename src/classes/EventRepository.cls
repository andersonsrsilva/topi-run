public with sharing class EventRepository {

    public List<Event> create (List<Event> events) {
        insert events;
        return events;
    }

}