/**
 *
 * @author: ercarval
 */
public class JobRetryEventProcessor implements Schedulable {

    public JobRetryEventProcessor() {
    }

    public void execute(SchedulableContext sc) {
        EventExecutor.processErrorEvents();
    }

    /**
     * Start Schedule execution for this class
     */
    public static void start ()  {
        new ScheduleHelper().scheduleIntoMinutesInterval(  new JobRetryEventProcessor() , 8);
    }

    public static void abort () {
        new ScheduleHelper().abort ('JobRetryEventProcessor');
    }

}