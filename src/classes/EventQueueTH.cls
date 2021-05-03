/**
 * @author ercaval - Topi
 */
public with sharing class EventQueueTH extends TriggerHandler {

    public List<Queue__c> newEvents;
    public Map<Id, Queue__c> oldEvents;


    public EventQueueTH () {
        this ( (List<Queue__c>) Trigger.new, (Map<Id, Queue__c>) Trigger.oldMap);
    }

    public EventQueueTH (List<Queue__c> newEvents, Map<Id, Queue__c> oldEvents) {
        this.newEvents = newEvents;
        this.oldEvents = oldEvents;
    }

    override
    public void afterInsert() {
        dequeue ();
    }


    override
    public void afterUpdate() {
        dequeue ();
    }

    public void dequeue () {

        if ( System.isBatch() || System.isFuture() ) {
            System.debug('DeQueueProcessor Esta sendo chamada em future ' );
            return;
        }
        
        Map<String, String> events = new Map<String, String>();

        Integer i = 0;

        for (Queue__c event : newEvents) {
    
            if (event.status__c != EventQueueStatusType.QUEUED.name()) continue;
    
            // Controle de Callouts, so pode ser realizado 100 simultaneos.
            if (i == EventExecutor.FUTURE_CALL_SIZE) {
                EventExecutor.processEvents(events);
                events = new Map<String, String>();
                i = 0;
            }
    
            events.put(event.id, event.eventName__c);
            i++;
        }
    
        if (events.size() > 0) {
            System.debug('DeQueueProcessor - Process last batch ' + events.size() );
            EventExecutor.processEvents(events);
        }


    }

}