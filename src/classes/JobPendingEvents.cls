/**
 *
 * @author: ercarval
 */
public class JobPendingEvents implements Schedulable {

    public static Integer jobCountForTest = 0;

    public void execute(SchedulableContext sc) {
        EventExecutor.processPendingEvents();
    }

    /**
     * Start Schedule execution for this class
     */
    public static void start ()  {
        new ScheduleHelper().scheduleIntoMinutesInterval(  new JobPendingEvents() , 5);
    }

    public static void abort () {
        new ScheduleHelper().abort ('JobPendingEvents');
    }

}