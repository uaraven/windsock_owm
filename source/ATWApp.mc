import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
import Toybox.Time;

import OWM;
import ATWUtils;

const FIVE_MINUTES = new Time.Duration(5 * 60);
const ONE_MINUTE = new Time.Duration(1 * 60);

(:background)
class ATWApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();

        System.println("register for temporal event");
        // Background.registerForTemporalEvent(new Time.Duration(5*60));
        var lastTime = Background.getLastTemporalEventTime();        
        var schedule = Time.now().add(ONE_MINUTE);
        if (lastTime != null) {
            schedule = lastTime.add(FIVE_MINUTES);
        } else {
            if (schedule.greaterThan(lastTime)) {
                schedule = lastTime;
            } 
        }
        var f = ATWUtils.formatTime(schedule);
        System.println("Scheduling for " + f);
        Background.registerForTemporalEvent(schedule);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        if (!OWM.inBackground) {
            System.println("Deleting temporal event");
            Background.deleteTemporalEvent();
        } else {
            System.println("Background app stop");
        }
    }

    //! Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new ATWView() ] as Array<Views or InputDelegates>;
    }

    function getServiceDelegate() as ServiceDelegate {
        return [new OWM.OWMServiceDelegate()];
    }

    function onBackgroundData(data) {
        System.println("Got background data: "+ data);
        OWM.windData = data;
    }

}

function getApp() as ATWApp {
    return Application.getApp() as ATWApp;
}